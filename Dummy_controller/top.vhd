library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity top is
  generic (
    bitSize     : integer := 64; -- Ukuran bit data tersimpan
    addressSize : integer := 10  -- Ukuran address L = jumlah bit minimum untuk memuat L
    -- addressWSize : integer := 2   -- Ukuran address W = jumlah bit minimum untuk memuat W
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
  signal r_dataIn       : std_logic_vector(bitSize - 1 downto 0);
  signal r_dataOut      : std_logic_vector(bitSize - 1 downto 0);
  signal r_enable_read  : std_logic;
  signal r_enable_write : std_logic;

  -- address
  signal r_address_countup       : std_logic;
  signal r_address_reset         : std_logic;
  signal r_address_to_attributes : std_logic;
  signal r_address               : std_logic_vector(addressSize - 1 downto 0);

  -- xtea
  signal r_xtea_start : std_logic;
  signal r_xtea_done  : std_logic;

  -- serial
  -- BELOM SABAR, sementara pake input dulu
  signal r_serial_running : std_logic;
  signal r_serial_done    : std_logic;
  signal r_error_check    : std_logic;

  -- mux
  signal r_mux0      : std_logic_vector(bitSize - 1 downto 0); -- dari serial
  signal r_mux1      : std_logic_vector(bitSize - 1 downto 0); -- dari memory
  signal r_mux_sel   : std_logic;
  signal r_demux0    : std_logic_vector(bitSize - 1 downto 0); -- ke key1
  signal r_demux1    : std_logic_vector(bitSize - 1 downto 0); -- ke key2
  signal r_demux2    : std_logic_vector(bitSize - 1 downto 0); -- ke mode
  signal r_demux3    : std_logic_vector(bitSize - 1 downto 0); -- ke d_in
  signal r_demux_sel : std_logic_vector(1 downto 0);

  signal r_key : std_logic_vector(2 * bitSize - 1 downto 0);
  alias r_mode is r_demux2(0);

  component controlFSM is
    generic (
      bitSize : integer := 8
    );
    port (
      enable                : in  std_logic;
      nreset                : in  std_logic;
      clk                   : in  std_logic;

      -- memory controls
      memory                : in  std_logic_vector(bitSize - 1 downto 0);
      enable_read           : out std_logic;
      enable_write          : out std_logic;

      -- address controls
      address_countup       : out std_logic;
      address_reset         : out std_logic;
      address_to_attributes : out std_logic;

      -- xtea controls
      xtea_done             : in  std_logic;
      xtea_start            : out std_logic;

      -- serial controls
      serial_running        : in  std_logic;
      serial_done           : in  std_logic;
      error_check           : in  std_logic;

      -- mux controls
      dataIn_mux            : out std_logic;
      dataOut_demux         : out std_logic_vector(1 downto 0)
    );
  end component;

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

  component counter is
    generic (
      outputSize : integer := addressSize;
      max        : integer := 2 **(addressSize)
    );
    port (
      i_clk               : in  std_logic;
      i_countup           : in  std_logic;
      i_rst               : in  std_logic;
      i_rst_to_attributes : in  std_logic;

      o_count             : out std_logic_vector(outputSize - 1 downto 0)
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
      bitSize => bitSize
    )
    port map (
      enable                => enable,
      nreset                => nreset,
      clk                   => clk,

      -- memory controls
      memory                => r_dataOut,
      enable_read           => r_enable_read,
      enable_write          => r_enable_write,

      -- address controls
      address_countup       => r_address_countup,
      address_reset         => r_address_reset,
      address_to_attributes => r_address_to_attributes,

      -- xtea controls
      xtea_done             => r_xtea_done,
      xtea_start            => r_xtea_start,

      -- serial controls
      serial_running        => serial_running,
      serial_done           => serial_done,
      error_check           => error_check,

      -- mux controls
      dataIn_mux            => r_mux_sel,
      dataOut_demux         => r_demux_sel
    );

  memory0: memory
    generic map (
      bitSize     => bitSize,
      addressSize => addressSize
    )
    port map (
      clk     => clk,
      rd      => r_enable_read,
      wrt     => r_enable_write,
      dataIn  => r_dataIn,
      address => r_address,
      dataOut => r_dataOut
    );

  addressCounter: counter
    generic map (
      outputSize => addressSize,
      max        => 2 **(addressSize)
    )
    port map (
      i_clk               => clk,
      i_countup           => r_address_countup,
      i_rst               => r_address_reset,
      i_rst_to_attributes => r_address_to_attributes,
      o_count             => r_address
    );

  xtea0: xtea
    port map (
      d_in_ready  => r_xtea_start,
      d_in        => r_demux3,
      key         => r_key,
      clk         => clk,
      mode        => r_mode,
      d_out       => r_mux1,
      d_out_ready => r_xtea_done
    );

  dataIn_mux: process (r_mux_sel, r_mux0, r_mux1)
  begin
    if r_mux_sel = '0' then
      r_dataIn <= r_mux0;
    else
      r_dataIn <= r_mux1;
    end if;
  end process;

  dataOut_demux: process (clk) -- SALAH, harusnya atribut yang mau masuk ke xtea disimpan dulu di register
  begin
    if rising_edge(clk) then
      if r_demux_sel = "00" then
        r_demux0 <= r_dataOut;
        r_demux1 <= r_demux1;
        r_demux2 <= r_demux2;
        r_demux3 <= r_demux3;
      elsif r_demux_sel = "01" then
        r_demux0 <= r_demux0;
        r_demux1 <= r_dataOut;
        r_demux2 <= r_demux2;
        r_demux3 <= r_demux3;
      elsif r_demux_sel = "10" then
        r_demux0 <= r_demux0;
        r_demux1 <= r_demux1;
        r_demux2 <= r_dataOut;
        r_demux3 <= r_demux3;
      elsif r_demux_sel = "11" then
        r_demux0 <= r_demux0;
        r_demux1 <= r_demux1;
        r_demux2 <= r_demux2;
        r_demux3 <= r_dataOut;
      else
        null;
      end if;
    end if;
  end process;

  -- dataOut_demux: process (r_demux_sel, r_dataOut) -- SALAH, harusnya atribut yang mau masuk ke xtea disimpan dulu di register
  -- begin
  --   if r_demux_sel = "00" then
  --     r_demux0 <= r_dataOut;
  --     r_demux1 <= (others => '0');
  --     r_demux2 <= (others => '0');
  --     r_demux3 <= (others => '0');
  --   elsif r_demux_sel = "01" then
  --     r_demux0 <= (others => '0');
  --     r_demux1 <= r_dataOut;
  --     r_demux2 <= (others => '0');
  --     r_demux3 <= (others => '0');
  --   elsif r_demux_sel = "10" then
  --     r_demux0 <= (others => '0');
  --     r_demux1 <= (others => '0');
  --     r_demux2 <= r_dataOut;
  --     r_demux3 <= (others => '0');
  --   elsif r_demux_sel = "11" then
  --     r_demux0 <= (others => '0');
  --     r_demux1 <= (others => '0');
  --     r_demux2 <= (others => '0');
  --     r_demux3 <= r_dataOut;
  --   else
  --     null;
  --   end if;
  -- end process;
  r_key <= r_demux0 & r_demux1;

end architecture;

