library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity PulseGenerator is
    generic(pulse_width, pulse_max : natural; pulse_offset : natural := 0);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        pulse_enable : in std_logic;
        pulse_reset : in std_logic;
        pulse_out : out std_logic
    );
end entity PulseGenerator;

architecture behavioral of PulseGenerator is
    signal counter : natural range 0 to (pulse_max-1);
    signal pulse_reset1 : std_logic;

    function both_edge(signal1, signal2 : std_logic) return boolean is
        variable result_signal : std_logic;
    begin
        result_signal := (signal1 and not signal2) or
                        (not signal1 and signal2);
        return result_signal = '1';
    end function both_edge;
begin
    main : process(clock)
    begin
        if (nreset = '0') then
            counter <= 0;
            pulse_out <= '0';
        elsif rising_edge(clock) then

            -- reset for both edges
            pulse_reset1 <= pulse_reset;
            if both_edge(pulse_reset, pulse_reset1) then
                counter <= 0;
            elsif (counter < pulse_offset + pulse_width - 1) then
                counter <= counter + 1;
            end if;

            if (pulse_enable = '1') then
                if (counter >= pulse_offset and counter < pulse_offset + pulse_width - 1) then
                    pulse_out <= '1';
                else
                    pulse_out <= '0';
                end if;
                
            end if;
        end if;
    end process main;
end behavioral;