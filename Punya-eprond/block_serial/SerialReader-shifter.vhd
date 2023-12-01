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
        error_out : out std_logic_vector(1 downto 0) := "00";
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

    signal mode_selector : std_logic; -- '0' for encrypt '1' for decrypt
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
    signal regout_enable_signal : std_logic;
    signal regout_enable_buffer : std_logic_vector(6 downto 0);

    type states is (idle, start, read_kw, read_whitespace, read_attributes, read_startdata, read_data);
    signal c_state, n_state : states;

    signal temp_type : std_logic_vector(1 downto 0) := "00";
    signal temp_checkout : std_logic := '0';
    signal checkout_buffer : std_logic_vector(7 downto 0);
    signal done_mode, done_key, done_data : std_logic := '0';
    signal done_checkout : std_logic;

begin 

    reader_data_type <= temp_type;
    shifter_8bit_datain <= reader_data_in;

    shifter_8bit : Custom64BitShifter generic map(8)
    port map(clock, trigger_shift, max_shift, shifter_8bit_datain, shifter_8bit_dataout);

    shifter_4bit : Custom64BitShifter generic map(4)
    port map(clock, trigger_shift, max_shift, shifter_4bit_datain, shifter_4bit_dataout);

    regout : Reg generic map (64)
        port map (clock, regout_enable, '1', regout_datain, reader_data_out);

    dataout_mux : MUX2Data generic map (64)
        port map(mode_selector, shifter_8bit_dataout, shifter_4bit_dataout, regout_datain);

    asciitohex : ascii2hex port map(reader_data_in, shifter_4bit_datain);

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

            -- make pulse for regout enable signal
            regout_enable_buffer <= regout_enable_buffer(5 downto 0) & regout_enable_signal;
            if (regout_enable_buffer = "0011111") then regout_enable <= '1';
            elsif (regout_enable_buffer = "1111111") then regout_enable <= '0';
            end if;

            -- make pulse for checkout signal
            checkout_buffer <= checkout_buffer(6 downto 0) & temp_checkout;
            if (checkout_buffer = "00111111") then reader_data_checkout <= '1';
            elsif (checkout_buffer = "11111111") then reader_data_checkout <= '0';
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

    reader_fsm : process(reader_trigger)
    begin
        if (reader_enable = '1') then

        -- only check state when triggered
        if rising_edge(reader_trigger) then     
            case c_state is
            when idle =>
                temp_checkout <= '0';
                error_out <= "00";
                done_mode <= '0'; done_key <= '0'; done_data <='0'; done_checkout <= '0';
                regout_enable_signal <= '0'; trigger_shift_signal <= '0';
                reader_done <= '0'; mode_selector <= '0';
                max_shift <= '0';

                -- reset both reg bank selector
                data_4bit_counter <= (others => '0');
                data_8bit_counter <= (others => '0');

                if (reader_finish = '0') then
                    n_state <= read_kw;
                end if;

            when start => -- wait for "-"
                max_shift <= '1'; -- reset the shifter by max shifting
                regout_enable_signal <= '0'; -- dont enable the reg out yet
                temp_checkout <= '0';

                -- reset both reg bank selector
                data_4bit_counter <= (others => '0');
                data_8bit_counter <= (others => '0');

                if (reader_data_in = "00101101") then -- ASCII "-"
                    n_state <= read_kw;
                elsif (reader_data_in = "00100000") then -- ASCII " "
                    n_state <= c_state;       
                else
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_kw => -- read type keyword
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
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_whitespace => -- read whitespace (" ")
                if (reader_data_in = "00100000") then -- ASCII " "
                    if (temp_type = "11") then
                        mode_selector <= temp_mode;
                        n_state <= read_data;
                    else
                        n_state <= read_attributes;
                    end if;
                else -- Send error if wrong format
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_attributes => -- read xtea mode and key
                max_shift <= '0';
                regout_enable_signal <= '0';
                temp_checkout <= '0';
                done_checkout <= '0';

                -- count how many data has been in
                data_4bit_counter <= data_4bit_counter + 1;
                data_8bit_counter <= data_8bit_counter + 1;

                -- shift the data every new data in
                trigger_shift_signal <= not trigger_shift_signal;

                if (temp_type = "10") then
                    regout_enable_signal <= '1';
                    temp_checkout <= '1';
                    done_mode <= '1';
                    if (reader_data_in = "00110000") then -- ASCII "0"
                        temp_mode <= '0';
                        n_state <= start;
                    elsif (reader_data_in = "00110001") then -- ASCII "1"
                        temp_mode <= '1';
                        n_state <= start;
                    else -- Send error if wrong format
                        error_out <= "01";
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
                        regout_enable_signal <= '1';
                        temp_checkout <= '1';
                        n_state <= start;
                    else
                        if (data_8bit_counter = "111") then
                            regout_enable_signal <= '1';
                            temp_checkout <= '1';
                        end if;
                    end if;
                end if;

            when read_data => -- read input data
                max_shift <= '0';
                temp_checkout <= '0';
                done_checkout <= '0';
                regout_enable_signal <= '0';
                done_data <= '1';

                -- count how many data has been in
                data_4bit_counter <= data_4bit_counter + 1;
                data_8bit_counter <= data_8bit_counter + 1;

                -- shift the data every new data in
                trigger_shift_signal <= not trigger_shift_signal;

                if (data_8bit_counter = "111" and mode_selector = '0') then
                    regout_enable_signal <= '1';
                    temp_checkout <= '1';
                    done_checkout <= '1';
                elsif (data_4bit_counter = "1111" and mode_selector = '1') then
                    regout_enable_signal <= '1';
                    temp_checkout <= '1';
                    done_checkout <= '1';
                end if;

                -- finish if no data is longer received
                if (reader_finish = '1') then
                    
                    -- trigger checkout if not yet checked out
                    if (done_checkout = '0') then
                        done_checkout <= '1';
                        temp_checkout <= '1';
                        regout_enable_signal <= '1';
                        max_shift <= '1';
                    end if;

                    -- check if all inputs are done
                    if (done_mode = '1' or done_key = '1' or done_data = '1') then  
                        reader_done <= '1';
                    else -- error if not all is done
                        error_out <= "01";
                    end if;

                    n_state <= idle;
                end if;

            when others => n_state <= idle;
            end case;
        end if;
        end if;
    end process reader_fsm;
end behavioral;