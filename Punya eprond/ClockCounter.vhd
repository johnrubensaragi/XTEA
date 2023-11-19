library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ClockCounter is
    generic(count_length : natural);
    port(
        clock : in std_logic;
        creset : in std_logic;
        count : out std_logic_vector((count_length-1) downto 0)
    );
end ClockCounter;

architecture behavioral of ClockCounter is
    signal counter : std_logic_vector((count_length-1) downto 0) := (others => '0');
begin
    process(clock, creset)
    begin
        if rising_edge(creset) or falling_edge(creset) then
            counter <= (others => '0');
        elsif rising_edge(clock) then
            counter <= counter + 1;
        end if;
    end process;
 
    count <= counter;
end behavioral;