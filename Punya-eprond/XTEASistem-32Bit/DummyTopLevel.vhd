library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity DummyTopLevel is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        rs232_rx : in std_logic;
        rs232_tx : out std_logic;
        keys : in std_logic_vector(3 downto 0);
        switch : in std_logic_vector(3 downto 0);
        leds : out std_logic_vector(3 downto 0)
    );
end DummyTopLevel;

architecture behavioral of DummyTopLevel is
    constant data_length : natural := 64;
    constant address_length : natural := 10;
    constant default_key : std_logic_vector(127 downto 0) := x"6c7bd673045e9d5c29ac6c25db7a3191";
    constant empty_data : std_logic_vector((data_length-1) downto 0) := (others => '0');
    constant empty_address : std_logic_vector((address_length-1) downto 0) := (others => '0');
    constant newline_vector : std_logic_vector(63 downto 0) := "00001010" & conv_std_logic_vector(0, 48) & "00001010";

    component SerialBlock is
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
        error_out : out std_logic_vector(1 downto 0);
        send_data : in std_logic_vector((data_length-1) downto 0);
        store_data : out std_logic_vector((data_length-1) downto 0);
        store_datatype : out std_logic_vector(1 downto 0);
        store_checkout : out std_logic;
        rs232_rx : in std_logic;
        rs232_tx : out std_logic
    );
    end component SerialBlock;  

    component XTEA is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        xtea_mode : in std_logic;
        xtea_key : in std_logic_vector(127 downto 0);
        xtea_input : in std_logic_vector(63 downto 0);
        xtea_output : out std_logic_vector(63 downto 0);
        xtea_start : in std_logic;
        xtea_done : out std_logic
    );
    end component XTEA;

    component MemoryBlock is
    port(
        clock : in std_logic;
        enable_write : in std_logic;
        memory_address : in std_logic_vector(9 downto 0);
        memory_write : in std_logic_vector(63 downto 0);
        memory_read : out std_logic_vector(63 downto 0)
    );
    end component MemoryBlock;

    component AddressCounter is
    generic(address_length : natural := 10);
    port(
        clock : in std_logic;
        nreset : in std_logic;
        countup_trigger : in std_logic;
        force_enable : in std_logic;
        force_address : in std_logic_vector(1 downto 0);        
        address_out : out std_logic_vector((address_length-1) downto 0)
    );
    end component AddressCounter;

    component MUX1Bit is
    port (
        selector : in std_logic;
        data_in1 : in std_logic;
        data_in2 : in std_logic;
        data_out : out std_logic
    );
    end component MUX1Bit;

    component MUX2Data is
    generic(data_length : natural);
    port(
        selector : in std_logic;
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX2Data;

    component MUX4Data is
    generic(data_length : natural);
    port(
        selector : in std_logic_vector(1 downto 0);
        data_in1 : in std_logic_vector((data_length-1) downto 0);
        data_in2 : in std_logic_vector((data_length-1) downto 0);
        data_in3 : in std_logic_vector((data_length-1) downto 0);
        data_in4 : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component MUX4Data;

    component DEMUX2Data is
    generic (
        data_length : natural
    );
    port (
        selector : in std_logic;
        data_in : in std_logic_vector((data_length-1) downto 0);
        data_out1 : out std_logic_vector((data_length-1) downto 0);
        data_out2 : out std_logic_vector((data_length-1) downto 0)
    );
    end component DEMUX2Data;

    component DEMUX4Data is
    generic(data_length : natural);
    port(
        selector : in std_logic_vector(1 downto 0);
        data_in : in std_logic_vector((data_length-1) downto 0);
        data_out1 : out std_logic_vector((data_length-1) downto 0);
        data_out2 : out std_logic_vector((data_length-1) downto 0);
        data_out3 : out std_logic_vector((data_length-1) downto 0);
        data_out4 : out std_logic_vector((data_length-1) downto 0)
    );
    end component DEMUX4Data;

    component Reg is
    generic(data_length : natural);
    port(
        clock : in std_logic;
        enable : in std_logic;
        clear : in std_logic;
        data_in : in std_logic_vector((data_length-1) downto 0);
        data_out : out std_logic_vector((data_length-1) downto 0)
    );
    end component Reg;

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

    component Controller is
    port (
        -- main clock and reset
        clock : in std_logic;
        nreset : in std_logic;
        enable : in std_logic;
        leds : out std_logic_vector(3 downto 0);

        -- serial block port
        reader_running, sender_running : in std_logic;
        read_done, send_done : in std_logic;
        send_convert : out std_logic;
        store_datatype : in std_logic_vector(1 downto 0);
        error_type : in std_logic_vector(1 downto 0);

        -- address countup port
        store_checkout : in std_logic;
        force_enable : out std_logic;
        force_address : out std_logic_vector(1 downto 0);
        address_atmax : in std_logic;
        maxadd_enable : out std_logic;

        -- memory block port
        enable_write : out std_logic;

        -- xtea block port
        xtea_done : in std_logic;
        dataxtea_enable : out std_logic;
        cont_xtea_mode : in std_logic;

        -- mux and demux selectors
        selector_datawrite : out std_logic;
        selector_dataread, selector_datasend : out std_logic;
        selector_datatext : out std_logic_vector(1 downto 0);
        selector_dataidentifier : out std_logic;

        -- pulse generator port
        sender_pulse_enable, sender_pulse_trigger : out std_logic;
        xtea_pulse_enable, xtea_pulse_trigger : out std_logic;
        countup_pulse_trigger : out std_logic;

        -- clock counter port
        ccounter_enable, ccounter_reset : out std_logic;
        ccounter_out : in natural range 0 to 63;

        -- text roms port
        rom_index_counter : out natural range 0 to 7
    );
    end component Controller;

    -- serial block inout
    signal reader_running, sender_running, read_done, send_done, send_start :  std_logic;
    signal error_out : std_logic_vector(1 downto 0);
    signal send_data, store_data : std_logic_vector((data_length-1) downto 0);
    signal send_convert : std_logic;
    signal store_datatype : std_logic_vector(1 downto 0);
    signal store_checkout : std_logic;

    -- xtea block inout
    signal xtea_start, xtea_done, xtea_mode : std_logic;
    signal xtea_input, xtea_output : std_logic_vector((data_length-1) downto 0);
    signal xtea_key : std_logic_vector(127 downto 0);
    signal cont_xtea_mode : std_logic;

    -- memory block inout
    signal enable_write : std_logic;
    signal memory_write, memory_read : std_logic_vector((data_length-1) downto 0);

    -- address counter inout
    signal force_enable : std_logic;
    signal force_address : std_logic_vector(1 downto 0);
    signal address_out : std_logic_vector((address_length-1) downto 0);
    signal max_data_address : std_logic_vector((address_length-1) downto 0);
    signal address_atmax : std_logic;

    -- mux and demux inout
    signal selector_datawrite : std_logic;
    signal selector_dataread, selector_datasend : std_logic;
    signal selector_datatext : std_logic_vector(1 downto 0);
    signal selector_dataidentifier : std_logic;

    signal dataxtea_write : std_logic_vector((data_length-1) downto 0);
    signal xtea_fullmode, xtea_leftkey, xtea_rightkey, xtea_data : std_logic_vector((data_length-1) downto 0);

    signal dataselected_muxout, datasend_muxout, datatext_muxout : std_logic_vector((data_length-1) downto 0);
    signal datatext_error1, datatext_error2, datatext_error3 : std_logic_vector((data_length-1) downto 0);
    signal datatext_results : std_logic_vector((data_length-1) downto 0);

    -- registers inout
    signal temp_leftkey, temp_rightkey : std_logic_vector((data_length-1) downto 0);
    signal temp_fullmode, temp_dataxtea : std_logic_vector((data_length-1) downto 0);
    signal leftkey_enable, rightkey_enable : std_logic;
    signal fullmode_enable, dataxtea_enable : std_logic;
    signal maxadd_enable : std_logic;

    -- pulse generator inout 
    signal countup_pulse, countup_pulse_trigger : std_logic;
    signal sender_pulse, sender_pulse_enable, sender_pulse_trigger : std_logic;
    signal xtea_pulse, xtea_pulse_enable, xtea_pulse_trigger : std_logic;

    -- clock counter inout
    constant ccounter_max : natural := 64;
    signal ccounter_out : natural range 0 to (ccounter_max-1);
    signal ccounter_enable, ccounter_reset : std_logic;

    -- simple ROM for text constants
    constant rom_length : natural := 8;
    type simple_rom is array(0 to (rom_length-1)) of std_logic_vector((data_length-1) downto 0);
    signal rom_text0, rom_text1, rom_text2, rom_text3 : simple_rom;
    signal rom_index : natural range 0 to (rom_length-1);

    -- function for changing string to slv
    function to_slv(str : string) return std_logic_vector is
        alias str_norm : string(str'length downto 1) is str;
        variable res_v : std_logic_vector(8 * str'length - 1 downto 0);
      begin
        for idx in str_norm'range loop
          res_v(8 * idx - 1 downto 8 * idx - 8) := 
            std_logic_vector(conv_unsigned(character'pos(str_norm(idx)), 8));
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
        reader_running => reader_running,
        sender_running => sender_running,
        read_done      => read_done,
        send_done      => send_done,
        send_start     => send_start,
        send_convert   => send_convert,
        error_out      => error_out,
        send_data      => send_data,
        store_data     => store_data,
        store_datatype => store_datatype,
        store_checkout => store_checkout,
        rs232_rx       => rs232_rx,
        rs232_tx       => rs232_tx
    );

    xteablock_inst: XTEA
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

    memoryblock_inst: MemoryBlock
    port map (
        clock          => clock,
        enable_write   => enable_write,
        memory_address => address_out,
        memory_write   => memory_write,
        memory_read    => memory_read
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

    senderpulse_inst: PulseGenerator
    generic map (
        pulse_width => 5,
        pulse_max   => 8
    )
    port map (
        clock        => clock,
        nreset       => nreset,
        pulse_enable => sender_pulse_enable,
        pulse_reset  => sender_pulse_trigger,
        pulse_out    => sender_pulse
    );

    xteapulse_inst: PulseGenerator
    generic map (
        pulse_width => 5,
        pulse_max   => 8
    )
    port map (
        clock        => clock,
        nreset       => nreset,
        pulse_enable => xtea_pulse_enable,
        pulse_reset  => xtea_pulse_trigger,
        pulse_out    => xtea_pulse
    );

    countuppulse_inst: PulseGenerator
    generic map (
      pulse_width => 5,
      pulse_max   => 8
    )
    port map (
      clock        => clock,
      nreset       => nreset,
      pulse_enable => '1',
      pulse_reset  => countup_pulse_trigger,
      pulse_out    => countup_pulse
    );

    -- attach pulse gen to start xtea and sender
    xtea_start <= xtea_pulse;
    send_start <= sender_pulse;

    addresscounter_inst: AddressCounter
    generic map (
        address_length => address_length
    )
    port map (
        clock           => clock,
        nreset          => nreset,
        countup_trigger => countup_pulse,
        force_enable    => force_enable,
        force_address   => force_address,
        address_out     => address_out
    );

    datawrite_mux_inst: MUX2Data
    generic map (data_length)
    port map (
        selector => selector_datawrite, -- 1 bit selector for storing xtea or reader
        data_in1 => dataxtea_write, -- '0' for data to process
        data_in2 => xtea_output, -- '1' for xtea output
        data_out => memory_write
    );

    dataread_demux_inst: DEMUX2Data
    generic map (data_length)
    port map (
        selector  => selector_dataread, -- 1 bit selector for inputting xtea or sender
        data_in   => memory_read,
        data_out1 => temp_dataxtea, -- '0' for xtea input
        data_out2 => datasend_muxout -- '1' for serial sender input
    );

    dataxtea_demux_inst: DEMUX4Data
    generic map (data_length)
    port map (
        selector  => store_datatype, -- 2 bit selector for xtea inputs
        data_in   => store_data,
        data_out1 => temp_leftkey, -- "00" for xtea leftkey : key(127 downto 64)
        data_out2 => temp_rightkey, -- "01" for xtea rightkey : key(63 downto 0)
        data_out3 => temp_fullmode, -- "10" for xtea mode
        data_out4 => dataxtea_write -- "11" for xtea input
    );

    -- register to save address maximum for data
    maxadd_reg : Reg generic map (address_length) port map (clock, maxadd_enable, nreset, address_out, max_data_address);
    address_atmax <= '1' when (address_out = max_data_address) else '0';

    -- truncate the data for xtea inputs
    xtea_key(127 downto 64) <= xtea_leftkey when (xtea_leftkey /= empty_data) else default_key(127 downto 64);
    xtea_key(63 downto 0) <= xtea_rightkey when (xtea_rightkey /= empty_data) else default_key(63 downto 0);
    xtea_mode <= xtea_fullmode(0);
    xtea_input <= xtea_data;

    -- save the xtea mode to send to controller
    cont_xtea_mode <= xtea_fullmode(0);

    -- xtea registers to preserve data
    leftkey_reg : Reg generic map(data_length) port map(clock, leftkey_enable, nreset, temp_leftkey, xtea_leftkey);
    rightkey_reg : Reg generic map(data_length) port map(clock, rightkey_enable, nreset, temp_rightkey, xtea_rightkey);
    fullmode_reg : Reg generic map(data_length) port map(clock, fullmode_enable, nreset, temp_fullmode, xtea_fullmode);

    dataxtea_reg : Reg generic map(data_length) port map(clock, dataxtea_enable, nreset, temp_dataxtea, xtea_data);
    
    -- only enable register when selected
    leftkey_enable <= '1' when (store_datatype = "00" and store_checkout = '1') else '0';
    rightkey_enable <= '1' when (store_datatype = "01" and store_checkout = '1') else '0';
    fullmode_enable <= '1' when (store_datatype = "10" and store_checkout = '1') else '0';
    
    mux2data_inst: MUX2Data
    generic map (
      data_length => data_length
    )
    port map (
      selector => selector_dataidentifier, -- 1 bit selector for sending data or newline
      data_in1 => dataselected_muxout, -- '0' for sending data
      data_in2 => newline_vector, -- '1' for sending newline
      data_out => send_data
    );

    datasend_mux_inst: MUX2Data
    generic map (data_length)
    port map (
        selector => selector_datasend, --  1 bit selector for data to send
        data_in1 => datasend_muxout, -- '0' for data from memory
        data_in2 => datatext_muxout, -- '1' for data from text constants
        data_out => dataselected_muxout
    );

    datatext_mux_inst: MUX4Data
    generic map (data_length)
    port map (
        selector => selector_datatext, -- 2 bit selector for text constants
        data_in1 => datatext_results, -- "00" for text results
        data_in2 => datatext_error1, -- "01" for error type 1 : wrong format input
        data_in3 => datatext_error2, -- "10" for error type 2 : memory full
        data_in4 => datatext_error3, -- "11" for error type 3 : system stil processing
        data_out => datatext_muxout
    );

    -- fill each text roms with text constants and update them per clock
    text_roms : process(clock)
        constant results_text : string := "System results from processing XTEA:   " & LF;
        constant error_text1 : string := "Error type 1: System cannot recognize input format     " & LF;
        constant error_text2 : string := "Error type 2: Storage system exceeded  " & LF;
        constant error_text3 : string := "Error type 3: System is still busy     " & LF;
        constant results_vector : std_logic_vector((8*results_text'length-1) downto 0) := to_slv(results_text);
        constant error_vector1 : std_logic_vector((8*error_text1'length-1) downto 0) := to_slv(error_text1);
        constant error_vector2 : std_logic_vector((8*error_text2'length-1) downto 0) := to_slv(error_text2);
        constant error_vector3 : std_logic_vector((8*error_text3'length-1) downto 0) := to_slv(error_text3);
    begin
        for idx in 1 to (rom_length-1) loop
            if (idx <= results_vector'length/64) then 
                rom_text0(idx) <= results_vector(results_vector'length-1-64*(idx-1) downto results_vector'length-(64*(idx)));
            end if;
            if (idx <= error_vector1'length/64) then 
                rom_text1(idx) <= error_vector1(error_vector1'length-1-64*(idx-1) downto error_vector1'length-(64*(idx)));
            end if;
            if (idx <= error_vector2'length/64) then 
                rom_text2(idx) <= error_vector2(error_vector2'length-1-64*(idx-1) downto error_vector2'length-(64*(idx)));
            end if;
            if (idx <= error_vector3'length/64) then 
                rom_text3(idx) <= error_vector3(error_vector3'length-1-64*(idx-1) downto error_vector3'length-(64*(idx)));
            end if;
        end loop;
        
        if rising_edge(clock) then
            datatext_results <= rom_text0(rom_index);
            datatext_error1 <= rom_text1(rom_index);
            datatext_error2 <= rom_text2(rom_index);
            datatext_error3 <= rom_text3(rom_index);
        end if;
    end process text_roms;

    controller_inst: Controller
    port map (
        clock                   => clock,
        nreset                  => nreset,
        enable                  => '1',
        leds                    => leds,
        reader_running          => reader_running,
        sender_running          => sender_running,
        read_done               => read_done,
        send_done               => send_done,
        send_convert            => send_convert,
        store_datatype          => store_datatype,
        error_type              => error_out,
        store_checkout          => store_checkout,
        force_enable            => force_enable,
        force_address           => force_address,
        address_atmax           => address_atmax,
        maxadd_enable           => maxadd_enable,
        enable_write            => enable_write,
        xtea_done               => xtea_done,
        dataxtea_enable         => dataxtea_enable,
        cont_xtea_mode          => cont_xtea_mode,
        selector_datawrite      => selector_datawrite,
        selector_dataread       => selector_dataread,
        selector_datasend       => selector_datasend,
        selector_datatext       => selector_datatext,
        selector_dataidentifier => selector_dataidentifier,
        sender_pulse_enable     => sender_pulse_enable,
        sender_pulse_trigger    => sender_pulse_trigger,
        xtea_pulse_enable       => xtea_pulse_enable,
        xtea_pulse_trigger      => xtea_pulse_trigger,
        countup_pulse_trigger   => countup_pulse_trigger,
        ccounter_enable         => ccounter_enable,
        ccounter_reset          => ccounter_reset,
        ccounter_out            => ccounter_out,
        rom_index_counter       => rom_index
    );

end architecture;