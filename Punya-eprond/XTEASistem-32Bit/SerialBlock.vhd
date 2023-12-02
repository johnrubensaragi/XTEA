library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialBlock is
    generic(data_length : natural := 64; address_length : natural := 10);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        reader_running: out std_logic;
        sender_running : out std_logic;
        read_done : out std_logic;
        send_done : out std_logic;
        send_start : in std_logic;
        send_convert : in std_logic;
        error_format : out std_logic;
        send_data : in std_logic_vector((data_length-1) downto 0);
        store_data : out std_logic_vector((data_length-1) downto 0);
        store_datatype : out std_logic_vector(1 downto 0);
        store_checkout : out std_logic;
        rs232_rx : in std_logic;
        rs232_tx : out std_logic
    );
end SerialBlock;

architecture behavioral of SerialBlock is
    component SerialReader is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        reader_enable : in std_logic;
        reader_trigger : in std_logic;
        reader_start : in std_logic;
        reader_done : out std_logic;
        reader_finish : in std_logic;
        error_format : out std_logic;
        reader_data_in : in std_logic_vector(7 downto 0);
        reader_data_out : out std_logic_vector((data_length - 1) downto 0);
        reader_data_type : out std_logic_vector(1 downto 0);
        reader_data_checkout : out std_logic
    );
    end component SerialReader;

    component SerialSender is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        sender_enable : in std_logic;
        sender_start : in std_logic;
        sender_convert : in std_logic;
        sender_trigger : in std_logic;
        sender_transmit : out std_logic;
        sender_done : out std_logic;
        sender_data_in : in std_logic_vector((data_length-1) downto 0);
        sender_data_out : out std_logic_vector(7 downto 0)
    );
    end component SerialSender;

    component uart_interpreter is
    port(
        nreset : in std_logic;
        clk : in std_logic;

        -- rx port
        rx : in std_logic;
        d_out : out std_logic_vector(7 downto 0);
        d_out_ready : out std_logic;
        serial_end: out std_logic;
        
        -- tx port        
        tx : out std_logic;
        d_in : in std_logic_vector(7 downto 0);
        d_in_ready : in std_logic;
        d_in_transmitted : out std_logic
    );
    end component uart_interpreter;

    signal reader_data_in : std_logic_vector(7 downto 0);
    signal reader_trigger, reader_start : std_logic;
    signal reader_finish, reader_done : std_logic;
    signal reader_trigger_signal : std_logic;
    signal reader_trigger_buffer : std_logic_vector(3 downto 0) := "0000";

    signal reader_data_out : std_logic_vector((data_length-1) downto 0);
    signal reader_data_type : std_logic_vector(1 downto 0);
    signal reader_data_checkout : std_logic;

    signal uart_send : std_logic_vector(7 downto 0);
    signal uart_transmit : std_logic;
    signal sender_trigger, sender_start : std_logic;
    signal sender_done : std_logic;
    signal sender_trigger_signal : std_logic;
    signal sender_trigger_buffer : std_logic_vector(3 downto 0) := "0000";

begin
    serialreader_inst: SerialReader
    port map (
        clock                => clock,
        nreset               => nreset,
        reader_enable        => '1',
        reader_trigger       => reader_trigger,
        reader_start         => reader_start,
        reader_done          => reader_done,
        reader_finish        => reader_finish,
        error_format         => error_format,
        reader_data_in       => reader_data_in,
        reader_data_out      => reader_data_out,
        reader_data_type     => reader_data_type,
        reader_data_checkout => reader_data_checkout
    );

    serialsender_inst: SerialSender
    port map (
      clock           => clock,
      nreset          => nreset,
      sender_enable   => '1',
      sender_start    => sender_start,
      sender_convert  => send_convert,
      sender_trigger  => sender_trigger,
      sender_transmit => uart_transmit,
      sender_done     => sender_done,
      sender_data_in  => send_data,
      sender_data_out => uart_send
    );

    uart_interpreter_inst: uart_interpreter
    port map (
        nreset           => nreset,
        clk              => clock,
        rx               => rs232_rx,
        d_out            => reader_data_in,
        d_out_ready      => reader_trigger_signal,
        serial_end       => reader_finish,
        tx               => rs232_tx,
        d_in             => uart_send,
        d_in_ready       => uart_transmit,
        d_in_transmitted => sender_trigger_signal
    );
    
    store_checkout <= reader_data_checkout;
    store_datatype <= reader_data_type;
    store_data <= reader_data_out;

    reader_start <= reader_trigger and not reader_finish;

    read_done <= reader_done;
    send_done <= sender_done;
    sender_start <= send_start;

    pulse_signals : process(clock)
    begin
        if rising_edge(clock) then

            -- make the reader trigger as pulse
            reader_trigger_buffer <= reader_trigger_buffer(2 downto 0) & reader_trigger_signal;
            if (reader_trigger_buffer = "0011") then reader_trigger <= '1';
            elsif (reader_finish = '1') then reader_trigger <= '1';
            elsif (reader_trigger_buffer = "1111") then reader_trigger <= '0';
            else reader_trigger <= '0';
            end if;

            -- make the sender trigger as pulse
            sender_trigger_buffer <= sender_trigger_buffer(2 downto 0) & sender_trigger_signal;
            if (sender_trigger_buffer = "0001") then sender_trigger <= '1';
            elsif (send_start = '1') then sender_trigger <= '1';
            elsif (sender_trigger_buffer = "1111") then sender_trigger <= '0';
            else sender_trigger <= '0';
            end if;

        end if;
    end process pulse_signals;

    parallel_controller : process(clock)
    begin
        if rising_edge(clock)then

            -- to check reader or sender is running
            if (reader_start = '1') then
                reader_running <= '1';
            elsif (reader_done = '1') then
                reader_running <= '0';
            end if;

            if (sender_start = '1') then
                sender_running <= '1';
            elsif (sender_done = '1') then
                sender_running <= '0';
            end if;

        end if;
    end process parallel_controller;

end behavioral;