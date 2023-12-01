library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity TB_Reader is
end TB_Reader;
        
architecture sim of TB_Reader is
    constant clock_frequency : natural := 50e6; -- 50 MHz
    constant clock_period : time := 1 sec / clock_frequency;
    constant baud_rate : natural := 115200; -- 115200 bps

    constant data_length : natural := 64;
    constant address_length : natural := 10;
    constant string_input : string :=  "-m 1 -k password1234 -d ABC241BACF910580A8070C0A";

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';
    signal error_out : std_logic_vector(1 downto 0) := (others => '0');

    signal reader_running, sender_running, send_done, read_done : std_logic;
    signal store_data : std_logic_vector((data_length - 1) downto 0);
    signal store_datatype : std_logic_vector(1 downto 0);
    signal store_checkout : std_logic;
    signal send_data : std_logic_vector((data_length - 1) downto 0);
    signal send_start : std_logic;

    signal rs232_rx, rs232_tx : std_logic := '1';

    signal uart_vector : std_logic_vector((string_input'length*10-1) downto 0);
    signal uart_tx : std_logic := '1';
    signal bps_clock : std_logic;

    signal counter : natural := 0;

    component ClockDiv is
        generic(div_frequency, clock_frequency : natural);
        port(
            clock_in: in std_logic;
            clock_out: out std_logic
        );
    end component ClockDiv;

    function to_rs232(str : string) return std_logic_vector is
        alias str_norm : string(str'length downto 1) is str;
        variable res_v : std_logic_vector(10 * str'length - 1 downto 0);
      begin
        for idx in str_norm'range loop
          res_v(10 * idx - 1 downto 10 * idx - 10) := 
            '0' & std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8)) & '1';
        end loop;
        return res_v;
    end function;

begin
    serialblock_inst: entity work.SerialBlock
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
        send_convert   => '0',
        error_out      => error_out,
        send_data      => send_data,
        store_data     => store_data,
        store_datatype => store_datatype,
        store_checkout => store_checkout,
        rs232_rx       => rs232_rx,
        rs232_tx       => rs232_tx
    );  

    clockdiv_inst: ClockDiv
    generic map (
      div_frequency   => 2*baud_rate,
      clock_frequency => clock_frequency
    )
    port map (
      clock_in   => clock,
      clock_out => bps_clock
    );

    clock <= not clock after clock_period / 2;

    rs232_rx <= uart_tx;
    uart_vector <= to_rs232(string_input);

    serial_test : process
        variable bit10_v : std_logic_vector(9 downto 0);
    begin
        nreset <= '0';
        wait for 2*clock_period;
        nreset <= '1';
        wait for 0.5 sec/baud_rate;

        for char in uart_vector'length/10 downto 1 loop
            bit10_v := uart_vector(10*char - 1 downto 10*char - 10);
            for num in 9 downto 0 loop
                if (num /= 9 and num /= 0) then
                    uart_tx <= bit10_v(9-num);
                else
                    uart_tx <= bit10_v(num);
                end if;
                counter  <= counter + 1;
                wait until rising_edge(bps_clock);
            end loop;
        end loop;

        wait;
    end process serial_test;
end sim;