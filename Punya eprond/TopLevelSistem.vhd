library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity TopLevelSistem is
    generic(data_length : natural := 64; address_length : natural := 10);
    port(
        clock : in std_logic;
        nreset : inout std_logic;
        read_input : in std_logic_vector(7 downto 0);
        start_read, trigger : in std_logic
    );
end TopLevelSistem;

architecture behavioral of TopLevelSistem is
    component SerialReader is
        generic(data_length, address_length : natural);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            trigger : in std_logic;
            start_read : in std_logic;
            read_in : in std_logic_vector(7 downto 0);
            check_error : out std_logic;
            serial_address : out std_logic_vector((address_length - 1 ) downto 0);
            serial_data :out std_logic_vector((data_length - 1) downto 0);
            serial_done : out std_logic
        );    
    end component SerialReader;

    component SRAM is
        generic(data_length, address_length : integer);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            enable_read, enable_write : in std_logic;
            memory_address : in std_logic_vector((address_length - 1) downto 0);
            memory_write : in std_logic_vector((data_length - 1) downto 0);
            memory_read : out std_logic_vector((data_length - 1) downto 0)
        );    
    end component SRAM;

    component XTEA is
        port(
            clock, nreset : in std_logic;
            xtea_key : in std_logic_vector(127 downto 0);
            xtea_input : in std_logic_vector(63 downto 0);
            xtea_mode : in std_logic;
            xtea_start : in std_logic;
            xtea_output : out std_logic_vector(63 downto 0);
            xtea_done : out std_logic
        );    
    end component XTEA;

    component ClockCounter is
        generic(count_length : natural);
        port(
            clock : in std_logic;
            creset : in std_logic;
            count : out std_logic_vector((count_length-1) downto 0)
        );
    end component ClockCounter;

    signal enable_read, enable_write : std_logic := '0';
    signal serial_address, memory_address : std_logic_vector((address_length - 1) downto 0);
    signal serial_data, memory_write, memory_read : std_logic_vector((data_length - 1) downto 0);
    signal serial_done, check_error : std_logic := '0';
    
    constant empty_data : std_logic_vector((data_length - 1) downto 0) := x"0000000000000000";
    constant default_key : std_logic_vector(127 downto 0) := x"6c7bd673045e9d5c29ac6c25db7a3191";

    signal xtea_key : std_logic_vector(127 downto 0);
    signal xtea_input, xtea_output : std_logic_vector((data_length - 1) downto 0);
    signal xtea_mode, xtea_start, xtea_done : std_logic;
    
    type controller_states is (idle, reading_serial, sending_error, setup_xtea1, setup_xtea2, setup_xtea3, starting_xtea, processing_xtea, storing_xtea, sending_results);
    signal controller_cstate, controller_nstate : controller_states;

    signal clock_count : std_logic_vector(4 downto 0);
    signal creset : std_logic := '0';

begin
    ram : SRAM generic map(data_length, address_length)
    port map(clock, nreset, enable_read, enable_write, memory_address, memory_write, memory_read);

    reader : SerialReader generic map(data_length, address_length)
    port map(clock, nreset, trigger, start_read, read_input, check_error, serial_address, serial_data, serial_done);

    xtea_block : XTEA port map(clock, nreset, xtea_key, xtea_input, xtea_mode, xtea_start, xtea_output, xtea_done);

    clock_counter : ClockCounter generic map(5) port map(clock, creset, clock_count);

    ccounter_reset : process(controller_cstate)
    begin
        creset <= not creset;
    end process ccounter_reset;

    process(clock, nreset)
    begin
        if rising_edge(clock) then
            if (nreset = '0') then
                controller_cstate <= idle;
            else
                controller_cstate <= controller_nstate;
            end if;
        end if;
    end process;

    controller : process(controller_cstate, read_input, start_read, serial_address, serial_done, check_error, xtea_done, clock_count, creset)
    begin
        if (check_error = '1') then
            nreset <= '0';
        else
            case(controller_cstate) is
                when idle =>
                    if (start_read = '1') then
                        controller_nstate <= reading_serial;
                    else
                        controller_nstate <= controller_cstate;
                    end if;
                
                when reading_serial =>
                    if (serial_done = '1') then
                        controller_nstate <= setup_xtea1;
                    else
                        controller_nstate <= controller_cstate;
                    end if;
                        enable_write <= '1';
                        memory_write <= serial_data;
                        memory_address <= serial_address;

                when sending_error =>
                    controller_nstate <= idle;
                    
                when setup_xtea1 =>
                    enable_write <= '0';
                    enable_read <= '1';
                    memory_address <= (others => '0');
                    xtea_mode <= memory_read(0);

                    if (clock_count = "00001") then
                        controller_nstate <= setup_xtea2;
                    end if;
                    
                when setup_xtea2 =>
                    memory_address <= (0 => '1', others => '0');
                    if (memory_read = empty_data) then
                        xtea_key(127 downto 64) <= default_key(127 downto 64);
                    else
                        xtea_key(127 downto 64) <= memory_read;
                    end if;

                    if (clock_count = "00011") then
                        controller_nstate <= setup_xtea3;
                    end if;
                    
                when setup_xtea3 =>
                    memory_address <= (1 => '1', others => '0');
                    if (memory_read = empty_data) then
                        xtea_key(63 downto 0) <= default_key(63 downto 0);
                    else
                        xtea_key(63 downto 0) <= memory_read;
                    end if;

                    if (clock_count = "00001") then
                        controller_nstate <= starting_xtea;
                    end if;
                    
                when starting_xtea =>
                    if (clock_count = "00000") then
                        memory_address <= memory_address + 1;
                    end if;

                    enable_read <= '1';
                    enable_write <= '0';
                    xtea_start <= '1';

                    if (memory_read = empty_data) then
                        xtea_start <= '0';
                        controller_nstate <= sending_results;
                    else
                        xtea_input <= memory_read;
                        if (clock_count = "00011") then
                            controller_nstate <= processing_xtea;
                        end if;
                    end if;

                when processing_xtea =>
                    if (xtea_done = '1') then
                        xtea_start <= '0';
                        controller_nstate <= storing_xtea;
                    else
                        controller_nstate <= controller_cstate;
                    end if;

                when storing_xtea =>
                    enable_read <= '0';
                    enable_write <= '1';
                    memory_write <= xtea_output;

                    if (clock_count = "00001") then
                        if (memory_address = "1111111111") then
                            controller_nstate <= sending_results;
                        else
                            controller_nstate <= starting_xtea;
                        end if;
                    end if;

                when sending_results =>
                    controller_nstate <= idle;

                when others =>
                    controller_nstate <= idle;
            end case;
        end if;
    end process controller;
end behavioral;