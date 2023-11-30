library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialReader is
    generic(data_length, address_length : natural);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        reader_enable : in std_logic;
        reader_trigger : in std_logic;
        reader_start : in std_logic;
        reader_done : out std_logic := '0';
        error_out : out std_logic_vector(1 downto 0) := "00";
        reader_data_in : in std_logic_vector(7 downto 0);
        reader_data_out : out std_logic_vector((data_length - 1) downto 0) := (others => '0');
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
        data_in : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component Reg;

    component MUX2Data is
    generic(data_length : natural);
    port(
        selector : in std_logic;
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX2Data;

    -- registers inout
    signal regdata0_enable, regdata1_enable, regdata2_enable, regdata3_enable, regdata4_enable, regdata5_enable, regdata6_enable, regdata7_enable  : std_logic;
    signal reg_selector : std_logic_vector(2 downto 0);
    signal regdata_in : std_logic_vector(7 downto 0);
    signal regdata_master : std_logic_vector((data_length-1) downto 0);
    signal regdata_enable, regmaster_enable : std_logic;

    signal reset_enable : std_logic;
    signal reset_selector : std_logic;

    type states is (idle, start, read_kw, read_whitespace, read_attributes, read_startdata, read_data);
    signal c_state, n_state : states;

    signal temp_type : std_logic_vector(1 downto 0) := "00";
    signal temp_checkout : std_logic := '0';
    signal done_mode, done_key, done_data : std_logic := '0';
    signal done_leftkey, done_8char : std_logic;

begin 

    reader_data_type <= temp_type;
    reader_data_checkout <= temp_checkout;

    -- only enable the selected register
    regdata0_enable <= '1' and regdata_enable when (reg_selector = "000") else '0';
    regdata1_enable <= '1' and regdata_enable when (reg_selector = "001") else '0';
    regdata2_enable <= '1' and regdata_enable when (reg_selector = "010") else '0';
    regdata3_enable <= '1' and regdata_enable when (reg_selector = "011") else '0';
    regdata4_enable <= '1' and regdata_enable when (reg_selector = "100") else '0';
    regdata5_enable <= '1' and regdata_enable when (reg_selector = "101") else '0';
    regdata6_enable <= '1' and regdata_enable when (reg_selector = "110") else '0';
    regdata7_enable <= '1' and regdata_enable when (reg_selector = "111") else '0';

    regdata0 : Reg generic map (8) port map (clock, regdata0_enable, regdata_in, regdata_master(63 downto 56));
    regdata1 : Reg generic map (8) port map (clock, regdata1_enable, regdata_in, regdata_master(55 downto 48));
    regdata2 : Reg generic map (8) port map (clock, regdata2_enable, regdata_in, regdata_master(47 downto 40));
    regdata3 : Reg generic map (8) port map (clock, regdata3_enable, regdata_in, regdata_master(39 downto 32));
    regdata4 : Reg generic map (8) port map (clock, regdata4_enable, regdata_in, regdata_master(31 downto 24));
    regdata5 : Reg generic map (8) port map (clock, regdata5_enable, regdata_in, regdata_master(23 downto 16));
    regdata6 : Reg generic map (8) port map (clock, regdata6_enable, regdata_in, regdata_master(15 downto 8));
    regdata7 : Reg generic map (8) port map (clock, regdata7_enable, regdata_in, regdata_master(7 downto 0));

    regmaster : Reg generic map (data_length) port map (clock, regmaster_enable, regdata_master, reader_data_out);

    datain_mux : MUX2Data generic map (8) port map(reset_selector, reader_data_in, x"00", regdata_in);

    reset_registers : process(clock)
    begin
        if rising_edge(clock) then
            if (reset_enable = '1') then
                if (reg_selector = "111") then
                    
                    reg_selector <= reg_selector;
                else
                    reg_selector <= reg_selector + 1;
                end if;
            end if;
        end if;
    end process reset_registers;

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
        constant end_data_identifier : std_logic_vector(7 downto 0) := "00001010"; -- newline (LF)
    begin
        if (reader_enable = '1') then

        -- only check state when triggered
        if rising_edge(reader_trigger) then

            -- finish if read a newline character
            if (reader_data_in = end_data_identifier) then -- ASCII newline (LF)
                
                -- trigger checkout if yet checked out
                if (done_8char = '0') then temp_checkout <= not temp_checkout;
                end if;

                -- check if all inputs are done
                if (done_mode = '1' or done_key = '1' or done_data = '1') then  
                    reader_done <= '1';
                else -- error if not all is done
                    error_out <= "01";
                end if;

                n_state <= idle;
            else

            case c_state is
            when idle =>
                temp_checkout <= '0';
                error_out <= "00";
                done_mode <= '0';
                done_key <= '0';
                done_data <= '0';
                done_leftkey <= '0';
                done_8char <= '0';
                regdata_enable <= '0';
                regmaster_enable <= '0';
                reader_done <= '0';

                -- only start if it is started
                if (reader_start = '1') then
                    n_state <= read_kw;
                end if;

            when start => -- wait for "-"
                regdata_enable <= '0';
                regmaster_enable <= '0';

                if (reader_data_in = "00101101") then -- ASCII "-"
                    n_state <= read_kw;
                elsif (reader_data_in = "00100000") then -- ASCII " "
                    n_state <= c_state;       
                else
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_kw => -- read type keyword
                if (reader_data_in = "01101011" and done_key /= '1') then -- ASCII "k"
                    temp_type <= "00";
                    n_state <= read_whitespace;
                elsif (reader_data_in = "01101101" and done_mode /= '1') then -- ASCII "m"
                    temp_type <= "10";
                    n_state <= read_whitespace;
                elsif (reader_data_in = "01100100" and done_data /= '1') then -- ASCII "d"
                    temp_type <= "11";
                    n_state <= read_whitespace;
                else -- Send error if wrong format
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_whitespace => -- read whitespace (" ")
                if (reader_data_in = "00100000") then -- ASCII " "
                    if (temp_type = "11") then
                        n_state <= read_data;
                    else
                        n_state <= read_attributes;
                    end if;
                else -- Send error if wrong format
                    error_out <= "01";
                    n_state <= idle;
                end if;

            when read_attributes => -- read xtea mode and key
                reset_selector <= '0'; -- make sure dont reset the registers yet
                
                if (reader_data_in = "00100000") then --
                    regdata_enable <= '0';
                    n_state <= start;
                else
                    regdata_enable <= '1';
                    if (temp_type = "00") then
                        if (reader_data_in = "00110000" or reader_data_in = "00110001") then -- ASCII "0" or "1"
                            
                        else -- Send error if wrong format
                            error_out <= "01";
                            n_state <= idle;

                        end if;
                    else
                        reg_selector <= reg_selector + 1;
                    end if;
                end if;

            when read_data => -- read input data
                reg_selector <= reg_selector + 1;
                    -- change each 8 bit data based on counter
                if (int_counter = 0) then
                    done_8bit <= '0';
                    temp_data <= reader_data_in & empty_data(55 downto 0);
                    temp_type <= "11";
                else
                    temp_data((64-8*int_counter-1) downto 64-8*(int_counter+1)) <= reader_data_in;
                    if (int_counter = 7) then
                        done_8bit <= '1';
                        temp_checkout <= not temp_checkout;
                        counter <= "0000";
                    end if;
                end if;

            when others => n_state <= idle;
            end case;
        end if;
        end if;
        end if;
    end process reader_fsm;
end behavioral;