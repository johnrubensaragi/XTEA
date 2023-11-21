library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity SerialBlock is
    generic(data_length, address_length : natural);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        serial_running: out std_logic;
        serial_done : out std_logic;
        error_out : out std_logic_vector(1 downto 0);
        send_data : in std_logic_vector((data_length-1) downto 0);
        send_start : in std_logic;
        store_address : out std_logic_vector((address_length-1) downto 0);
        store_data : out std_logic_vector((data_length-1) downto 0);
        rs232_rx : in std_logic;
        rs232_tx : out std_logic
    );
end SerialBlock;

architecture behavioral of SerialBlock is
    constant clock_frequency : natural := 50e6; -- 50 MHz
    constant serial_frequency : natural := 115200 ; -- 115.2 kbps

    component SerialReader is
        generic(data_length, address_length : natural);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            reader_enable : in std_logic;
            reader_trigger : in std_logic;
            reader_start : in std_logic;
            reader_finish : in std_logic;
            reader_done : out std_logic;
            error_out : out std_logic_vector(1 downto 0);
            reader_data_in : in std_logic_vector(7 downto 0);
            reader_address_out : out std_logic_vector((address_length-1) downto 0);
            reader_data_out : out std_logic_vector((data_length - 1) downto 0)
        );
    end component SerialReader;

    component SerialSender is
        generic(data_length, address_length : natural);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            serial_clock :  in bit;
            sender_enable : in std_logic;
            sender_trigger : out std_logic;
            sender_start : in std_logic;
            sender_done : out std_logic;
            sender_data_in : in std_logic_vector((data_length-1) downto 0);
            sender_data_out : out std_logic_vector(7 downto 0)
        );
    end component SerialSender;

    component my_uart_top is
        port(
		clock : in std_logic;
		nreset : in std_logic;
		send : in std_logic;
		send_data : in std_logic_vector(7 downto 0);
		receive : out std_logic;
		receive_data: out std_logic_vector(7 downto 0);
		rs232_rx : in std_logic;
		rs232_tx : out std_logic
        );
    end component my_uart_top;

    component ClockDiv is
        generic(div_frequency, clock_frequency : natural);
        port(
            clock: in std_logic;
            div_out: buffer bit
        );
    end component ClockDiv;

    signal reader_data_in : std_logic_vector(7 downto 0);
    signal reader_trigger, reader_enable, reader_start : std_logic;
    signal reader_finish, reader_done : std_logic;
    signal receive, receive_c : std_logic;
    
    signal internal_error : std_logic_vector(1 downto 0) := "00";

    signal uart_send : std_logic_vector(7 downto 0);
    signal sender_trigger, sender_enable, sender_start : std_logic;
    signal sender_done : std_logic;
    signal serial_clock : bit;

begin
    serialreader_inst: SerialReader
    generic map (
      data_length    => data_length,
      address_length => address_length
    )
    port map (
      clock              => clock,
      nreset             => nreset,
      reader_enable      => reader_enable,
      reader_trigger     => reader_trigger,
      reader_start       => reader_start,
      reader_finish      => reader_finish,
      reader_done        => reader_done,
      error_out          => internal_error,
      reader_data_in     => reader_data_in,
      reader_address_out => store_address,
      reader_data_out    => store_data
    );

    serialsender_inst: SerialSender
    generic map (
        data_length    => data_length,
        address_length => address_length
    )
    port map (
        clock           => clock,
        nreset          => nreset,
        serial_clock    => serial_clock,
        sender_enable   => sender_enable,
        sender_trigger  => sender_trigger,
        sender_start   => sender_start,
        sender_done     => sender_done,
        sender_data_in  => send_data,
        sender_data_out => uart_send
    );

    my_uart_top_inst: my_uart_top
    port map (
        clock        => clock,
        nreset       => nreset,
        send         => sender_trigger,
        send_data    => uart_send,
        receive      => receive,
        receive_data => reader_data_in,
        rs232_rx     => rs232_rx,
        rs232_tx     => rs232_tx
    );

    clockdiv_inst: ClockDiv
    generic map (
        div_frequency   => serial_frequency/12, -- slow frequency for serial
        clock_frequency => clock_frequency
    )
    port map (
        clock   => clock,
        div_out => serial_clock
    );

    error_out <= internal_error;

    reader_controller : process(clock)
    begin
        if rising_edge(clock) then
            receive_c <= receive;
        
            -- to trigger the reader every data change
            if (receive_c = '1' and receive = '0') then
                reader_trigger <= '1';
            else
                reader_trigger <= '0';
            end if;

            -- to tell the reader to start
            if (receive_c = '1' and receive = '0') then
                reader_start <= '1';
            elsif (receive_c <= '0' and receive <= '0') then
                reader_start <= '0';
            end if;

            -- to tell the reader to finish
            if (receive_c = '0' and receive = '0') then
                reader_finish <= '1';
            else
                reader_finish <= '0';
            end if;

        end if;
    end process reader_controller;
    
    sender_controller : process(clock)
    begin
        if rising_edge(clock) then

            -- start and stop the sender
            if (send_start = '1') then
                sender_start <= '1';
            elsif (sender_done = '1') then
                sender_start <= '0';
            end if;
            
        end if;
    end process sender_controller;

    done_check : process(serial_clock)
    begin
        if serial_clock'event and serial_clock = '1' then
            if (sender_done = '1') then
                serial_done <= '1';
            elsif (reader_done = '1') then
                serial_done <= '1';
            else
                serial_done <= '0';
            end if;
        end if;
    end process done_check;

    parallel_controller : process(clock)
    begin
        if rising_edge(clock)then

            -- to check reader or sender is running
            if (reader_start = '1') then
                serial_running <= '1';
            elsif (send_start = '1') then
                serial_running <= '1';
            elsif (reader_start = '0') then
                serial_running <= '0';
            elsif (sender_start = '0') then
                serial_running <= '0';
            end if;

            -- to disable reader and sender if error
            if (internal_error = "01" or internal_error = "10") then
                reader_enable <= '0';
            else
                reader_enable <= '1';
                sender_enable <= '1';
            end if;

        end if;
    end process parallel_controller;

end behavioral;