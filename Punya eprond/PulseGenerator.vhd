library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity PulseGenerator is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        pulse_enable : in std_logic;
        pulse_out : out std_logic
    );
end entity PulseGenerator;

architecture behavioral of PulseGenerator is

begin
end behavioral;