library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

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
  component MUX2Data is
  generic (
    data_length : natural
  );
  port (
    selector : in std_logic;
    data_in1 : in std_logic_vector((data_length-1) downto 0);
    data_in2 : in std_logic_vector((data_length-1) downto 0);
    data_out : out std_logic_vector((data_length-1) downto 0)
  );
  end component MUX2Data;

  signal data_out1, data_out2 : std_logic_vector((data_length-1) downto 0);

begin
    mux1 : MUX2Data generic map(data_length) port map(selector(0), data_in1, data_in2, data_out1); 
    mux2 : MUX2Data generic map(data_length) port map(selector(0), data_in3, data_in4, data_out2);
    mux3 : MUX2Data generic map(data_length) port map(selector(1), data_out1, data_out2, data_out);

end architecture;
