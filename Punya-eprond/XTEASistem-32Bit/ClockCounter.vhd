library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ClockCounter is
    generic(count_max : natural);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        enable : in std_logic;
        creset : in std_logic;
        count : out natural range 0 to (count_max-1)
    );
end ClockCounter;

architecture behavioral of ClockCounter is
    signal counter : natural range 0 to (count_max-1) := 0;
    signal creset1 : std_logic;

    function both_edge(signal1, signal2 : std_logic) return boolean is
        variable result_signal : std_logic;
    begin
        result_signal := (signal1 and not signal2) or
                        (not signal1 and signal2);
        return result_signal = '1';
    end function both_edge;

begin
    process(clock)
    begin
        if (nreset = '0') then
            counter <= 0;
        elsif rising_edge(clock) then
                creset1 <= creset;
                if both_edge(creset, creset1) or (counter = (count_max-1)) then
                    counter <= 0;
                else
                    if (enable = '1') then
                        counter <= counter + 1;
                    else
                        counter <= counter;
                    end if;
            end if;
        end if;
    end process;
 
    count <= counter;
end behavioral;