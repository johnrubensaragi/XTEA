library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity TB_DummyTopLevel is
end TB_DummyTopLevel;
        
architecture sim of TB_DummyTopLevel is
    constant clock_frequency : natural := 50e6; -- 50 MHz
    constant clock_period : time := 1 sec / clock_frequency;
    constant baud_rate : natural := 115200; -- 115200 bps

    constant data_length : natural := 64;
    constant address_length : natural := 10;
    constant string_input : string := "-m 0 -d " & '"' & "Ini merupakan data yang sangat rahasia dan perlu diperahasiakan okey." & '"' & " -k password" & LF;

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';
    signal error_out : std_logic_vector(1 downto 0) := (others => '0');

    signal rs232_rx, rs232_tx : std_logic := '1';

    signal uart_vector : std_logic_vector((string_input'length*10-1) downto 0);
    signal uart_tx : std_logic := '1';
    signal bps_clock : std_logic;

    signal counter : natural := 0;

    signal keys, switch, leds : std_logic_vector(3 downto 0);

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

    dummytoplevel_inst: entity work.DummyTopLevel
    port map (
        clock    => clock,
        nreset   => nreset,
        rs232_rx => rs232_rx,
        rs232_tx => rs232_tx,
        keys     => keys,
        switch   => switch,
        leds     => leds
    );

    clockdiv_inst: ClockDiv
    generic map (
      div_frequency   => baud_rate,
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
        wait for 5*clock_period;
        nreset <= '1';
        wait for 100*clock_period;

        for char in uart_vector'length/10 downto 1 loop
            bit10_v := uart_vector(10*char - 1 downto 10*char - 10);
            for num in 9 downto 0 loop
            if (num /= 9 and num /= 0) then
                uart_tx <= bit10_v(9-num);
            else
                uart_tx <= bit10_v(num);
            end if;
            counter  <= counter + 1;
            wait until bps_clock'event;
            end loop;
        end loop;
        
        wait;
    end process serial_test;
end sim;