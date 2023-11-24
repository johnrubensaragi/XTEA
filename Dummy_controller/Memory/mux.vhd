library ieee;
  use ieee.std_logic_1164.all;

entity mux is
  port (
    sel                            : in  std_logic_vector(1 downto 0);
    muxIn0, muxIn1, muxIn2, muxIn3 : in  std_logic;
    muxOut                         : out std_logic
  );
end entity;

architecture behavioral of mux is

begin

  process (sel, muxIn0, muxIn1, muxIn2, muxIn3)
  begin
    case sel is
      when "00" =>
        muxOut <= muxIn0;
      when "01" =>
        muxOut <= muxIn1;
      when "10" =>
        muxOut <= muxIn2;
      when "11" =>
        muxOut <= muxIn3;
      when others =>
        null;
    end case;
  end process;

end architecture;
