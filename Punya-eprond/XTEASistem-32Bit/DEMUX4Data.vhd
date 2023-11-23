library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DEMUX4Data is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic_vector(1 downto 0);
    data_out1 : out std_logic_vector((data_length-1) downto 0);
    data_out2 : out std_logic_vector((data_length-1) downto 0);
    data_out3 : out std_logic_vector((data_length-1) downto 0);
    data_out4 : out std_logic_vector((data_length-1) downto 0);
    data_in : in std_logic_vector((data_length-1) downto 0)
  );
end DEMUX4Data;

architecture behavioral of DEMUX4Data is
begin
    process(selector)
    begin
        case selector is
            when "00" => data_out1 <= data_in;
            when "01" => data_out2 <= data_in;
            when "10" => data_out3 <= data_in;
            when "11" => data_out4 <= data_in;
        end case;
    end process;
end architecture;
