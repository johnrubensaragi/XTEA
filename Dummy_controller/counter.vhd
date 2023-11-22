library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.numeric_std.all;

entity counter is
  generic (
    outputSize : integer := 4;
    max        : integer := 16
  );
  port (
    i_clk               : in  std_logic;
    i_countup           : in  std_logic;
    i_rst               : in  std_logic;
    i_rst_to_attributes : in  std_logic;

    o_count             : out std_logic_vector(outputSize - 1 downto 0)
  );
end entity;

architecture behavioral of counter is
  signal count : integer := 0;
begin
  process (i_clk, i_countup)
  begin
    if rising_edge(i_clk) then
      if (i_countup = '1') and (count < max) then
        count <= count + 1;
        o_count <= std_logic_vector(to_unsigned(count + 1, outputSize)); -- supaya tidak lag, langsung assign di clock itu juga
      elsif (i_rst = '1') then
        count <= 3; -- initial data address
        o_count <= std_logic_vector(to_unsigned(3, outputSize));
      elsif (i_rst_to_attributes = '1') then
        count <= 0; -- initial data address
        o_count <= std_logic_vector(to_unsigned(0, outputSize));
      else
        count <= count;
        o_count <= std_logic_vector(to_unsigned(count, outputSize));
      end if;
    end if;
  end process;
end architecture;
