library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity sram is
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
end entity;

architecture behavioral of sram is
  constant L : integer := 2 ** sramAddressSize;

  type t_datablocks is array (0 to L - 1) of std_logic_vector(sramBitSize - 1 downto 0);
  signal r_datablock : t_datablocks := (others =>(others => '1')); -- inisiasi key dan mode sementara di sini dulu

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if rd = '1' then
        dataOut <= r_datablock(to_integer(unsigned(address)));
      end if;
      if wrt = '1' then
        r_datablock(to_integer(unsigned(address))) <= dataIn;
      end if;
    end if;
  end process;

end architecture;
