library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DEMUX2Data is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic;
    data_in : in std_logic_vector((data_length-1) downto 0);
    data_out1 : out std_logic_vector((data_length-1) downto 0);
    data_out2 : out std_logic_vector((data_length-1) downto 0)
  );
end DEMUX2Data;

architecture behavioral of DEMUX2Data is
begin
    process(selector, data_in)
    begin
        case selector is
            when '0' => data_out1 <= data_in; data_out2 <= (others => 'Z');
            when '1' => data_out2 <= data_in; data_out1 <= (others => 'Z');
            when others =>
        end case;
    end process;
end architecture;
