library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX1Bit is
  port (
    selector : in std_logic;
    data_in1 : in std_logic;
    data_in2 : in std_logic;
    data_out : out std_logic
  );
end MUX1Bit;

architecture behavioral of MUX1Bit is
begin
    process(selector, data_in1, data_in2)
    begin
        case selector is
            when '0' => data_out <= data_in1;
            when '1' => data_out <= data_in2;
            when others =>
        end case;
    end process;
end behavioral;
