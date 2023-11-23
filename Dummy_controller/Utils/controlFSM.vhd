library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.numeric_std.all;

entity controlFSM is
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
end entity;

architecture behavioral of controlFSM is
  type states is (Idle, WriteRawData, SendError, PrepareRead, ReadKey0, ReadKey1, ReadMode, ReadData, StartEncrypt, Encrypt, WriteEncrypted, SendToSerial);
  signal current_state, next_state : states;

begin
  process (clk, nreset)
  begin
    if clk'event and clk = '1' then
      current_state <= next_state;
    else
      current_state <= current_state;
    end if;
  end process;

  process (clk, current_state, memory) -- memory ada di sensitivity list agar penentuan next state tidak fix ketika rising edge clock sebelumnya
  begin
    if (nreset = '1') then
      next_state <= Idle;
    else
      case current_state is

        when Idle =>
          enable_read <= '0';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '0';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          if (enable = '1') and (serial_running = '1') then
            next_state <= WriteRawData;
          else
            next_state <= Idle;
          end if;

        when WriteRawData =>
          enable_read <= '0';
          enable_write <= '1';
          xtea_start <= '0';
          address_countup <= '0';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          if (error_check = '1') then
            next_state <= SendError;
          elsif (serial_done = '1') then
            next_state <= PrepareRead;
          else
            next_state <= WriteRawData;
          end if;

        when SendError =>
          enable_read <= '0';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '0';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          if (serial_done = '1') then
            next_state <= Idle;
          else
            next_state <= SendError;
          end if;

        when PrepareRead => -- masukkan key0 ke dataOut
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '1';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "00";
          next_state <= ReadKey0;

        when ReadKey0 => -- key0 sudah di dataOut, masukkan ke register key xtea sambil masukkan key1 ke dataOut
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '1';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "00";
          next_state <= ReadKey1;

        when ReadKey1 => -- key1 sudah di dataOut, masukkan ke register key xtea sambil masukkan mode ke dataOut
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '1';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "01";
          next_state <= ReadMode;

        when ReadMode => -- mode sudah di dataOut, masukkan ke register mode xtea sambil masukkan data ke dataOut
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '0';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "10";
          next_state <= ReadData;

        when ReadData =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '0';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "11";
          next_state <= StartEncrypt;

        when StartEncrypt =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '1';
          address_countup <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "11";
          if (memory = "0000000000000000000000000000000000000000000000000000000000000000") then -- jangan lupa dirubah jadi semestinya
            next_state <= SendToSerial;
            address_reset <= '1';
          else
            next_state <= Encrypt;
            address_reset <= '0';
          end if;

        when Encrypt =>
          enable_read <= '0';
          enable_write <= '0';
          xtea_start <= '0';
          address_countup <= '0';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "11";
          if (xtea_done = '1') then
            next_state <= WriteEncrypted;
          end if;

        when WriteEncrypted =>
          enable_read <= '0';
          enable_write <= '1';
          xtea_start <= '0';
          address_countup <= '1';
          address_reset <= '0';
          address_to_attributes <= '0';
          dataIn_mux <= '1';
          dataOut_demux <= "11";
          next_state <= ReadData;

        when SendToSerial =>
          enable_read <= '1';
          enable_write <= '0';
          xtea_start <= '0';
          address_reset <= '0';
          dataIn_mux <= '0';
          dataOut_demux <= "11";
          if (memory /= "0000000000000000000000000000000000000000000000000000000000000000") then
            next_state <= SendToSerial;
            address_countup <= '1';
            address_to_attributes <= '0';
          else
            next_state <= Idle;
            address_countup <= '0';
            address_to_attributes <= '1';
          end if;
      end case;
    end if;
  end process;
end architecture;
