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
          -- -- control input signals
          -- serial_running : in  std_logic;
          -- reader_done    : in  std_logic;
          -- error_check    : in  std_logic;
          -- store_datatype : in  std_logic_vector(1 downto 0);
          -- store_checkout : in  std_logic;
          -- -- input data
          -- serial_output  : in  std_logic_vector(bitSize - 1 downto 0)
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
  signal r_reader_running        : std_logic;
  signal r_sender_running        : std_logic;
  signal r_serial_read_done      : std_logic;
  signal r_serial_send_done      : std_logic;
  signal r_serial_send_start     : std_logic;
  signal r_error_check           : std_logic_vector(1 downto 0);
  signal r_send_data             : std_logic_vector((bitSize - 1) downto 0);
  signal r_store_data            : std_logic_vector((bitSize - 1) downto 0);
  signal r_store_datatype        : std_logic_vector(1 downto 0);
  signal r_store_checkout        : std_logic;
  signal r_store_checkout_buffer : std_logic;

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
      reader_running        : in  std_logic;
      sender_running        : in  std_logic;
      reader_done           : in  std_logic;
      sender_done           : in  std_logic;
      sender_start          : out std_logic;
      error_check           : in  std_logic_vector(1 downto 0);
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
      error_out      : out std_logic_vector(1 downto 0);
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
      reader_running        => r_reader_running,
      sender_running        => r_sender_running,
      reader_done           => r_serial_read_done,
      sender_done           => r_serial_send_done,
      sender_start          => r_serial_send_start,
      error_check           => r_error_check,
      store_datatype        => r_store_datatype,
      store_checkout        => r_store_checkout,

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
      error_out      => r_error_check,
      send_data      => r_dataOut,
      store_data     => r_store_data,
      store_datatype => r_store_datatype,
      store_checkout => r_store_checkout_buffer,
      rs232_rx       => rs232_rx,
      rs232_tx       => rs232_tx
    );

  dataIn_mux: process (r_dataIn_mux_sel, r_mux0, r_mux1) -- dataIn mux
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

  serial_address_LUT: process (r_store_datatype, r_address_from_counter) -- address LUT
  begin
    case r_store_datatype is
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

  address_sel: process (r_address_sel, r_address_from_serial, r_address_from_counter) -- address selector
  begin
    if r_address_sel = '0' then
      r_address <= r_address_from_serial;
    else
      r_address <= r_address_from_counter;
    end if;
  end process;

  serial_store_checkout_buffer: process (clk) -- delays store_checkout by 1 clock
  begin
    if rising_edge(clk) then
      r_store_checkout <= r_store_checkout_buffer;
    end if;
  end process;

  r_key  <= r_demux0 & r_demux1;
  r_mux0 <= r_store_data;

end architecture;

