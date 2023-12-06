library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity top is
  generic (
    bitSize     : integer := 64; -- Ukuran bit data tersimpan
    addressSize : integer := 10  -- Ukuran address L = jumlah bit minimum untuk memuat L
    -- addressWSize : integer := 2   -- Ukuran address W = jumlah bit minimum untuk memuat W
  );
  port (enable   : in  std_logic;
        clk      : in  std_logic;
        nreset   : in  std_logic;

        -- dari DummyTopLevel.vhd
        rs232_rx : in  std_logic;
        rs232_tx : out std_logic;
        keys     : in  std_logic_vector(3 downto 0);
        switch   : in  std_logic_vector(3 downto 0);
        leds     : out std_logic_vector(3 downto 0)
       );

end entity;

architecture behavioral of top is

  -- memory
  signal r_dataIn       : std_logic_vector(bitSize - 1 downto 0);
  signal r_dataOut      : std_logic_vector(bitSize - 1 downto 0);
  signal r_enable_read  : std_logic;
  signal r_enable_write : std_logic;

  -- address
  signal r_address_countup     : std_logic;
  signal r_address_reset       : std_logic;
  signal r_address             : std_logic_vector(addressSize - 1 downto 0);
  signal r_last_address        : std_logic_vector(addressSize - 1 downto 0);
  signal r_update_last_address : std_logic;
  -- xtea
  signal r_xtea_start : std_logic;
  signal r_xtea_done  : std_logic;

  -- serial
  signal r_reader_running        : std_logic;
  signal r_sender_running        : std_logic;
  signal r_serial_read_done      : std_logic;
  signal r_serial_send_done      : std_logic;
  signal r_serial_send_start     : std_logic;
  signal r_read_convert          : std_logic := '0';
  signal r_send_convert          : std_logic := '0';
  signal r_error_format          : std_logic;
  signal r_send_data             : std_logic_vector((bitSize - 1) downto 0);
  signal r_store_data            : std_logic_vector((bitSize - 1) downto 0);
  signal r_store_datatype        : std_logic_vector(1 downto 0);
  signal r_store_checkout        : std_logic;
  signal r_store_checkout_buffer : std_logic;

  -- mux
  signal r_dataType         : std_logic_vector(1 downto 0);
  signal r_dataIn_mux_sel   : std_logic;
  signal r_data_from_serial : std_logic_vector(bitSize - 1 downto 0);
  signal r_data_from_xtea   : std_logic_vector(bitSize - 1 downto 0);
  signal r_key0             : std_logic_vector(bitSize - 1 downto 0);
  signal r_key1             : std_logic_vector(bitSize - 1 downto 0);
  signal r_longkey          : std_logic_vector(2 * bitSize - 1 downto 0);
  signal r_mode             : std_logic;

  signal r_convert_data : std_logic;
  signal r_is_idle      : std_logic;
  signal r_rs232_tx     : std_logic;

  component controlFSM is
    generic (
      bitSize     : integer := 8;
      addressSize : integer := 10
    );
    port (
      enable              : in  std_logic;
      nreset              : in  std_logic;
      clk                 : in  std_logic;

      -- memory controls
      enable_read         : out std_logic;
      enable_write        : out std_logic;

      -- address controls
      last_address        : in  std_logic_vector(addressSize - 1 downto 0);
      address             : in  std_logic_vector(addressSize - 1 downto 0);
      address_countup     : out std_logic;
      address_reset       : out std_logic;
      update_last_address : out std_logic;
      -- xtea controls
      xtea_done           : in  std_logic;
      xtea_start          : out std_logic;

      -- serial controls
      reader_running      : in  std_logic;
      sender_running      : in  std_logic;
      reader_done         : in  std_logic;
      sender_done         : in  std_logic;
      sender_start        : out std_logic;
      error_format        : in  std_logic;
      store_datatype      : in  std_logic_vector(1 downto 0);
      store_checkout      : in  std_logic;

      -- mux controls
      dataIn_mux          : out std_logic;
      is_idle             : out std_logic
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
      i_clk     : in  std_logic;
      i_countup : in  std_logic;
      i_rst     : in  std_logic;

      o_count   : out std_logic_vector(outputSize - 1 downto 0)
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

  component SerialBlock is
    generic (data_length, address_length : natural);
    port (
      clock          : in  std_logic;
      nreset         : in  std_logic;
      reader_running : out std_logic;
      sender_running : out std_logic;
      read_done      : out std_logic;
      send_done      : out std_logic;
      send_start     : in  std_logic;
      read_convert   : in  std_logic;
      send_convert   : in  std_logic;
      error_format   : out std_logic;
      send_data      : in  std_logic_vector((data_length - 1) downto 0);
      store_data     : out std_logic_vector((data_length - 1) downto 0);
      store_datatype : out std_logic_vector(1 downto 0);
      store_checkout : out std_logic;
      rs232_rx       : in  std_logic;
      rs232_tx       : out std_logic
    );
  end component;

begin

  controlFSM0: controlFSM
    generic map (
      bitSize => bitSize
    )
    port map (
      enable              => enable,
      nreset              => nreset,
      clk                 => clk,

      -- memory controls
      enable_read         => r_enable_read,
      enable_write        => r_enable_write,

      -- address controls
      last_address        => r_last_address,
      address             => r_address,
      address_countup     => r_address_countup,
      address_reset       => r_address_reset,
      update_last_address => r_update_last_address,

      -- xtea controls
      xtea_done           => r_xtea_done,
      xtea_start          => r_xtea_start,

      -- serial controls
      reader_running      => r_reader_running,
      sender_running      => r_sender_running,
      reader_done         => r_serial_read_done,
      sender_done         => r_serial_send_done,
      sender_start        => r_serial_send_start,
      error_format        => r_error_format,
      store_datatype      => r_store_datatype,
      store_checkout      => r_store_checkout,

      -- mux controls
      dataIn_mux          => r_dataIn_mux_sel,
      is_idle             => r_is_idle
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
      i_clk     => clk,
      i_countup => r_address_countup,
      i_rst     => r_address_reset,
      o_count   => r_address
    );

  xtea0: xtea
    port map (
      d_in_ready  => r_xtea_start,
      d_in        => r_dataOut,
      key         => r_longkey,
      clk         => clk,
      mode        => r_mode,
      d_out       => r_data_from_xtea,
      d_out_ready => r_xtea_done
    );

  serialblock_inst: SerialBlock
    generic map (
      data_length    => bitSize,
      address_length => addressSize
    )
    port map (
      clock          => clk,
      nreset         => nreset,
      reader_running => r_reader_running,
      sender_running => r_sender_running,
      read_done      => r_serial_read_done,
      send_done      => r_serial_send_done,
      send_start     => r_serial_send_start,
      read_convert   => keys(0),
      send_convert   => keys(1),
      error_format   => r_error_format,
      send_data      => r_dataOut,
      store_data     => r_store_data,
      store_datatype => r_store_datatype,
      store_checkout => r_store_checkout,
      rs232_rx       => rs232_rx,
      rs232_tx       => r_rs232_tx
    );

  attributes_reg: process (clk)
  begin
    if rising_edge(clk) then
      case r_store_datatype is
        when "00" => -- key0
          r_key0 <= r_store_data;
          r_key1 <= r_key1;
          r_mode <= r_mode;
        when "01" => -- key1
          r_key0 <= r_key0;
          r_key1 <= r_store_data;
          r_mode <= r_mode;
        when "10" => -- mode
          r_key0 <= r_key0;
          r_key1 <= r_key1;
          r_mode <= r_store_data(0);
        when others =>
          null;
      end case;
    end if;
  end process;

  mem_dataIn_buffer: process (r_store_datatype, r_store_data)
  begin
    if r_store_datatype = "11" then
      r_data_from_serial <= r_store_data;
    else
      r_data_from_serial <= (others => 'Z');
    end if;
  end process;

  address_saver: process (clk)
  begin
    if rising_edge(clk) then
      if r_update_last_address = '1' then
        r_last_address <= unsigned(r_address) + unsigned(std_logic_vector'("0000000001"));
      else
        r_last_address <= r_last_address;
      end if;
    end if;
  end process;

  mem_dataIn_mux: process (r_dataIn_mux_sel, r_data_from_serial, r_data_from_xtea)
  begin
    if r_dataIn_mux_sel = '0' then
      r_dataIn <= r_data_from_serial;
    else
      r_dataIn <= r_data_from_xtea;
    end if;
  end process;

  convert_tff: process (keys)
  begin
    if falling_edge(keys(0)) then
      r_convert_data <= not r_convert_data;
    else
      r_convert_data <= r_convert_data;
    end if;
  end process;

  r_longkey <= r_key0 & r_key1;
  rs232_tx  <= r_rs232_tx or r_is_idle;

  r_read_convert <= r_convert_data;
  r_send_convert <= not r_mode and r_convert_data;

end architecture;
