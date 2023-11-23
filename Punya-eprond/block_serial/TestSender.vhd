library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity TestSender is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        rs232_rx : in std_logic;
        rs232_tx : out std_logic
    );
end TestSender;

architecture behavioral of TestSender is
    constant clock_frequency : natural := 50e6; -- 50 MHz
    constant clock_period : time := 1 sec / clock_frequency;
    constant data_length : natural := 64;
    constant address_length : natural := 10;

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

    component PulseGenerator is
        generic(pulse_width, pulse_max : natural);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            pulse_enable : in std_logic;
            pulse_reset : in std_logic;
            pulse_out : out std_logic
        );
    end component PulseGenerator;

    component ClockDiv is
        generic(div_frequency, clock_frequency : natural);
        port(
            clock_in: in std_logic;
            clock_out: out std_logic
        );
    end component ClockDiv;

    signal serial_running, serial_done : std_logic;
    signal error_out : std_logic_vector(1 downto 0);
    signal store_data : std_logic_vector((data_length-1) downto 0);
    signal store_address : std_logic_vector((address_length-1) downto 0);
    signal send_data : std_logic_vector((data_length-1) downto 0);
    signal send_start : std_logic;

    signal send_counter : integer range -8 to 7 := -1;
    signal serial_done_buffer : std_logic;

    signal pulse10_reset : std_logic := '0';
    signal pulse10_out : std_logic;

    function to_slv(str : string) return std_logic_vector is
        alias str_norm : string(str'length downto 1) is str;
        variable res_v : std_logic_vector(8 * str'length - 1 downto 0);
    begin
        for idx in str_norm'range loop
          res_v(8 * idx - 1 downto 8 * idx - 8) := 
            std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8));
        end loop;
        return res_v;
    end function;

begin
    serialblock_inst: SerialBlock
    generic map (
      data_length    => data_length,
      address_length => address_length
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

    pulse10_inst: PulseGenerator
    generic map (
      pulse_width => 10,
      pulse_max   => 16
    )
    port map (
      clock        => clock,
      nreset       => nreset,
      pulse_enable => '1',
      pulse_reset  => pulse10_reset,
      pulse_out    => pulse10_out
    );

    process(clock)
        constant text_input : string := "Aku adalah seorang Kapiten      ";
        constant text_vector : std_logic_vector((8*text_input'length-1) downto 0) := to_slv(text_input);
    begin
        serial_done_buffer <= serial_done;
        send_start <= pulse10_out;
        
        if (send_counter >= 0 and send_counter <= (text_input'length/8 - 1)) then
            send_data <= text_vector((text_vector'length-(64*send_counter)-1) downto text_vector'length-(64*(send_counter+1)));
        end if;

        if (serial_done_buffer = '0' and serial_done = '1') then
            if (send_counter < (text_input'length/8 - 1)) then
                pulse10_reset <= not pulse10_reset;
                send_counter <= send_counter + 1;
            end if;
        end if;


    end process;

end architecture;