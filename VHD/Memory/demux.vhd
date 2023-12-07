library ieee;
  use ieee.std_logic_1164.all;

entity demux is
  port (
    sel                                : in  std_logic_vector(1 downto 0);
    muxIn                              : in  std_logic;
    muxOut0, muxOut1, muxOut2, muxOut3 : out std_logic
  );
end entity;

architecture behavioral of demux is

begin

  process (sel, muxIn)
  begin
    case sel is
      when "00" =>
        muxOut0 <= muxIn;
        muxOut1 <= '0';
        muxOut2 <= '0';
        muxOut3 <= '0';
      when "01" =>
        muxOut0 <= '0';
        muxOut1 <= muxIn;
        muxOut2 <= '0';
        muxOut3 <= '0';
      when "10" =>
        muxOut0 <= '0';
        muxOut1 <= '0';
        muxOut2 <= muxIn;
        muxOut3 <= '0';
      when "11" =>
        muxOut0 <= '0';
        muxOut1 <= '0';
        muxOut2 <= '0';
        muxOut3 <= muxIn;
      when others =>
        null;
    end case;
  end process;

end architecture;
