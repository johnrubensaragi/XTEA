library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ClockDiv is
	generic(div_frequency, clock_frequency : natural);
	port(
		clock: in std_logic;
		div_out: buffer bit
	);
end ClockDiv;

architecture behavioral of ClockDiv is
begin
	process(clock)
		variable count: natural := 0;
		variable div : integer := conv_integer(clock_frequency/div_frequency);
	begin
		if rising_edge(clock) then
			if(count < div) then
				count := count + 1;						
				if(div_out = '0') then
					div_out <= '0';
				elsif(div_out = '1') then
					div_out <= '1';
				end if;
			else
				if(div_out = '0') then
					div_out <= '1';
				elsif(div_out = '1') then
					div_out <= '0';
				end if;
			count := 0;
			end if;
		end if;
	end process;
end behavioral;
		
	
	
	