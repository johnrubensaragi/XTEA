library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DummyTopLevel is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        rs232_rx : in std_logic;
        rs232_tx : out std_logic;
        keys : in std_logic_vector(3 downto 0)
    );
end DummyTopLevel;

architecture behavioral of DummyTopLevel is
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

    component XTEABlock is
        port(
            clock, nreset : in std_logic;
            xtea_key : in std_logic_vector(127 downto 0);
            xtea_input : in std_logic_vector(63 downto 0);
            xtea_mode : in std_logic;
            xtea_start : in std_logic;
            xtea_output : out std_logic_vector(63 downto 0);
            xtea_done : out std_logic
        );
    end component XTEABlock;

    component SRAM is
        generic (data_length, address_length : integer);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            enable_read, enable_write : in std_logic;
            memory_address : in std_logic_vector((address_length - 1) downto 0);
            memory_write : in std_logic_vector((data_length - 1) downto 0);
            memory_read : out std_logic_vector((data_length - 1) downto 0)
        );
    end component SRAM;

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

    component ClockCounter
        generic(count_max : natural);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            enable : in std_logic;
            creset : in std_logic;
            count : out natural range 0 to (count_max-1)
        );
    end component ClockCounter;

    -- Pulse gen inout
    signal pulse10_reset : std_logic := '0';
    signal pulse10_out : std_logic;

    -- Clock counter inout
    constant ccounter_max : natural := 16;
    signal ccounter_enable, ccounter_reset : std_logic := '0';
    signal ccounter_out : natural range 0 to (ccounter_max-1);

    -- Serial block inout
    signal serial_running, serial_done : std_logic;
    signal error_out : std_logic_vector(1 downto 0);
    signal store_data : std_logic_vector((data_length-1) downto 0);
    signal store_address : std_logic_vector((address_length-1) downto 0);
    signal send_data : std_logic_vector((data_length-1) downto 0);
    signal send_start : std_logic;

    -- SRAM inout
    signal memory_read, memory_write : std_logic_vector((data_length-1) downto 0);
    signal memory_address : std_logic_vector((address_length-1) downto 0);
    signal enable_read, enable_write : std_logic := '0';

    -- XTEA block inout
    signal xtea_input, xtea_output : std_logic_vector((data_length-1) downto 0);
    signal xtea_key : std_logic_vector(127 downto 0);
    signal xtea_mode, xtea_start, xtea_done : std_logic;

    type states is (idle, reading_serial, sending_error, setup_xtea1, setup_xtea2, setup_xtea3, starting_xtea,
                    processing_xtea, storing_xtea, reading_results, sending_results);
    signal controller_cstate, controller_nstate : states;

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

    procedure send_text(text_input : string) is
        constant text_vector : std_logic_vector((8*text_input'length-1) downto 0) := to_slv(text_input);
    begin
        for num in text_input'range loop
            if (num mod 8 = 0) then
                send_data <= text_vector((text_vector'length-(64*((num/8)-1))-1) downto text_vector'length-(64*(num/8)));
                pulse10_reset <= not pulse10_reset;
                send_start <= pulse10_out;
                wait until rising_edge(serial_done);
            end if;
        end loop;
        send_start <= 'Z';
    end procedure;

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

    xteablock_inst: XTEABlock
    port map (
        clock       => clock,
        nreset      => nreset,
        xtea_key    => xtea_key,
        xtea_input  => xtea_input,
        xtea_mode   => xtea_mode,
        xtea_start  => xtea_start,
        xtea_output => xtea_output,
        xtea_done   => xtea_done
    );

    sram_inst: SRAM
    generic map (
        data_length    => data_length,
        address_length => address_length
    )
    port map (
        clock          => clock,
        nreset         => nreset,
        enable_read    => enable_read,
        enable_write   => enable_write,
        memory_address => memory_address,
        memory_write   => memory_write,
        memory_read    => memory_read
    );

    pulse10clock_int: PulseGenerator
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

    clockcounter_inst: ClockCounter
    generic map (
        count_max => ccounter_max
    )
    port map (
        clock  => clock,
        nreset => nreset,
        enable => ccounter_enable,
        creset => ccounter_reset,
        count  => ccounter_out
    );

    change_state: process(clock)
    begin
        if (nreset = '0') then
            controller_cstate <= idle;
        elsif rising_edge(clock) then
            controller_cstate <= controller_nstate;
        end if;
    end process change_state;

    fsm_controller : process(clock)
        constant empty_data : std_logic_vector((data_length - 1) downto 0) := x"0000000000000000";
        constant default_key : std_logic_vector(127 downto 0) := x"6c7bd673045e9d5c29ac6c25db7a3191";
        constant error_text1 : string := "Error type 1: System cannot recognize input format      ";
        constant error_text2 : string := "Error type 2: Storage system exceeded  ";
        constant error_text3 : string := "Error type 3: System is still busy      ";
    begin
        case controller_cstate is
            when idle =>
                if (error_out /= "01" and error_out /= "10") then
                    if (serial_running = '1') then
                        controller_nstate <= reading_serial;
                    end if;
                end if;

            when reading_serial =>
                enable_write <= '1';
                memory_address <= store_address;
                memory_write <= store_data;

                -- start send error if error
                if (error_out = "01" or error_out = "10") then
                    controller_nstate <= sending_error;
                    enable_write <= '0';

                -- wait until reading is done
                elsif (serial_done = '1') then
                    controller_nstate <= setup_xtea1;
                    enable_write <= '0';
                end if;

            when sending_error =>

                -- send error based on types
                if (serial_running = '0') then
                    if (error_out = "01") then
                        send_text(error_text1);
                        controller_nstate <= idle;
                    elsif (error_out = "10") then
                        send_text(error_text2);
                        controller_nstate <= idle;
                    end if;
                end if;

            when setup_xtea1 => -- setup xtea mode
                ccounter_enable <= '1';
                enable_read <= '1';
                memory_address <= (others => '0');
                xtea_mode <= memory_read(0);

                -- wait for 5 clock cycles before next state
                if (ccounter_out = 5) then
                    ccounter_reset <= not ccounter_reset;
                    controller_nstate <= setup_xtea2;
                end if;

            when setup_xtea2 => -- setup xtea key
                memory_address <= (0 => '1', others => '0');
                if (memory_read /= empty_data) then
                    xtea_key <= memory_read;
                else
                    xtea_key <= default_key(127 downto 64);
                end if;

                -- wait for 5 clock cycles before next state
                if (ccounter_out = 5) then
                    ccounter_reset <= not ccounter_reset;
                    controller_nstate <= setup_xtea3;
                end if;

            when setup_xtea3 => -- setup xtea key
                memory_address <= (1 => '1', others => '0');
                if (memory_read /= empty_data) then
                    xtea_key <= memory_read;
                else
                    xtea_key <= default_key(127 downto 64);
                end if;

                -- wait for 5 clock cycles before next state
                if (ccounter_out = 5) then
                    ccounter_reset <= not ccounter_reset;
                    memory_address <= (1, 0 => '1', others => '0');
                    controller_nstate <= starting_xtea;
                end if;

            when starting_xtea =>
                if (memory_read /= empty_data or memory_address /= "0000000000") then
                    xtea_input <= memory_read;
                    pulse10_reset <= not pulse10_reset;
                    xtea_start <= pulse10_out;

                    -- wait for 5 clock cycles before next state
                    if (ccounter_out = 5) then
                        ccounter_reset <= not ccounter_reset;
                        enable_read <= '0';
                        controller_nstate <= processing_xtea;
                    end if;
                else
                    xtea_start <= 'Z';
                    ccounter_reset <= not ccounter_reset;
                    memory_address <= (1, 0 => '1', others => '0');
                    controller_nstate <= reading_results;
                end if;

            when processing_xtea =>
                if (xtea_done = '1') then
                    ccounter_reset <= not ccounter_reset;
                    controller_nstate <= storing_xtea;
                end if;

            when storing_xtea =>
                enable_write <= '1';
                memory_write <= xtea_output;

                -- wait for 5 clock cycles before next state
                if (ccounter_out = 5) then
                    ccounter_reset <= not ccounter_reset;
                    enable_write <= '0';
                    enable_read <= '1';
                    memory_address <= memory_address + 1;
                    controller_nstate <= processing_xtea;
                end if;

            when reading_results =>
                if (memory_read /= empty_data or memory_address /= "0000000000") then
                    send_data <= memory_read;
                    pulse10_reset <= not pulse10_reset;
                    send_start <= pulse10_out;

                    -- wait for 5 clock cycles before next state
                    if (ccounter_out = 5) then
                        ccounter_reset <= not ccounter_reset;
                        enable_read <= '0';
                        controller_nstate <= processing_xtea;
                    end if;
                else
                    send_start <= 'Z';
                    ccounter_reset <= not ccounter_reset;
                    ccounter_enable <= '0';
                    memory_address <= (others => '0');
                    controller_nstate <= idle;
                end if;

            when sending_results =>
                if (serial_done = '1') then
                    ccounter_reset <= not ccounter_reset;
                    memory_address <= memory_address + 1;
                    controller_nstate <= reading_results;
                end if;

        end case;
    end process fsm_controller;
end architecture;