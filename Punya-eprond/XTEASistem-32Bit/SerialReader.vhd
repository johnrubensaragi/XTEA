library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialReader is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        reader_enable : in std_logic;
        reader_trigger : in std_logic;
        reader_start : in std_logic;
        reader_done : out std_logic := '0';
        reader_finish : in std_logic;
        reader_convert : in std_logic;
        error_format : out std_logic := '0';
        reader_data_in : in std_logic_vector(7 downto 0);
        reader_data_out : out std_logic_vector(63 downto 0) := (others => '0');
        reader_data_type : out std_logic_vector(1 downto 0);
        reader_data_checkout : out std_logic
    );
end SerialReader;

architecture behavioral of SerialReader is
    component Reg is
    generic(data_length : natural);
    port(
        clock : in std_logic;
        enable : in std_logic;
        clear :  in std_logic;
        data_in : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component Reg;

    component Custom64BitShifter is
    generic(data_size : natural := 8);
    port(
        clock : in std_logic;
        trigger_shift : in std_logic;
        max_shift : in std_logic;
        data_in : in std_logic_vector((data_size-1) downto 0);
        data_out : out std_logic_vector(63 downto 0)
    );
    end component Custom64BitShifter;

    component MUX2Data is
    generic(data_length : natural);
    port(
        selector : in std_logic;
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX2Data;

    component ascii2hex is
    port(
        ascii   : in std_logic_vector(7 downto 0);
        hex     : out std_logic_vector(3 downto 0)
    );
    end component ascii2hex;

    component PulseGenerator
    generic(pulse_width, pulse_max : natural; pulse_offset : natural := 0);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        pulse_enable : in std_logic;
        pulse_reset : in std_logic;
        pulse_out : out std_logic
    );
    end component PulseGenerator;

    signal convert_selector : std_logic; -- '0' for no convert '1' for convert (ASCII -> HEX)
    signal temp_mode : std_logic;

    -- shifters inout
    signal shifter_8bit_datain : std_logic_vector(7 downto 0);
    signal shifter_8bit_dataout : std_logic_vector(63 downto 0);
    signal shifter_4bit_datain : std_logic_vector(3 downto 0);
    signal shifter_4bit_dataout : std_logic_vector(63 downto 0);
    signal trigger_shift, max_shift : std_logic;
    signal trigger_shift_signal : std_logic := '0';
    signal trigger_shift_buffer : std_logic_vector(4 downto 0);

    signal data_8bit_counter : std_logic_vector(2 downto 0);
    signal data_4bit_counter : std_logic_vector(3 downto 0);

    -- regout inout
    signal regout_datain : std_logic_vector(63 downto 0);
    signal regout_enable : std_logic;
    signal regout_trigger : std_logic;

    -- pulse gen inout
    signal regout_pulse_enable, checkout_pulse_enable : std_logic := '0';

    type states is (idle, start, read_kw, read_whitespace, read_attributes, read_startdata, read_data);
    signal c_state, n_state : states;

    signal temp_type : std_logic_vector(1 downto 0) := "00";
    signal checkout_trigger : std_logic := '0';
    signal done_mode, done_key, done_data : std_logic := '0';
    signal done_checkout : std_logic;
    signal internal_done : std_logic := '0';

begin 

    reader_data_type <= temp_type;
    shifter_8bit_datain <= reader_data_in;
    reader_done <= internal_done;

    -- shifters for 8 bit data and 4 bit data
    shifter_8bit : Custom64BitShifter generic map(8)
    port map(clock, trigger_shift, max_shift, shifter_8bit_datain, shifter_8bit_dataout);

    shifter_4bit : Custom64BitShifter generic map(4)
    port map(clock, trigger_shift, max_shift, shifter_4bit_datain, shifter_4bit_dataout);

    -- register for temporary data output
    regout : Reg generic map (64)
        port map (clock, regout_enable, '1', regout_datain, reader_data_out);

    dataout_mux : MUX2Data generic map (64)
        port map(convert_selector, shifter_8bit_dataout, shifter_4bit_dataout, regout_datain);

    asciitohex : ascii2hex port map(reader_data_in, shifter_4bit_datain);

    -- pulse gen for regout register and checkout
    regout_pulse : PulseGenerator generic map(2, 32, 20)
        port map(clock, nreset, regout_pulse_enable, regout_trigger, regout_enable);
    checkout_pulse : PulseGenerator generic map(5, 32, 21)
        port map(clock, nreset, checkout_pulse_enable, checkout_trigger, reader_data_checkout);

    pulse_signals : process(clock)
    begin
        if rising_edge(clock) then

            -- make pulse for shifters trigger
            trigger_shift_buffer <= trigger_shift_buffer(3 downto 0) & trigger_shift_signal;
            if (trigger_shift_buffer = "11110" or trigger_shift_buffer = "00001") then
                trigger_shift <= '1';
            elsif (trigger_shift_buffer = "00000" or trigger_shift_buffer = "11111") then
                trigger_shift <= '0';
            end if;

        end if;
    end process pulse_signals;

    next_state : process(clock)
    begin
        if (nreset = '0') then
            c_state <= idle;
        elsif rising_edge(clock) then
            if (reader_enable = '1') then
                c_state <= n_state;
            end if;
        end if;
    end process next_state;

    reader_fsm : process(reader_trigger, nreset)
    begin
        if (nreset = '0') then -- to reset if error
            error_format <= '0';
        else

        -- only check state when triggered
        if rising_edge(reader_trigger) then
        
            -- finish if no data is longer received
            if (reader_finish = '1' and done_mode = '1') then
                
                -- trigger checkout if not yet checked out
                if (done_checkout = '0') then
                    done_checkout <= '1';
                    checkout_trigger <= not checkout_trigger;
                    regout_trigger <= not regout_trigger;
                    max_shift <= '1';
                end if;

                -- check if all inputs are done
                if (done_mode = '1' and done_key = '1' and done_data = '1') then  
                    internal_done <= not internal_done;
                else -- error if not all is done
                    error_format <= '1';
                end if;

                n_state <= idle;
            else
     
            case c_state is
            when idle =>

                -- initialization
                checkout_trigger <= '0'; regout_trigger <= '0'; 
                checkout_pulse_enable <= '0'; regout_pulse_enable <= '0';
                done_mode <= '0'; done_key <= '0'; done_data <='0'; done_checkout <= '0';
                trigger_shift_signal <= '0';
                convert_selector <= '0';
                max_shift <= '0';

                -- reset both reg bank selector
                data_4bit_counter <= (others => '0');
                data_8bit_counter <= (others => '0');

                if (reader_finish = '0') then
                    n_state <= read_kw;
                end if;

            when start => -- wait for "-"
                max_shift <= '1'; -- reset the shifter by max shifting

                -- reset both reg bank selector
                data_4bit_counter <= (others => '0');
                data_8bit_counter <= (others => '0');

                if (reader_data_in = "00101101") then -- ASCII "-"
                    n_state <= read_kw;
                elsif (reader_data_in = "00100000") then -- ASCII " "
                    n_state <= c_state;       
                else
                    error_format <= '1';
                    n_state <= idle;
                end if;

            when read_kw => -- read type keyword
                regout_pulse_enable <= '1';
                checkout_pulse_enable <= '1';
                if (reader_data_in = "01101011") then -- ASCII "k"
                    if (done_mode = '1' and done_key = '0' and done_data = '0') then -- to make sure the input is in order
                        temp_type <= "00";
                        n_state <= read_whitespace;
                    end if;
                elsif (reader_data_in = "01101101") then -- ASCII "m"
                    if (done_mode = '0' and done_key = '0' and done_data = '0') then -- to make sure the input is in order
                        temp_type <= "10";
                        n_state <= read_whitespace;
                    end if;
                elsif (reader_data_in = "01100100") then -- ASCII "d"
                    if (done_mode = '1' and done_key = '1' and done_data = '0') then -- to make sure the input is in order
                        temp_type <= "11";
                        n_state <= read_whitespace;
                    end if;
                else -- Send error if wrong format
                    error_format <= '1';
                    n_state <= idle;
                end if;

            when read_whitespace => -- read whitespace (" ")
                if (reader_data_in = "00100000") then -- ASCII " "
                    if (temp_type = "11") then

                        -- convert input data to hex if ordered
                        if (reader_convert = '1') then
                            convert_selector <= temp_mode;
                        else
                            convert_selector <= '0';
                        end if;
                        
                        n_state <= read_data;
                    else
                        n_state <= read_attributes;
                    end if;
                else -- Send error if wrong format
                    error_format <= '1';
                    n_state <= idle;
                end if;

            when read_attributes => -- read xtea mode and key
                max_shift <= '0';
                done_checkout <= '0';

                -- count how many data has been in
                data_4bit_counter <= data_4bit_counter + 1;
                data_8bit_counter <= data_8bit_counter + 1;

                -- shift the data every new data in
                trigger_shift_signal <= not trigger_shift_signal;

                if (temp_type = "10") then
                    regout_trigger <= not regout_trigger;
                    checkout_trigger <= not checkout_trigger;
                    done_mode <= '1';
                    if (reader_data_in = "00110000") then -- ASCII "0"
                        temp_mode <= '0';
                        n_state <= start;
                    elsif (reader_data_in = "00110001") then -- ASCII "1"
                        temp_mode <= '1';
                        n_state <= start;
                    else -- Send error if wrong format
                        error_format <= '1';
                        n_state <= idle;
                    end if;
                else
                    done_key <= '1';

                    -- change to appropriate type
                    if (data_4bit_counter <= "0111") then
                        temp_type <= "00";
                    else
                        temp_type <= "01";
                    end if;

                    if (reader_data_in = "00100000") then -- ASCII " "
                        max_shift <= '1';
                        regout_trigger <= not regout_trigger;
                        checkout_trigger <= not checkout_trigger;
                        n_state <= start;
                    else
                        if (data_8bit_counter = "111") then
                            regout_trigger <= not regout_trigger;
                            checkout_trigger <= not checkout_trigger;
                        end if;
                    end if;
                end if;

            when read_data => -- read input data
                max_shift <= '0';
                done_checkout <= '0';
                done_data <= '1';

                -- count how many data has been in
                data_4bit_counter <= data_4bit_counter + 1;
                data_8bit_counter <= data_8bit_counter + 1;

                -- shift the data every new data in
                trigger_shift_signal <= not trigger_shift_signal;

                if (data_8bit_counter = "111" and convert_selector = '0') then
                    regout_trigger <= not regout_trigger;
                    checkout_trigger <= not checkout_trigger;
                    done_checkout <= '1';
                elsif (data_4bit_counter = "1111" and convert_selector = '1') then
                    regout_trigger <= not regout_trigger;
                    checkout_trigger <= not checkout_trigger;
                    done_checkout <= '1';
                end if;

            when others => n_state <= idle;
            end case;
        end if;
        end if;
        end if;
    end process reader_fsm;
end behavioral;