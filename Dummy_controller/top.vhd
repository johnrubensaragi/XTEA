library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity top is
  generic (
    bitSize      : integer := 64; -- Ukuran bit data tersimpan
    addressLSize : integer := 2;  -- Ukuran address L = jumlah bit minimum untuk memuat L
    addressWSize : integer := 2   -- Ukuran address W = jumlah bit minimum untuk memuat W
  );
  port (enable         : in std_logic;
        nreset         : in std_logic;
        clk            : in std_logic;

        -- control input signals
        serial_running : in std_logic;
        serial_done    : in std_logic;
        error_check    : in std_logic;

        -- input data
        serial_output  : in std_logic_vector(bitSize - 1 downto 0)
       );

end entity;

architecture behavioral of top is

  -- memory
  signal r_enable_read  : std_logic;
  signal r_enable_write : std_logic;
  signal r_address      : std_logic_vector(addressLSize + addressWSize - 1 downto 0);
  signal r_dataIn       : std_logic_vector(bitSize - 1 downto 0);
  signal r_dataOut      : std_logic_vector(bitSize - 1 downto 0);
  signal r_mux0         : std_logic_vector(bitSize - 1 downto 0); -- dari serial
  signal r_mux1         : std_logic_vector(bitSize - 1 downto 0); -- dari memory
  signal r_mux_sel      : std_logic;
  signal r_demux0       : std_logic_vector(bitSize - 1 downto 0); -- ke key1
  signal r_demux1       : std_logic_vector(bitSize - 1 downto 0); -- ke key2
  signal r_demux2       : std_logic_vector(bitSize - 1 downto 0); -- ke mode
  signal r_demux_sel    : std_logic_vector(1 downto 0);

  signal r_key : std_logic_vector(2 * bitSize - 1 downto 0);
  alias r_mode is r_demux2(0);

  -- xtea
  signal r_xtea_start : std_logic;
  -- signal mode         : std_logic; --0 jika enc, 1 jika dec
  signal r_xtea_done : std_logic; -- xtea_done

  component controlFSM is
    generic (
      bitSize      : integer := 8;
      AddressLSize : integer := 2;
      AddressWSize : integer := 2
    );
    port (
      enable         : in  std_logic;
      nreset         : in  std_logic;
      clk            : in  std_logic;

      -- control input signals
      serial_running : in  std_logic;
      serial_done    : in  std_logic;
      error_check    : in  std_logic;
      xtea_done      : in  std_logic;

      -- data input signals
      memory         : in  std_logic_vector(bitSize - 1 downto 0); -- dummy memory, untuk ngetes behavior ketika blok memory terisi atau kosong

      -- control output signals
      enable_read    : out std_logic;
      enable_write   : out std_logic;
      xtea_start     : out std_logic;
      dataIn_mux     : out std_logic;
      dataOut_demux  : out std_logic_vector(1 downto 0);

      -- data output signals
      address        : out std_logic_vector(AddressLSize + AddressWSize - 1 downto 0)
    );
  end component;

  component sram2d is
    generic (
      bitSize      : integer := bitSize;      -- Ukuran bit data tersimpan
      addressLSize : integer := addressLSize; -- Ukuran address L = jumlah bit minimum untuk memuat L
      addressWSize : integer := addressWSize  -- Ukuran address W = jumlah bit minimum untuk memuat W
    );
    port (
      clk     : in  std_logic;
      rd, wrt : in  std_logic;
      dataIn  : in  std_logic_vector(bitSize - 1 downto 0);
      address : in  std_logic_vector(addressWSize + addressLSize - 1 downto 0); -- NOTE: Sementara pake one-hot karena bingung cara menentukan jumlah bit yang diperlukannya; ubah addressL, addressW, dan pembacaan address jika address sudah dalam biner biasa (lupa namanya apa)

      dataOut : out std_logic_vector(bitSize - 1 downto 0)
    );
  end component;

  component xtea is
    port (
      d_in_ready  : in  std_logic;                      -- xtea_start
      d_in        : in  std_logic_vector(63 downto 0);  -- dari memory
      key         : in  std_logic_vector(127 downto 0); -- dari memory
      clk         : in  std_logic;
      mode        : in  std_logic;                      --0 jika enc, 1 jika dec
      d_out       : out std_logic_vector(63 downto 0);  -- ke memory
      d_out_ready : out std_logic                       -- xtea_done
    );
  end component;

begin

  controlFSM0: controlFSM
    generic map (
      bitSize      => bitSize,
      addressLSize => addressLSize,
      addressWSize => addressWSize
    )
    port map (
      enable         => enable,
      nreset         => nreset,
      clk            => clk,
      serial_running => serial_running,
      serial_done    => serial_done,
      error_check    => error_check,
      xtea_done      => r_xtea_done,
      memory         => r_dataOut,
      enable_read    => r_enable_read,
      enable_write   => r_enable_write,
      xtea_start     => r_xtea_start,
      dataIn_mux     => r_mux_sel,
      dataOut_demux  => r_demux_sel,
      address        => r_address
    );

  sram2d0: sram2d
    generic map (
      bitSize      => bitSize,
      addressLSize => addressLSize,
      addressWSize => addressWSize
    )
    port map (
      clk     => clk,
      rd      => r_enable_read,
      wrt     => r_enable_write,
      dataIn  => r_dataIn,
      address => r_address,
      dataOut => r_dataOut
    );

  xtea0: xtea
    port map (
      d_in_ready  => r_xtea_start,
      d_in        => r_dataOut,
      key         => r_key,
      clk         => clk,
      mode        => r_mode,
      d_out       => r_mux1,
      d_out_ready => r_xtea_done
    );

  process (r_mux0, r_mux1, r_mux_sel)
  begin
    if r_mux_sel = '0' then
      r_dataIn <= r_mux0;
    else
      r_dataIn <= r_mux1;
    end if;
  end process;

  process (r_dataOut, r_demux_sel)
  begin
    if r_demux_sel = "00" then
      r_demux0 <= r_dataOut;
    elsif r_demux_sel = "01" then
      r_demux1 <= r_dataOut;
    elsif r_demux_sel = "10" then
      r_demux2 <= r_dataOut;
    end if;
  end process;

  r_key <= r_demux0 & r_demux1;

end architecture;

