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

  --   signal dataIn0, dataIn1, dataIn2, dataIn3     : std_logic_vector(bitSize - 1 downto 0);
  --   signal dataOut0, dataOut1, dataOut2, dataOut3 : std_logic_vector(bitSize - 1 downto 0);
  --   signal address0, address1, address2, address3 : std_logic_vector(addressSize - 3 downto 0);
  signal dataIn0, dataIn1                           : std_logic_vector(bitSize / 2 - 1 downto 0);
  signal rd0, rd1, rd2, rd3, wrt0, wrt1, wrt2, wrt3 : std_logic;

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

begin

  memory_address <= address(addressSize - 1 downto addressSize - 2);
  sram_address   <= address(addressSize - 3 downto 0);
  dataIn1        <= dataIn(bitSize - 1 downto bitSize / 2);
  dataIn0        <= dataIn(bitSize / 2 - 1 downto 0);

  -- sram instances
  sram00: sram generic map (32, 8) port map (clk, rd0, wrt0, dataIn0, sram_address, dataOut(bitSize - 1 downto bitSize / 2));
  sram01: sram generic map (32, 8) port map (clk, rd0, wrt0, dataIn1, sram_address, dataOut(bitSize / 2 - 1 downto 0));

  sram10: sram generic map (32, 8) port map (clk, rd1, wrt1, dataIn0, sram_address, dataOut(bitSize - 1 downto bitSize / 2));
  sram11: sram generic map (32, 8) port map (clk, rd1, wrt1, dataIn1, sram_address, dataOut(bitSize / 2 - 1 downto 0));

  sram20: sram generic map (32, 8) port map (clk, rd2, wrt2, dataIn0, sram_address, dataOut(bitSize - 1 downto bitSize / 2));
  sram21: sram generic map (32, 8) port map (clk, rd2, wrt2, dataIn1, sram_address, dataOut(bitSize / 2 - 1 downto 0));

  sram30: sram generic map (32, 8) port map (clk, rd3, wrt3, dataIn0, sram_address, dataOut(bitSize - 1 downto bitSize / 2));
  sram31: sram generic map (32, 8) port map (clk, rd3, wrt3, dataIn1, sram_address, dataOut(bitSize / 2 - 1 downto 0));

  process (memory_address)
  begin
    case memory_address is
      when "00" =>
        rd0 <= '1';
        rd1 <= '0';
        rd2 <= '0';
        rd3 <= '0';
        wrt0 <= '1';
        wrt1 <= '0';
        wrt2 <= '0';
        wrt3 <= '0';
      when "01" =>
        rd0 <= '0';
        rd1 <= '1';
        rd2 <= '0';
        rd3 <= '0';
        wrt0 <= '0';
        wrt1 <= '1';
        wrt2 <= '0';
        wrt3 <= '0';
      when "10" =>
        rd0 <= '0';
        rd1 <= '0';
        rd2 <= '1';
        rd3 <= '0';
        wrt0 <= '0';
        wrt1 <= '0';
        wrt2 <= '1';
        wrt3 <= '0';
      when "11" =>
        rd0 <= '0';
        rd1 <= '0';
        rd2 <= '0';
        rd3 <= '1';
        wrt0 <= '0';
        wrt1 <= '0';
        wrt2 <= '0';
        wrt3 <= '1';
    end case;
  end process;

end architecture;
