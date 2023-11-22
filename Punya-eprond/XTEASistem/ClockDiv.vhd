library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ClockDiv is
	generic(div_frequency, clock_frequency : natural);
	port(
		clock_in: in std_logic;
		clock_out: out std_logic
	);
end ClockDiv;

architecture behavioral of ClockDiv is
	signal internal_clock : std_logic := '0';
begin
	process(clock_in)
		variable count: natural := 0;
		variable div : integer := clock_frequency/div_frequency;
	begin
		if (clock_in'event and clock_in = '1') then
			if(count < div) then
				count := count + 1;						
			else
				internal_clock <= not internal_clock;
				count := 0;
			end if;
		end if;
	end process;

	clock_out <= internal_clock;	
end behavioral;
		
	
	
	