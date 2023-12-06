library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.numeric_std.all;

entity controlFSM is
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
end entity;

architecture behavioral of controlFSM is
  type states is (Idle, PrepareReceive, ReceiveAttributes, ReceiveFirstData, ReceiveData, ReceiveWriteData, SendError, PrepareRead, ReadData, StartEncrypt, Encrypt, WriteEncrypted, PrepareSend, SendToSerial, Sending);
  signal current_state, next_state : states;

begin
  process (clk, nreset)
  begin
    if nreset = '0' then
      current_state <= idle;
    elsif clk'event and clk = '1' then
      current_state <= next_state;
    end if;
  end process;

  process (current_state, enable, reader_running, reader_done, sender_done, store_datatype, store_checkout, error_format, last_address, address, xtea_done) -- Hybrid FSM (address controls are Mealy-typed, the rest is Moore-typed)
  begin
    is_idle <= '0';
    case current_state is

      when Idle =>
        is_idle <= '1';
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        dataIn_mux <= '0';
        update_last_address <= '0';
        if (enable = '1') and (reader_running = '1') and (store_checkout = '1') then
          next_state <= PrepareReceive;
        else
          next_state <= Idle;
        end if;

      when PrepareReceive =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '1';
        dataIn_mux <= '0';
        if (error_format = '1') then
          next_state <= SendError;
        elsif store_datatype = "00" or store_datatype = "01" or store_datatype = "10" then
          next_state <= ReceiveAttributes;
        elsif store_datatype = "11" then
          next_state <= ReceiveFirstData;
        else
          next_state <= PrepareReceive;
        end if;

      when ReceiveAttributes =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '1';
        dataIn_mux <= '1';
        update_last_address <= '0';
        if (error_format = '1') then
          next_state <= SendError;
          address_countup <= '0';
          address_reset <= '0';
        elsif (reader_done = '1') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_countup <= '0';
          address_reset <= '0';
        elsif store_datatype = "00" or store_datatype = "01" or store_datatype = "10" then
          next_state <= ReceiveAttributes;
          address_countup <= '0';
          address_reset <= '1';
        elsif store_datatype = "11" then
          next_state <= ReceiveFirstData;
          address_countup <= '0';
          address_reset <= '0';
        else
          next_state <= ReceiveAttributes;
          address_countup <= '0';
          address_reset <= '0';
        end if;

      when ReceiveFirstData =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        dataIn_mux <= '0';
        update_last_address <= '1';
        if (error_format = '1') then
          next_state <= SendError;
          address_countup <= '0';
          address_reset <= '0';
        elsif (reader_done = '1') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_countup <= '0';
          address_reset <= '0';
        elsif store_datatype = "00" or store_datatype = "01" or store_datatype = "10" then
          next_state <= ReceiveAttributes;
          address_countup <= '0';
          address_reset <= '1';
        elsif store_checkout = '1' then
          next_state <= ReceiveWriteData;
          address_countup <= '0';
          address_reset <= '0';
        else
          next_state <= ReceiveData;
          address_countup <= '0';
          address_reset <= '0';
        end if;

      when ReceiveData =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        dataIn_mux <= '0';
        update_last_address <= '1';
        if (error_format = '1') then
          next_state <= SendError;
          address_countup <= '0';
          address_reset <= '0';
        elsif (reader_done = '1') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_countup <= '0';
          address_reset <= '0';
        elsif store_datatype = "00" or store_datatype = "01" or store_datatype = "10" then
          next_state <= ReceiveAttributes;
          address_countup <= '0';
          address_reset <= '0';
        elsif store_checkout = '1' then
          next_state <= ReceiveWriteData;
          address_countup <= '1';
          address_reset <= '0';
        else
          next_state <= ReceiveData;
          address_countup <= '0';
          address_reset <= '0';
        end if;

      when ReceiveWriteData =>
        enable_read <= '0';
        enable_write <= '1';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        dataIn_mux <= '0';
        update_last_address <= '1';
        if (error_format = '1') then
          next_state <= SendError;
          address_countup <= '0';
          address_reset <= '0';
        elsif (reader_done = '1') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_countup <= '0';
          address_reset <= '0';
        elsif store_datatype = "00" or store_datatype = "01" or store_datatype = "10" then
          next_state <= ReceiveAttributes;
          address_countup <= '0';
          address_reset <= '1';
        elsif store_checkout = '0' then
          next_state <= ReceiveData;
          address_countup <= '0';
          address_reset <= '0';
        else
          next_state <= ReceiveWriteData;
          address_countup <= '0';
          address_reset <= '0';
        end if;

      when SendError =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        dataIn_mux <= '0';
        update_last_address <= '0';
        if (reader_done = '1') then
          next_state <= Idle;
        else
          next_state <= SendError;
        end if;

      when PrepareRead => -- masukkan key0 ke dataOut
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '1';
        dataIn_mux <= '1';
        update_last_address <= '0';
        next_state <= ReadData;

      when ReadData =>
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        dataIn_mux <= '1';
        update_last_address <= '0';
        next_state <= StartEncrypt;

      when StartEncrypt =>
        enable_read <= '1';
        enable_write <= '0';
        address_countup <= '0';
        dataIn_mux <= '1';
        update_last_address <= '0';
        if (address = last_address) then -- jangan lupa dirubah jadi semestinya
          next_state <= PrepareSend;
          xtea_start <= '0'; -- dibuat sbg Mealy agar XTEA tidak berjalan jika memory null
          sender_start <= '0';
          address_reset <= '1';
        else
          next_state <= Encrypt;
          xtea_start <= '1';
          sender_start <= '0';
          address_reset <= '0';
        end if;

      when Encrypt =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        dataIn_mux <= '1';
        update_last_address <= '0';
        if (xtea_done = '1') then
          next_state <= WriteEncrypted;
        else
          next_state <= Encrypt;
        end if;

      when WriteEncrypted =>
        enable_read <= '0';
        enable_write <= '1';
        xtea_start <= '0';
        sender_start <= '0';
        address_countup <= '1';
        address_reset <= '0';
        dataIn_mux <= '1';
        update_last_address <= '0';
        next_state <= ReadData;

      when PrepareSend =>
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '1';
        address_countup <= '0';
        address_reset <= '0';
        dataIn_mux <= '1';
        update_last_address <= '0';
        next_state <= SendToSerial;

      when SendToSerial =>
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '1';
        address_reset <= '0';
        dataIn_mux <= '1';
        update_last_address <= '0';
        if (address /= last_address) then
          next_state <= sending;
          address_countup <= '0';
        else
          next_state <= Idle;
          address_countup <= '0';
        end if;

      when Sending =>
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        sender_start <= '0';
        address_reset <= '0';
        dataIn_mux <= '1';
        update_last_address <= '0';
        if (address /= last_address) then
          if sender_done = '1' then
            next_state <= PrepareSend;
            address_countup <= '1';
          else
            next_state <= Sending;
            address_countup <= '0';
          end if;
        else
          next_state <= Idle;
          address_countup <= '0';
        end if;
    end case;
  end process;
end architecture;
