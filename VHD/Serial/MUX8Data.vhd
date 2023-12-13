library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

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

  component MUX4Data is
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
  end component MUX4Data;

  signal data_out1, data_out2 : std_logic_vector((data_length-1) downto 0);

begin
    mux1 : MUX4Data generic map(data_length) port map(selector(1 downto 0), data_in1, data_in2, data_in3, data_in4, data_out1); 
    mux2 : MUX4Data generic map(data_length) port map(selector(1 downto 0), data_in5, data_in6, data_in7, data_in8, data_out2);
    mux3 : MUX2Data generic map(data_length) port map(selector(2), data_out1, data_out2, data_out);

end architecture;
