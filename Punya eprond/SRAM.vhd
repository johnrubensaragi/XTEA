library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity SRAM is
    generic (address_length, data_length : natural);
    port(
        clk : in std_logic;
        nrst : in std_logic;
        en_read, en_write : in std_logic;
        address : in std_logic_vector((address_length - 1) downto 0);
        data_in : in std_logic_vector((data_length - 1) downto 0);
        data_out : out std_logic_vector((data_length - 1) downto 0)
    );
end SRAM;

architecture behavioral of SRAM is
    type ram_type is array (0 to (2**(address_length - 1)) of std_logic_vector((data_length - 1) downto 0))
    signal ram : ram_type;
begin
    if rising_edge(clk) then
        if (nrst = '0') then
            ram <= (others => (others => '0'));
        else
            temp_address <= address; 
            if (en_read = '1') then
                data_out <= ram(conv_integer(unsigned(address)));
            elsif (en_write = '1') then
                ram(conv_integer(unsigned(address))) <= data_in;
            end if;
        end if;
    end if;
end behavioral;