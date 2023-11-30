library ieee;
use ieee.std_logic_1164.all;

entity hex2ascii is
    port(
        hex     : in std_logic_vector(3 downto 0);
        ascii   : out std_logic_vector(7 downto 0)
    );
end hex2ascii;

architecture arc of hex2ascii is
begin
    process(hex)
    begin
        if   (hex = x"0") then ascii <= x"30";
        elsif(hex = x"1") then ascii <= x"31";
        elsif(hex = x"2") then ascii <= x"32";
        elsif(hex = x"3") then ascii <= x"33";
        elsif(hex = x"4") then ascii <= x"34";
        elsif(hex = x"5") then ascii <= x"35";
        elsif(hex = x"6") then ascii <= x"36";
        elsif(hex = x"7") then ascii <= x"37";
        elsif(hex = x"8") then ascii <= x"38";
        elsif(hex = x"9") then ascii <= x"39";
        elsif(hex = x"A") then ascii <= x"41";
        elsif(hex = x"B") then ascii <= x"42";
        elsif(hex = x"C") then ascii <= x"43";
        elsif(hex = x"D") then ascii <= x"44";
        elsif(hex = x"E") then ascii <= x"45";
        elsif(hex = x"F") then ascii <= x"46";
        end if;
    end process;
end arc;