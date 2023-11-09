library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ReadSerialTest is
    generic(data_length, address_length : natural);
    port(
        clk : in std_logic;
        nrst : in std_logic;
        start_read : in std_logic;
        read_in : in std_logic_vector(7 downto 0);
        check_error : out std_logic;
        store_address : out std_logic_vector((address_length - 1 ) downto 0);
        store_data :out std_logic_vector((data_length - 1) downto 0);
        done : out std_logic;
    );
end ReadSerialTest;
        
architecture behavioral of ReadSerialTest is
    constant default_key : std_logic_vector(127 downto 0) := x"6c7bd673045e9d5c29ac6c25db7a3191";

    type states is (idle, start, read_kw, read_whitemode, read_whitekey, read_whitedata, read_mode, read_key, read_data);
    signal c_state, n_state : states;

    signal temp_data : std_logic_vector((data_length - 1) downto 0) := (others => '0'); 
    signal temp_address std_logic_vector((address_length - 1 ) downto 0) := (1|0 => '1', others => '0');
    signal done_mode, done_key, done_data : std_logic;
    signal counter : std_logic_vector(3 downto 0);
begin
    process(clk, nrst)
    begin
        if rising_edge(clk) then
            if (nrst = '0') then
                c_state <= idle;
            else
                c_state <= n_state;
            end if;
        end if;
    end process

    process(rst, nrst, c_state)
    begin
        case(c_state) is
        when idle =>
            counter <= (others => '0');
            if (start_read = '1') then
                n_state <= start;
            else
                n_state <= c_state;
            end if;
            
        when start =>
            if (read_in = "00101101") then -- ASCII "-"
                counter <= (others => '0');
                n_state <= s_mode;
            else
                n_state <= c_state;
            end if;

        when read_kw =>
            if (read_in = "01101101" and done_mode /= '1') then -- ASCII "m"
                n_state <= read_whitemode;
            elsif (read_in = "01101011" and done_key /= '1') then -- ASCII "k"
                n_state <= read_whitekey;
            elsif (read_in = "01100100" and done_data /= '1') then -- ASCII "d"
                n_state <= read_whitedata;
            else -- Send error if wrong format
                check_error = '1';
                n_state <= idle;
            end if;

        when read_whitemode =>
            if (read_in = "00100000") then -- ASCII " "
                temp_data <= (others => '0');
                temp_address <= (others => '0');
                done_mode <= '1';
                n_state <= read_mode;
            else -- Send error if wrong format
                check_error = '1';
                n_state <= idle;
            end if;

        when read_whitekey =>
            if (read_in = "00100000") then -- ASCII " "
                temp_data <= default_key(127 downto 64);
                done_key <= '1';
                n_state <= read_key;
            else -- Send error if wrong format
                check_error = '1';
                n_state <= idle;
            end if;

        when read_whitedata =>
            if (read_in = "00100000") then -- ASCII " "
                temp_data <= (others => '0');
                temp_address <= (1|0 => '1', others => '0');
                done_data <= '1';
                n_state <= read_data;
            else -- Send error if wrong format
                check_error = '1';
                n_state <= idle;
            end if;

        when read_mode =>
            if (read_in = "00110000") then -- ASCII "0"
                address <= temp_address;
                store_data <= temp_data(63 downto 8) & read_in;
                n_state <= start;
            elsif (read_in = "00110001") then -- ASCII "1"
                address <= temp_address;
                store_data <= temp_data(63 downto 8) & read_in;
                n_state <= start;            
            else -- Send error if wrong format
                check_error = '1';
                n_state <= idle;
            end if;

        when read_key =>
            if (counter = "0000") then
                if (read_in = "00101101") then -- ASCII "-"
                    counter <= (others => '0');    
                    n_state <= read_kw;
                elsif (read_in = "00100000") then -- ASCII " "
                    check_error = '1';
                    n_state = idle;
                else
                    temp_address <= (0 => '1', others => '0');
                    temp_data(63 downto 56) <= read_in;
                    counter <= counter + 1;
                end if;
            else
                if (read_in = "00100000") then -- ASCII " "
                    address <= temp_address;
                    store_data <= store_data;
                    counter <= (others => '0');    
                    n_state <= start;
                else
                    -- Gabungkan menjadi 64-bit data sebelum disimpan
                    if (counter <= "0111") then
                        case(counter) is
                            when "0000" => temp_data(63 downto 56) <= read_in;
                            when "0001" => temp_data(55 downto 48) <= read_in;
                            when "0010" => temp_data(47 downto 40) <= read_in;
                            when "0011" => temp_data(39 downto 32) <= read_in;
                            when "0100" => temp_data(31 downto 24) <= read_in;
                            when "0101" => temp_data(23 downto 16) <= read_in;
                            when "0110" => temp_data(15 downto 8) <= read_in;
                            when "0111" =>
                                store_data <= temp_data(63 downto 8) & read_in;
                                address <= temp_address;
                                temp_address <= (1 => '1', others => '0');
                                temp_data <= default_key(63 downto 0);
                            when others =>
                        end case;
                    else
                        case(counter) is
                            when "1000" => temp_data(63 downto 56) <= read_in;
                            when "1001" => temp_data(55 downto 48) <= read_in;
                            when "1010" => temp_data(47 downto 40) <= read_in;
                            when "1011" => temp_data(39 downto 32) <= read_in;
                            when "1100" => temp_data(31 downto 24) <= read_in;
                            when "1101" => temp_data(23 downto 16) <= read_in;
                            when "1110" => temp_data(15 downto 8) <= read_in;
                            when "1111" =>
                                store_data <= temp_data(63 downto 8) & read_in;
                                address <= temp_address;
                                n_state <= start;
                            when others =>
                            end case;
                        end if;
                    counter <= counter + 1;
                end if;
            end if;

        when read_data =>
            if (temp_address = "0000000000") then
                check_error = '1';
                n_state = idle;
            else
                if (counter = "0000") then
                    if (read_in = "00100000") then -- ASCII " "
                        check_error = '1';
                        n_state = idle;
                    else
                        temp_data(63 downto 56) <= read_in;
                        counter <= counter + 1;
                    end if;
                else
                    if (read_in = "00100000") then
                        store_data <= temp_data;
                        store_address <= temp_address;
                        n_start <= start;
                    else
                        case(counter) is
                            when "0000" => temp_data(63 downto 56) <= read_in;
                            when "0001" => temp_data(55 downto 48) <= read_in;
                            when "0010" => temp_data(47 downto 40) <= read_in;
                            when "0011" => temp_data(39 downto 32) <= read_in;
                            when "0100" => temp_data(31 downto 24) <= read_in;
                            when "0101" => temp_data(23 downto 16) <= read_in;
                            when "0110" => temp_data(15 downto 8) <= read_in;
                            when "0111" =>
                                store_data <= temp_data(63 downto 8) & read_in;
                                store_address <= temp_address;
                                temp_address <= temp_address + 1;
                                temp_data <= (others => '0');
                            when others =>
                        end case;
                    end if;
                end if;
            end if;

        when others =>
            n_state <= idle;
        end case;
    end process;
end behavioral;