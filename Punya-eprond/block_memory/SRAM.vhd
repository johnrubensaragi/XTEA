library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SRAM is
    generic (data_length : integer := 32; address_length : integer := 8);
    port(
        clock : in std_logic;
        enable_write : in std_logic;
        memory_address : in std_logic_vector((address_length - 1) downto 0);
        memory_write : in std_logic_vector((data_length - 1) downto 0);
        memory_read : out std_logic_vector((data_length - 1) downto 0)
    );
end SRAM;

architecture behavioral of SRAM is
    type ram_type is array (0 to (2**address_length - 1)) of std_logic_vector((data_length - 1) downto 0);
    signal ram : ram_type := (others => (others => '0'));

    signal temp_data : std_logic_vector((data_length - 1) downto 0);
begin

    memory_read <= temp_data;

    process(clock)
    begin
        if rising_edge(clock) then
            temp_data <= ram(conv_integer(memory_address));
            if (enable_write = '1') then
                ram(conv_integer(memory_address)) <= memory_write;
            end if;
        end if;
    end process;

end behavioral;