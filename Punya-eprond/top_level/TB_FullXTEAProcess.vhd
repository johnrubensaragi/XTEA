library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity TB_FullXTEAProcess is
end TB_FullXTEAProcess;
        
architecture sim of TB_FullXTEAProcess is
    constant clock_frequency : natural := 50e6; -- 50 MHz
    constant clock_period : time := 1 sec / clock_frequency;
    constant baud_rate : natural := 115200; -- 115200 bps
    constant baud_period : time := 1 sec / baud_rate;

    constant data_length : natural := 64;
    constant address_length : natural := 10;
    constant encrypt_input : string := "-m 0 -k password -d " & '"' & "Ini merupakan data yang sangat rahasia dan perlu diperahasiakan okey." & '"' & LF;
    constant decrypt_input : string := "-m 1 -k password -d " & '"';

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';
    signal error_out : std_logic_vector(1 downto 0) := (others => '0');

    signal rs232_rx1, rs232_tx1 : std_logic := '1';
    signal rs232_rx2, rs232_tx2 : std_logic := '1';

    signal uart_vector1 : std_logic_vector((encrypt_input'length*10-1) downto 0);
    signal uart_vector2 : std_logic_vector((decrypt_input'length*10-1) downto 0);
    signal uart_vector3 : std_logic_vector(19 downto 0);
    signal uart_tx1, uart_tx2 : std_logic := '1';
    signal bps_clock : std_logic;
    signal receive_selector : std_logic := '0';

    signal counter : natural := 0;

    signal keys1, switch1, leds1 : std_logic_vector(3 downto 0);
    signal keys2, switch2, leds2 : std_logic_vector(3 downto 0);

    component DummyTopLevel is
    port(
        clock : in std_logic;
        nreset : in std_logic;
        rs232_rx : in std_logic;
        rs232_tx : out std_logic;
        keys : in std_logic_vector(3 downto 0);
        switch : in std_logic_vector(3 downto 0);
        leds : out std_logic_vector(3 downto 0)
    );
    end component DummyTopLevel;

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
    XteaSistem1_inst: DummyTopLevel
    port map (
        clock    => clock,
        nreset   => nreset,
        rs232_rx => rs232_rx1,
        rs232_tx => rs232_tx1,
        keys     => keys1,
        switch   => switch1,
        leds     => leds1
    );

    XteaSistem2_inst: DummyTopLevel
    port map (
        clock    => clock,
        nreset   => nreset,
        rs232_rx => rs232_rx2,
        rs232_tx => rs232_tx2,
        keys     => keys2,
        switch   => switch2,
        leds     => leds2
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

    rs232_rx1 <= uart_tx1;
    rs232_rx2 <= uart_tx2 when (receive_selector = '0') else rs232_tx1;

    uart_vector1 <= to_rs232(encrypt_input);
    uart_vector2 <= to_rs232(decrypt_input);
    uart_vector3 <= to_rs232('"' & LF);

    full_process_test : process
        variable bit10_v : std_logic_vector(9 downto 0);
    begin
        nreset <= '0';
        wait for 5*clock_period;
        nreset <= '1';
        wait for 8*(2**address_length)*clock_period;

        -- initiate toplevel2 by sending the xtea mode and key
        receive_selector <= '0';
        wait for clock_period;
        for char in uart_vector2'length/10 downto 1 loop
            bit10_v := uart_vector2(10*char - 1 downto 10*char - 10);
            for num in 9 downto 0 loop
            if (num /= 9 and num /= 0) then
                uart_tx2 <= bit10_v(9-num);
            else
                uart_tx2 <= bit10_v(num);
            end if;
            counter <= counter + 1;
            wait until rising_edge(bps_clock);
            end loop;
        end loop;

        -- send message to toplevel1
        for char in uart_vector1'length/10 downto 1 loop
            bit10_v := uart_vector1(10*char - 1 downto 10*char - 10);
            for num in 9 downto 0 loop
            if (num /= 9 and num /= 0) then
                uart_tx1 <= bit10_v(9-num);
            else
                uart_tx1 <= bit10_v(num);
            end if;
            counter <= counter + 1;
            wait until rising_edge(bps_clock);
            end loop;
        end loop;
        
        
        -- wait until all encrypted data finished sent from toplevel1 to toplevel2
        wait for baud_period;
        receive_selector <= '1';
        wait for clock_period;
        wait for 24*encrypt_input'length*baud_period;

        -- add data identifier and newline character add the end
        receive_selector <= '0';
        wait for clock_period;
        for char in uart_vector3'length/10 downto 1 loop
            bit10_v := uart_vector3(10*char - 1 downto 10*char - 10);
            for num in 9 downto 0 loop
            if (num /= 9 and num /= 0) then
                uart_tx2 <= bit10_v(9-num);
            else
                uart_tx2 <= bit10_v(num);
            end if;
            counter <= counter + 1;
            wait until rising_edge(bps_clock);
            end loop;
        end loop;

        wait;
    end process full_process_test;
end sim;