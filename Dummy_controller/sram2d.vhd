library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity sram2d is
  generic (
    bitSize      : integer := 64; -- Ukuran bit data tersimpan
    addressLSize : integer := 2;  -- Ukuran address L = jumlah bit minimum untuk memuat L
    addressWSize : integer := 2   -- Ukuran address W = jumlah bit minimum untuk memuat W
  );
  port (
    clk     : in  std_logic;
    rd, wrt : in  std_logic;
    dataIn  : in  std_logic_vector(bitSize - 1 downto 0);
    address : in  std_logic_vector(addressWSize + addressLSize - 1 downto 0); -- NOTE: Sementara pake one-hot karena bingung cara menentukan jumlah bit yang diperlukannya; ubah addressL, addressW, dan pembacaan address jika address sudah dalam biner biasa (lupa namanya apa)

    dataOut : out std_logic_vector(bitSize - 1 downto 0)
  );
end entity;

architecture behavioral of sram2d is
  constant L : integer := 2 ** addressLSize;
  constant W : integer := 2 ** addressWSize;

  type t_datablocks is array (0 to L - 1, 0 to W - 1) of std_logic_vector(bitSize - 1 downto 0);
  signal r_datablock : t_datablocks := (others =>(others =>(others => '1'))); -- inisiasi key dan mode sementara di sini dulu
  alias addressL is address(addressWSize + addressLSize - 1 downto addressWSize); -- Koordinat address sepanjang L
  alias addressW is address(addressWSize - 1 downto 0);                           -- Koordinat address sepanjang W

begin
  process (clk)
  begin
    if rising_edge(clk) and wrt = '1' then
      -- if wrt = '1' then
      r_datablock(conv_integer(unsigned(addressL)), conv_integer(unsigned(addressW))) <= dataIn;
    end if;
  end process;

  process (rd, address)
  begin
    if rd = '1' then
      dataOut <= r_datablock(conv_integer(unsigned(addressL)), conv_integer(unsigned(addressW)));
      -- end if;
    end if;

  end process;

end architecture;
