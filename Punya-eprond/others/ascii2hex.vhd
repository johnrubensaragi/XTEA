library ieee;
use ieee.std_logic_1164.all;

entity ascii2hex is
    port(
        ascii   : in std_logic_vector(7 downto 0);
        hex     : out std_logic_vector(3 downto 0)
    );
end ascii2hex;

architecture arc of ascii2hex is
begin
    process(ascii)
    begin
        if   (ascii = x"30") then hex <= x"0";
        elsif(ascii = x"31") then hex <= x"1";
        elsif(ascii = x"32") then hex <= x"2";
        elsif(ascii = x"33") then hex <= x"3";
        elsif(ascii = x"34") then hex <= x"4";
        elsif(ascii = x"35") then hex <= x"5";
        elsif(ascii = x"36") then hex <= x"6";
        elsif(ascii = x"37") then hex <= x"7";
        elsif(ascii = x"38") then hex <= x"8";
        elsif(ascii = x"39") then hex <= x"9";
        elsif(ascii = x"41") then hex <= x"A";
        elsif(ascii = x"42") then hex <= x"B";
        elsif(ascii = x"43") then hex <= x"C";
        elsif(ascii = x"44") then hex <= x"D";
        elsif(ascii = x"45") then hex <= x"E";
        elsif(ascii = x"46") then hex <= x"F";
        end if;
    end process;
end arc;