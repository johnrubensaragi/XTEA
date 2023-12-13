library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity memory is
  generic (
    bitSize     : integer := 64; -- Ukuran bit data tersimpan
    addressSize : integer := 10  -- Ukuran address L = jumlah bit minimum untuk memuat L
  );
  port (
    clk     : in  std_logic;
    rd, wrt : in  std_logic;
    dataIn  : in  std_logic_vector(bitSize - 1 downto 0);
    address : in  std_logic_vector(addressSize - 1 downto 0); -- NOTE: Sementara pake one-hot karena bingung cara menentukan jumlah bit yang diperlukannya; ubah addressL, addressW, dan pembacaan address jika address sudah dalam biner biasa (lupa namanya apa)

    dataOut : out std_logic_vector(bitSize - 1 downto 0)
  );
end entity;

architecture behavioral of memory is

  signal memory_address : std_logic_vector(1 downto 0);
  signal sram_address   : std_logic_vector(7 downto 0);

  signal dataIn0, dataIn1, dataIn2, dataIn3     : std_logic_vector(bitSize - 1 downto 0);
  signal rd0, rd1, rd2, rd3                     : std_logic;
  signal wrt0, wrt1, wrt2, wrt3                 : std_logic;
  signal dataOut0, dataOut1, dataOut2, dataOut3 : std_logic_vector(bitSize - 1 downto 0);

  component sram is
    generic (
      sramBitSize     : integer := 32; -- Ukuran bit data tersimpan
      sramAddressSize : integer := 8   -- Ukuran address L = jumlah bit minimum untuk memuat L
    );
    port (
      clk     : in  std_logic;
      rd, wrt : in  std_logic;
      dataIn  : in  std_logic_vector(sramBitSize - 1 downto 0);
      address : in  std_logic_vector(sramAddressSize - 1 downto 0); -- NOTE: Sementara pake one-hot karena bingung cara menentukan jumlah bit yang diperlukannya; ubah addressL, addressW, dan pembacaan address jika address sudah dalam biner biasa (lupa namanya apa)

      dataOut : out std_logic_vector(sramBitSize - 1 downto 0)
    );
  end component;

  component vector_mux is
    generic (
      bitSize : integer := 64 -- Ukuran bit data tersimpan
    );
    port (
      sel                            : in  std_logic_vector(1 downto 0);
      muxIn0, muxIn1, muxIn2, muxIn3 : in  std_logic_vector(bitSize - 1 downto 0);
      muxOut                         : out std_logic_vector(bitSize - 1 downto 0)
    );
  end component;

  component mux is
    port (
      sel                            : in  std_logic_vector(1 downto 0);
      muxIn0, muxIn1, muxIn2, muxIn3 : in  std_logic;
      muxOut                         : out std_logic
    );
  end component;

  component demux is
    port (
      sel                                : in  std_logic_vector(1 downto 0);
      muxIn                              : in  std_logic;
      muxOut0, muxOut1, muxOut2, muxOut3 : out std_logic
    );
  end component;

  component vector_demux is
    generic (
      bitSize : integer := 64 -- Ukuran bit data tersimpan
    );
    port (
      sel                                : in  std_logic_vector(1 downto 0);
      muxIn                              : in  std_logic_vector(bitSize - 1 downto 0);
      muxOut0, muxOut1, muxOut2, muxOut3 : out std_logic_vector(bitSize - 1 downto 0)
    );
  end component;

begin

  memory_address <= address(addressSize - 1 downto addressSize - 2);
  sram_address   <= address(addressSize - 3 downto 0);

  -- sram instances
  sram00: sram generic map (32, 8) port map (clk, rd0, wrt0, dataIn0(bitSize - 1 downto bitSize / 2), sram_address, dataOut0(bitSize - 1 downto bitSize / 2));
  sram01: sram generic map (32, 8) port map (clk, rd0, wrt0, dataIn0(bitSize / 2 - 1 downto 0), sram_address, dataOut0(bitSize / 2 - 1 downto 0));
  sram10: sram generic map (32, 8) port map (clk, rd1, wrt1, dataIn1(bitSize - 1 downto bitSize / 2), sram_address, dataOut1(bitSize - 1 downto bitSize / 2));
  sram11: sram generic map (32, 8) port map (clk, rd1, wrt1, dataIn1(bitSize / 2 - 1 downto 0), sram_address, dataOut1(bitSize / 2 - 1 downto 0));
  sram20: sram generic map (32, 8) port map (clk, rd2, wrt2, dataIn2(bitSize - 1 downto bitSize / 2), sram_address, dataOut2(bitSize - 1 downto bitSize / 2));
  sram21: sram generic map (32, 8) port map (clk, rd2, wrt2, dataIn2(bitSize / 2 - 1 downto 0), sram_address, dataOut2(bitSize / 2 - 1 downto 0));
  sram30: sram generic map (32, 8) port map (clk, rd3, wrt3, dataIn3(bitSize - 1 downto bitSize / 2), sram_address, dataOut3(bitSize - 1 downto bitSize / 2));
  sram31: sram generic map (32, 8) port map (clk, rd3, wrt3, dataIn3(bitSize / 2 - 1 downto 0), sram_address, dataOut3(bitSize / 2 - 1 downto 0));
  dataIn_demux: vector_demux port map (memory_address, dataIn, dataIn0, dataIn1, dataIn2, dataIn3);

  rd_demux: demux port map (memory_address, rd, rd0, rd1, rd2, rd3);
  wrt_demux: demux port map (memory_address, wrt, wrt0, wrt1, wrt2, wrt3);
  dataOut_mux0: vector_mux port map (memory_address, dataOut0, dataOut1, dataOut2, dataOut3, dataOut);

end architecture;
