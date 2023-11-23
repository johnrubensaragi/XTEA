library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MUX8Data is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic_vector(2 downto 0);
    data_in1 : in std_logic_vector((data_length-1) downto 0);
    data_in2 : in std_logic_vector((data_length-1) downto 0);
    data_in3 : in std_logic_vector((data_length-1) downto 0);
    data_in4 : in std_logic_vector((data_length-1) downto 0);
    data_in5 : in std_logic_vector((data_length-1) downto 0);
    data_in6 : in std_logic_vector((data_length-1) downto 0);
    data_in7 : in std_logic_vector((data_length-1) downto 0);
    data_in8 : in std_logic_vector((data_length-1) downto 0);
    data_out : out std_logic_vector((data_length-1) downto 0)
  );
end MUX8Data;

architecture behavioral of MUX8Data is
begin
    process(selector)
    begin
        case selector is
            when "000" => data_out <= data_in1;
            when "001" => data_out <= data_in2;
            when "010" => data_out <= data_in3;
            when "011" => data_out <= data_in4;
            when "100" => data_out <= data_in1;
            when "101" => data_out <= data_in2;
            when "110" => data_out <= data_in3;
            when "111" => data_out <= data_in4;
        end case;
    end process;
end architecture;
