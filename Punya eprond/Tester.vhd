library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Tester is
    port(
        clk : in std_logic;
        nrst : in std_logic := '1';
        xin, yin : inout std_logic_vector(7 downto 0);
        rout : out std_logic_vector(63 downto 0)
    );
end Tester;

architecture behavioral of Tester is
    constant default_key : std_logic_vector(127 downto 0) := x"6c7bd673045e9d5c29ac6c25db7a3191";
    constant data_length : natural := 64;
    constant address_length : natural := 10;
    component SRAM is
        generic (address_length, data_length : natural);
        port(
            clk : in std_logic;
            nrst : in std_logic;
            en_read, en_write : in std_logic;
            address : in std_logic_vector((address_length - 1) downto 0);
            data_in : in std_logic_vector((data_length - 1) downto 0);
            data_out : out std_logic_vector((data_length - 1) downto 0)
        );
    end component SRAM;

    signal en_read, en_write : std_logic;
    signal address : std_logic_vector((address_length - 1) downto 0);
    signal data_in, data_out : std_logic_vector((data_length - 1) downto 0);
    
    signal counter : std_logic_vector(3 downto 0) := (others => '0');
    signal temp_data : std_logic_vector((data_length - 1) downto 0) := (others => '0');
    signal temp_address : std_logic_vector((address_length - 1) downto 0) := (others => '0');
begin
    memory : SRAM 
    generic map(address_length, data_length) 
    port map(clk, nrst, en_read, en_write, address, data_in, data_out);
    
    process(clk)
    begin
        if rising_edge(clk) then
            if (nrst = '0') then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            case(counter) is
                when "0000" =>
                    temp_data <= default_key(127 downto 64);
                    temp_data(63 downto 56) <= xin;
                when "0001" => temp_data(55 downto 48) <= yin;
                when "0010" => temp_data(47 downto 40) <= xin;
                when "0011" => temp_data(39 downto 32) <= yin;
                when "0100" => temp_data(31 downto 24) <= xin;
                when "0101" => temp_data(23 downto 16) <= yin;
                when "0110" => temp_data(15 downto 8) <= xin;
                when "0111" =>
                    en_write <= '1';
                    data_in <= temp_data(63 downto 8) & yin;
                    address <= temp_address;
                    temp_address <= temp_address + 1;
                when others =>
                    en_read <= '1';
                    rout <= data_out;
            end case;
        end if;
    end process;
end behavioral;