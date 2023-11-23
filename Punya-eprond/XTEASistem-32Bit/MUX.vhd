library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity MUX is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic;
    data_in1 : in std_logic_vector((data_length-1) downto 0);
    data_in2 : in std_logic_vector((data_length-1) downto 0);
    data_out : out std_logic_vector((data_length-1) downto 0)
  );
end entity;

architecture behavioral of MUX is
begin
    process(selector)
    begin
        case selector is
            when '0' => data_out <= data_in1;
            when '1' => data_out <= data_in2;
        end case;
    end process;
end architecture;
