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
    store_datatype        : in  std_logic_vector(1 downto 0);
    store_checkout        : in  std_logic;

    -- mux controls
    dataIn_mux            : out std_logic;
    dataType              : out std_logic_vector(1 downto 0);
    address_sel           : out std_logic
  );
end entity;

architecture behavioral of controlFSM is
  type states is (Idle, PrepareReceive, ReceiveAttributes, ReceiveFirstData, ReceiveData, ReceiveWriteData, SendError, PrepareRead, ReadKey0, ReadKey1, ReadMode, ReadData, StartEncrypt, Encrypt, WriteEncrypted, SendToSerial);
  signal current_state, next_state : states;

begin
  process (clk, nreset)
  begin
    if nreset = '1' then
      current_state <= idle;
    elsif clk'event and clk = '1' then
      current_state <= next_state;
    end if;
  end process;

  process (current_state, enable, serial_running, store_datatype, store_checkout, error_check, serial_done, memory, xtea_done) -- Hybrid FSM (address controls are Mealy-typed, the rest is Moore-typed)
  begin

    case current_state is

      when Idle =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '0';
        dataType <= "00";
        address_sel <= '0';
        if (enable = '1') and (serial_running = '1') and (store_checkout = '1') then
          next_state <= PrepareReceive;
        else
          next_state <= Idle;
        end if;

      when PrepareReceive =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        address_countup <= '0';
        address_reset <= '1';
        address_to_attributes <= '0';
        dataIn_mux <= '0';
        address_sel <= '0';
        if (error_check = '1') then
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
        enable_write <= '1';
        xtea_start <= '0';
        address_countup <= '0';
        address_reset <= '1';
        dataIn_mux <= '0';
        dataType <= "00";
        address_sel <= '0';
        if (error_check = '1') then
          next_state <= SendError;
        elsif (serial_running = '0') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_to_attributes <= '1';
        elsif store_datatype = "00" or store_datatype = "01" or store_datatype = "10" then
          next_state <= ReceiveAttributes;
        elsif store_datatype = "11" then
          next_state <= ReceiveFirstData;
        else
          next_state <= ReceiveAttributes;
        end if;

      when ReceiveFirstData =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        dataIn_mux <= '0';
        dataType <= "00";
        address_sel <= '0';
        if (error_check = '1') then
          next_state <= SendError;
          address_countup <= '0';
          address_reset <= '0';
        elsif (serial_running = '0') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_to_attributes <= '1';
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
        dataIn_mux <= '0';
        dataType <= "00";
        address_sel <= '0';
        if (error_check = '1') then
          next_state <= SendError;
          address_countup <= '0';
          address_reset <= '0';
        elsif (serial_running = '0') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_to_attributes <= '1';
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
        address_countup <= '0';
        address_reset <= '0';
        dataIn_mux <= '0';
        dataType <= "00";
        address_sel <= '0';
        if (error_check = '1') then
          next_state <= SendError;
          address_countup <= '0';
          address_reset <= '0';
        elsif (serial_running = '0') and (store_checkout = '0') then
          next_state <= PrepareRead;
          address_to_attributes <= '1';
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
        address_countup <= '0';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '0';
        dataType <= "00";
        address_sel <= '0';
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
        dataIn_mux <= '1';
        dataType <= "00";
        address_sel <= '1';
        next_state <= ReadKey0;

      when ReadKey0 => -- key0 sudah di dataOut, masukkan ke register key xtea sambil masukkan key1 ke dataOut
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        address_countup <= '1';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '1';
        dataType <= "00";
        address_sel <= '1';
        next_state <= ReadKey1;

      when ReadKey1 => -- key1 sudah di dataOut, masukkan ke register key xtea sambil masukkan mode ke dataOut
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        address_countup <= '1';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '1';
        dataType <= "01";
        address_sel <= '1';
        next_state <= ReadMode;

      when ReadMode => -- mode sudah di dataOut, masukkan ke register mode xtea sambil masukkan data ke dataOut
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '1';
        dataType <= "10";
        address_sel <= '1';
        next_state <= ReadData;

      when ReadData =>
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '1';
        dataType <= "11";
        address_sel <= '1';
        next_state <= StartEncrypt;

      when StartEncrypt =>
        enable_read <= '1';
        enable_write <= '0';
        address_countup <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '1';
        dataType <= "11";
        address_sel <= '1';
        if (memory = "0000000000000000000000000000000000000000000000000000000000000000") then -- jangan lupa dirubah jadi semestinya
          next_state <= SendToSerial;
          xtea_start <= '0'; -- dibuat sbg Mealy agar XTEA tidak berjalan jika memory null
          address_reset <= '1';
        else
          next_state <= Encrypt;
          xtea_start <= '1';
          address_reset <= '0';
        end if;

      when Encrypt =>
        enable_read <= '0';
        enable_write <= '0';
        xtea_start <= '0';
        address_countup <= '0';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '1';
        dataType <= "11";
        address_sel <= '1';
        if (xtea_done = '1') then
          next_state <= WriteEncrypted;
        else
          next_state <= Encrypt;
        end if;

      when WriteEncrypted =>
        enable_read <= '0';
        enable_write <= '1';
        xtea_start <= '0';
        address_countup <= '1';
        address_reset <= '0';
        address_to_attributes <= '0';
        dataIn_mux <= '1';
        dataType <= "11";
        address_sel <= '1';
        next_state <= ReadData;

      when SendToSerial =>
        enable_read <= '1';
        enable_write <= '0';
        xtea_start <= '0';
        address_reset <= '0';
        dataIn_mux <= '0';
        dataType <= "00";
        address_sel <= '1';
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
  end process;
end architecture;
