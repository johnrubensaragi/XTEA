library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DEMUX4Data is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic_vector(1 downto 0);
    data_in : in std_logic_vector((data_length-1) downto 0);
    data_out1 : out std_logic_vector((data_length-1) downto 0);
    data_out2 : out std_logic_vector((data_length-1) downto 0);
    data_out3 : out std_logic_vector((data_length-1) downto 0);
    data_out4 : out std_logic_vector((data_length-1) downto 0)
  );
end DEMUX4Data;

architecture behavioral of DEMUX4Data is
  component DEMUX2Data is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic;
    data_in : in std_logic_vector((data_length-1) downto 0);
    data_out1 : out std_logic_vector((data_length-1) downto 0);
    data_out2 : out std_logic_vector((data_length-1) downto 0)
  );
  end component DEMUX2Data;

  signal demux1_data_out1, demux1_data_out2 : std_logic_vector((data_length-1) downto 0);

begin
    demux1 : DEMUX2Data generic map(data_length) port map(selector(1), data_in, demux1_data_out1, demux1_data_out2); 
    demux2 : DEMUX2Data generic map(data_length) port map(selector(0), demux1_data_out1, data_out1, data_out2);
    demux3 : DEMUX2Data generic map(data_length) port map(selector(0), demux1_data_out2, data_out3, data_out4);
  
end architecture;
