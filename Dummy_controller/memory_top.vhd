library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity memory_top is
end entity;

architecture behavioral of memory_top is
  signal clk, rd, wrt    : std_logic;
  signal dataIn, dataOut : std_logic_vector(63 downto 0);
  signal address         : std_logic_vector(9 downto 0);
  component memory is
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
  end component;
begin
  memory0: memory port map (clk, rd, wrt, dataIn, address, dataOut);

end architecture;
