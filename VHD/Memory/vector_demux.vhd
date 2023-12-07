library ieee;
  use ieee.std_logic_1164.all;

entity vector_demux is
  generic (
    bitSize : integer := 64 -- Ukuran bit data tersimpan
  );
  port (
    sel                                : in  std_logic_vector(1 downto 0);
    muxIn                              : in  std_logic_vector(bitSize - 1 downto 0);
    muxOut0, muxOut1, muxOut2, muxOut3 : out std_logic_vector(bitSize - 1 downto 0)
  );
end entity;

architecture behavioral of vector_demux is

begin

  process (sel, muxIn)
  begin
    case sel is
      when "00" =>
        muxOut0 <= muxIn;
        muxOut1 <= (others => '0');
        muxOut2 <= (others => '0');
        muxOut3 <= (others => '0');
      when "01" =>
        muxOut0 <= (others => '0');
        muxOut1 <= muxIn;
        muxOut2 <= (others => '0');
        muxOut3 <= (others => '0');
      when "10" =>
        muxOut0 <= (others => '0');
        muxOut1 <= (others => '0');
        muxOut2 <= muxIn;
        muxOut3 <= (others => '0');
      when "11" =>
        muxOut0 <= (others => '0');
        muxOut1 <= (others => '0');
        muxOut2 <= (others => '0');
        muxOut3 <= muxIn;
      when others =>
        null;
    end case;
  end process;

end architecture;
