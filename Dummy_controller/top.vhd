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
        store_datatype : in std_logic_vector(1 downto 0);
        store_checkout : in std_logic;

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
  signal r_address_from_serial   : std_logic_vector(addressSize - 1 downto 0);
  signal r_address_from_counter  : std_logic_vector(addressSize - 1 downto 0);
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
  signal r_mux0           : std_logic_vector(bitSize - 1 downto 0); -- dari serial
  signal r_mux1           : std_logic_vector(bitSize - 1 downto 0); -- dari memory
  signal r_dataIn_mux_sel : std_logic;
  signal r_demux0         : std_logic_vector(bitSize - 1 downto 0); -- ke key1
  signal r_demux1         : std_logic_vector(bitSize - 1 downto 0); -- ke key2
  signal r_demux2         : std_logic_vector(bitSize - 1 downto 0); -- ke mode
  signal r_demux3         : std_logic_vector(bitSize - 1 downto 0); -- ke d_in
  signal r_dataType       : std_logic_vector(1 downto 0);
  signal r_address_sel    : std_logic;

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
      store_datatype        : in  std_logic_vector(1 downto 0);
      store_checkout        : in  std_logic;

      -- mux controls
      dataIn_mux            : out std_logic;
      dataType              : out std_logic_vector(1 downto 0);
      address_sel           : out std_logic
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
      store_datatype        => store_datatype,
      store_checkout        => store_checkout,

      -- mux controls
      dataIn_mux            => r_dataIn_mux_sel,
      dataType              => r_dataType,
      address_sel           => r_address_sel
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
      o_count             => r_address_from_counter
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

  dataIn_mux: process (r_dataIn_mux_sel, r_mux0, r_mux1)
  begin
    if r_dataIn_mux_sel = '0' then
      r_dataIn <= r_mux0;
    else
      r_dataIn <= r_mux1;
    end if;
  end process;

  attributeType: process (clk) -- xtea input register
  begin
    if rising_edge(clk) then
      if r_dataType = "00" then
        r_demux0 <= r_dataOut;
        r_demux1 <= r_demux1;
        r_demux2 <= r_demux2;
      elsif r_dataType = "01" then
        r_demux0 <= r_demux0;
        r_demux1 <= r_dataOut;
        r_demux2 <= r_demux2;
      elsif r_dataType = "10" then
        r_demux0 <= r_demux0;
        r_demux1 <= r_demux1;
        r_demux2 <= r_dataOut;
      elsif r_dataType = "11" then
        r_demux0 <= r_demux0;
        r_demux1 <= r_demux1;
        r_demux2 <= r_demux2;
      else
        null;
      end if;
    end if;
  end process;

  dataType: process (r_dataType, r_dataOut) -- xtea d_in gak boleh ada register, nanti telat
  begin
    if r_dataType = "11" then
      r_demux3 <= r_dataOut;
    else
      r_demux3 <= (others => '0');
    end if;
  end process;

  serial_address_LUT: process (store_datatype, r_address_from_counter)
  begin
    case store_datatype is
      when "00" =>
        r_address_from_serial <= "0000000000";
      when "01" =>
        r_address_from_serial <= "0000000001";
      when "10" =>
        r_address_from_serial <= "0000000010";
      when others =>
        r_address_from_serial <= r_address_from_counter;
    end case;
  end process;

  address_sel: process (r_address_sel, r_address_from_serial, r_address_from_counter)
  begin
    if r_address_sel = '0' then
      r_address <= r_address_from_serial;
    else
      r_address <= r_address_from_counter;
    end if;
  end process;

  r_key  <= r_demux0 & r_demux1;
  r_mux0 <= serial_output;

end architecture;

