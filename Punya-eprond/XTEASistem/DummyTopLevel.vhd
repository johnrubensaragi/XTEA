library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity DummyTopLevel is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        rs232_rx : in std_logic;
        rs232_tx : out std_logic
    );
end DummyTopLevel;

architecture behavioral of DummyTopLevel is
    component SerialBlock is
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
    end component SerialBlock;  

    signal serial_running, serial_done : std_logic;
    signal error_out : std_logic_vector(1 downto 0);
    signal store_data : std_logic_vector(63 downto 0);
    signal store_address : std_logic_vector(9 downto 0);
    signal send_data : std_logic_vector(63 downto 0);
    signal send_start : std_logic;

begin
    serialblock_inst: SerialBlock
    generic map (
        data_length    => 64,
        address_length => 10
    )
    port map (
        clock          => clock,
        nreset         => nreset,
        serial_running => serial_running,
        serial_done    => serial_done,
        error_out      => error_out,
        send_data      => send_data,
        send_start     => send_start,
        store_address  => store_address,
        store_data     => store_data,
        rs232_rx       => rs232_rx,
        rs232_tx       => rs232_tx
    );
end architecture;