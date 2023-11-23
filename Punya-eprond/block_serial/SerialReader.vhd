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
        reader_finish : in std_logic;
        reader_done : out std_logic := '0';
        error_out : out std_logic_vector(1 downto 0) := "00";
        reader_data_in : in std_logic_vector(7 downto 0);
        reader_address_out : out std_logic_vector((address_length-1) downto 0) := (others => '0');
        reader_data_out : out std_logic_vector((data_length - 1) downto 0) := (others => '0')
    );
end SerialReader;

architecture behavioral of SerialReader is
    type states is (idle, start, read_kw, read_whitemode, read_whitekey, read_whitedata, read_mode, read_key, read_startdata, read_data);
    signal c_state, n_state : states;

    signal temp_data : std_logic_vector((data_length - 1) downto 0) := (others => '0'); 
    signal temp_address : std_logic_vector((address_length - 1 ) downto 0) := (others => '0');
    signal done_mode, done_key, done_data : std_logic := '0';
    signal counter : std_logic_vector(3 downto 0) := "0000";

begin
    next_state : process(clock)
    begin
        if (nreset = '0') then
            c_state <= idle;

        elsif rising_edge(clock) then
            if (reader_enable = '1') then
                -- if not yet started or already finished put on idle
                if (reader_finish = '1' or reader_start = '0') then 
                    c_state <= idle;
                else
                    c_state <= n_state;
                end if;
            end if;
        end if;
    end process next_state;

    reader_fsm : process(reader_trigger, reader_finish, nreset)
        constant default_key : std_logic_vector(127 downto 0) := x"6c7bd673045e9d5c29ac6c25db7a3191";
        constant empty_data : std_logic_vector((data_length-1) downto 0) := x"0000000000000000";
    begin
        if (nreset = '0') then
            reader_done <= '0';
            reader_address_out <= (others => '0');
            reader_data_out <= (others => '0');
            temp_data <= (others => '0');
            temp_address <= (others => '0');
            error_out <= "00";
            done_mode <= '0';
            done_key <= '0';
            done_data <= '0';

        elsif (reader_enable = '1') then

            -- check things when finished
            if (reader_finish = '1') then 

                -- dump data if not empty
                if (temp_data /= empty_data) then
                    reader_data_out <= temp_data;
                    reader_address_out <= temp_address;

                    -- check if all inputs are done
                    if (done_mode = '1' or done_key = '1' or done_data = '1') then  
                        reader_done <= '1';
                    else -- error if not all is done
                        error_out <= "01";
                    end if;
                end if;

            end if;

            -- only check state when triggered
            if (reader_trigger = '1') then
                case c_state is
                    when idle =>
                        -- only start if it is started
                        if (reader_start = '1') then
                            n_state <= read_kw;
                        end if;

                        reader_done <= '0';

                    when start =>
                        if (reader_data_in = "00101101") then -- ASCII "-"
                            n_state <= read_kw;
                        elsif (reader_data_in = "00100000") then -- ASCII " "
                            n_state <= c_state;       
                        else
                            error_out <= "01";
                            n_state <= idle;
                        end if;

                    when read_kw =>
                        if (reader_data_in = "01101101" and done_mode /= '1') then -- ASCII "m"
                            n_state <= read_whitemode;
                        elsif (reader_data_in = "01101011" and done_key /= '1') then -- ASCII "k"
                            n_state <= read_whitekey;
                        elsif (reader_data_in = "01100100" and done_data /= '1') then -- ASCII "d"
                            n_state <= read_whitedata;
                        else -- Send error if wrong format
                            error_out <= "01";
                            n_state <= idle;
                        end if;

                    when read_whitemode => -- read whitespace
                        if (reader_data_in = "00100000") then -- ASCII " "
                            temp_address <= (others => '0');
                            counter <= "0000";
                            n_state <= read_mode;
                        else -- Send error if wrong format
                            error_out <= "01";
                            n_state <= idle;
                        end if;

                    when read_whitekey => -- read whitespace
                        if (reader_data_in = "00100000") then -- ASCII " "
                            temp_address <= (0 => '1', others => '0');
                            counter <= "0000";
                            n_state <= read_key;
                        else -- Send error if wrong format
                            error_out <= "01";
                            n_state <= idle;
                        end if;

                    when read_whitedata => -- read whitespace
                        if (reader_data_in = "00100000") then -- ASCII " "
                            temp_address <= (1|0 => '1', others => '0');
                            n_state <= read_startdata;
                        else -- Send error if wrong format
                            error_out <= "01";
                            n_state <= idle;
                        end if;

                    when read_mode => -- read input mode
                        if (reader_data_in = "00110000") then -- ASCII "0"
                            reader_address_out <= temp_address;
                            reader_data_out <= empty_data(63 downto 8) & reader_data_in;
                            done_mode <= '1';
                            n_state <= start;
                        elsif (reader_data_in = "00110001") then -- ASCII "1"
                            reader_address_out <= temp_address;
                            reader_data_out <= empty_data(63 downto 8) & reader_data_in;
                            done_mode <= '1';
                            n_state <= start;            
                        else -- Send error if wrong format
                            error_out <= "01";
                            n_state <= idle;
                        end if;

                    when read_key => -- read input key
                        counter <= counter + 1;
                        if (counter = "0000") then
                            if (reader_data_in = "00101101") then -- ASCII "-"
                                done_key <= '1';
                                n_state <= read_kw;
                            elsif (reader_data_in = "00100000") then -- ASCII " "
                                error_out <= "01";
                                n_state <= idle;
                            else
                                temp_data <= reader_data_in & default_key(119 downto 64);
                                done_key <= '1';
                            end if;
                        else
                            if (reader_data_in = "00100000") then -- ASCII " "
                                reader_address_out <= temp_address;
                                reader_data_out <= temp_data;
                                done_key <= '1';
                                n_state <= start;
                            else
                                -- Gabungkan menjadi 64-bit data sebelum disimpan
                                if (counter <= "0111") then
                                    case(counter) is
                                        when "0000" => temp_data <= reader_data_in & default_key(119 downto 64);
                                        when "0001" => temp_data(55 downto 48) <= reader_data_in;
                                        when "0010" => temp_data(47 downto 40) <= reader_data_in;
                                        when "0011" => temp_data(39 downto 32) <= reader_data_in;
                                        when "0100" => temp_data(31 downto 24) <= reader_data_in;
                                        when "0101" => temp_data(23 downto 16) <= reader_data_in;
                                        when "0110" => temp_data(15 downto 8) <= reader_data_in;
                                        when "0111" =>
                                            reader_data_out <= temp_data(63 downto 8) & reader_data_in;
                                            reader_address_out <= temp_address;
                                            temp_address <= temp_address + 1;
                                        when others =>
                                    end case;
                                else
                                    case(counter) is
                                        when "1000" => temp_data <= reader_data_in & default_key(55 downto 0);
                                        when "1001" => temp_data(55 downto 48) <= reader_data_in;
                                        when "1010" => temp_data(47 downto 40) <= reader_data_in;
                                        when "1011" => temp_data(39 downto 32) <= reader_data_in;
                                        when "1100" => temp_data(31 downto 24) <= reader_data_in;
                                        when "1101" => temp_data(23 downto 16) <= reader_data_in;
                                        when "1110" => temp_data(15 downto 8) <= reader_data_in;
                                        when "1111" =>
                                            reader_data_out <= temp_data(63 downto 8) & reader_data_in;
                                            reader_address_out <= temp_address;
                                            n_state <= start;
                                        when others =>
                                        end case;
                                    end if;
                            end if;
                        end if;

                    when read_startdata => -- read start data keyword (")
                        if (reader_data_in = "00100010") then -- ASCII (")
                            counter <= "0000";
                            n_state <= read_data;
                        else
                            error_out <= "01";
                            n_state <= idle;
                        end if;

                    when read_data => -- read input data
                        counter <= counter + 1;
                        if (temp_address = "0000000000") then
                            error_out <= "10";
                            n_state <= idle;
                        else
                            if (reader_data_in = "00100010") then -- ASCII (")
                                reader_data_out <= temp_data;
                                reader_address_out <= temp_address;
                                done_data <= '1';
                                n_state <= start;
                            else
                                case(counter) is
                                    when "0000" => temp_data <= reader_data_in & empty_data(55 downto 0);
                                    when "0001" => temp_data(55 downto 48) <= reader_data_in;
                                    when "0010" => temp_data(47 downto 40) <= reader_data_in;
                                    when "0011" => temp_data(39 downto 32) <= reader_data_in;
                                    when "0100" => temp_data(31 downto 24) <= reader_data_in;
                                    when "0101" => temp_data(23 downto 16) <= reader_data_in;
                                    when "0110" => temp_data(15 downto 8) <= reader_data_in;
                                    when "0111" =>
                                        reader_data_out <= temp_data(63 downto 8) & reader_data_in;
                                        reader_address_out <= temp_address;
                                        temp_address <= temp_address + 1;
                                        temp_data <= (others => '0');
                                        counter <= "0000";
                                    when others =>
                                end case;
                            end if;
                        end if;

                    when others => n_state <= idle;

                end case;
            end if;
        end if;
    end process reader_fsm;
end behavioral;