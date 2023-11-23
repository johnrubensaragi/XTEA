library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MUX4Data is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic_vector(1 downto 0);
    data_in1 : in std_logic_vector((data_length-1) downto 0);
    data_in2 : in std_logic_vector((data_length-1) downto 0);
    data_in3 : in std_logic_vector((data_length-1) downto 0);
    data_in4 : in std_logic_vector((data_length-1) downto 0);
    data_out : out std_logic_vector((data_length-1) downto 0)
  );
end MUX4Data;

architecture behavioral of MUX4Data is
begin
    process(selector)
    begin
        case selector is
            when "00" => data_out <= data_in1;
            when "01" => data_out <= data_in2;
            when "10" => data_out <= data_in3;
            when "11" => data_out <= data_in4;
        end case;
    end process;
end architecture;
