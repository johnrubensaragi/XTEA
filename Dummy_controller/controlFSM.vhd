library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.numeric_std.all;

entity controlFSM is
  generic (
    bitSize      : integer := 8;
    addressLSize : integer := 2;
    addressWSize : integer := 2
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
    memory         : in  std_logic_vector(bitSize - 1 downto 0);

    -- control output signals
    enable_read    : out std_logic;
    enable_write   : out std_logic;
    xtea_start     : out std_logic;
    dataIn_mux     : out std_logic;
    dataOut_demux  : out std_logic_vector(1 downto 0);

    -- data output signals
    address        : out std_logic_vector(AddressLSize + AddressWSize - 1 downto 0)
  );
end entity;

architecture behavioral of controlFSM is
  type states is (idle, write_raw_data, send_error, read_key0, read_key1, read_mode, read_data, encrypt_data, write_encrypted_data, send_to_serial);
  signal current_state, next_state : states;

  signal address_countup       : std_logic;
  signal address_reset         : std_logic;
  signal address_to_attributes : std_logic;

  component counter is
    generic (
      outputSize : integer := addressLSize + addressWSize;
      max        : integer := 2 **(addressLSize + addressWSize)
    );
    port (
      i_clk               : in  std_logic;
      i_countup           : in  std_logic;
      i_rst               : in  std_logic;
      i_rst_to_attributes : in  std_logic;

      o_count             : out std_logic_vector(outputSize - 1 downto 0)
    );
  end component;

begin

  addressCounter: counter
    generic map (
      outputSize => AddressLSize + AddressWSize,
      max        =>(2 ** AddressLSize) *(2 ** AddressLSize)
    )
    port map (
      i_clk               => clk,
      i_countup           => address_countup,
      i_rst               => address_reset,
      i_rst_to_attributes => address_to_attributes,

      o_count             => address
    );

  process (clk, nreset)
  begin
    if clk'event and clk = '1' then
      current_state <= next_state;
    else
      current_state <= current_state;
    end if;
  end process;

  process (clk, current_state)
  begin
    if (nreset = '1') then
      next_state <= idle;
    else
      case current_state is

        when idle =>
          enable_read <= '0';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '0';
          if (enable = '1') and (serial_running = '1') then
            next_state <= write_raw_data;
          else
            next_state <= idle;
          end if;

        when write_raw_data =>
          enable_read <= '0';
          enable_write <= '1';
          xtea_start <= '0';
          dataIn_mux <= '0';
          if (error_check = '1') then
            next_state <= send_error;
          elsif (serial_done = '1') then
            next_state <= read_key0;
          else
            next_state <= write_raw_data;
          end if;

        when send_error =>
          enable_read <= '0';
          enable_write <= '0';
          xtea_start <= '0';
          if (serial_done = '1') then
            next_state <= idle;
          else
            next_state <= send_error;
          end if;

        when read_key0 =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '1';
          dataOut_demux <= "00";
          next_state <= read_key1;

        when read_key1 =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '1';
          dataOut_demux <= "01";
          next_state <= read_mode;

        when read_mode =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '1';
          dataOut_demux <= "10";
          next_state <= read_data;

        when read_data =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '0';
          dataOut_demux <= "11";
          if (memory = "0000000000000000000000000000000000000000000000000000000000000000") then -- jangan lupa dirubah jadi semestinya
            next_state <= send_to_serial;
            address_reset <= '1';
          else
            next_state <= encrypt_data;
            address_reset <= '0';
          end if;

        when encrypt_data =>
          enable_read <= '0';
          enable_write <= '0';
          xtea_start <= '1';
          if (xtea_done = '1') then
            next_state <= write_encrypted_data;
          end if;

        when write_encrypted_data =>
          enable_read <= '0';
          enable_write <= '1';
          xtea_start <= '0';
          dataIn_mux <= '1';
          next_state <= read_data;
          address_countup <= '1';

        when send_to_serial =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_reset <= '0';
          if (memory /= "0000000000000000000000000000000000000000000000000000000000000000") then
            next_state <= send_to_serial;
            address_countup <= '1';
            address_reset <= '0';
            address_to_attributes <= '0';
          else
            next_state <= idle;
            address_countup <= '0';
            address_reset <= '0';
            address_to_attributes <= '1';
          end if;
      end case;
    end if;
  end process;
end architecture;
