library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity SRAM is
    generic (data_length, address_length : integer);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        enable_read, enable_write : in std_logic;
        memory_address : in std_logic_vector((address_length - 1) downto 0);
        memory_write : in std_logic_vector((data_length - 1) downto 0);
        memory_read : out std_logic_vector((data_length - 1) downto 0)
    );
end SRAM;

architecture behavioral of SRAM is
    type ram_type is array (0 to (2**address_length - 1)) of std_logic_vector((data_length - 1) downto 0);
    signal ram : ram_type := (others => (others => '0'));
begin
    process(clock, memory_address, enable_read, enable_write)
    begin
        if rising_edge(clock) then
            if (nreset = '0') then
                ram <= (others => (others => '0'));
            else
                if (enable_read = '1') then
                    memory_read <= ram(to_integer(unsigned(memory_address)));
                elsif (enable_write = '1') then
                    ram(to_integer(unsigned(memory_address))) <= memory_write;
                end if;
            end if;
        end if;
    end process;
end behavioral;