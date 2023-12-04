library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_Reader is
end TB_Reader;
        
architecture sim of TB_Reader is
    constant clock_frequency : natural := 50e6; -- 50 MHz
    constant clock_period : time := 1 sec / clock_frequency;
    constant baud_rate : natural := 115200; -- 9600 bps
    signal d_out_ready: std_logic;                      -- jika ada data baru (ditandai dengan stop bit), new_data <= '1'
    signal d_out:       std_logic_vector(7 downto 0);   -- data yang keluar besarnya 1 karakter (8 bit)
    signal serial_end:   std_logic;                     -- jika semua data (keseluruhan string) telah diterima, serial_end <= '1'
    signal d_in:        std_logic_vector(7 downto 0);   -- data yang masuk
    signal d_in_ready:   std_logic;                      -- jika d_in_ready = '1', data sudah siap ditransmit
    signal d_in_transmitted:  std_logic;               -- bernilai '1' jika data sudah selesai dikirim

    
    constant string_input : string :=  "-m 0 -d " & '"' & "Ini merupakan data yang sangat rahasia dan perlu diperahasiakan okey." & '"' & " -k password" & LF;

    signal clock : std_logic := '0';
    signal nreset : std_logic := '1';
    
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
    serialblock_inst: entity work.my_uart_top
    port map (
        nreset => nreset,
        clk => clock,
        rx => rs232_rx,
        d_out_ready => d_out_ready,
        d_out => d_out,
        serial_end => serial_end,
        d_in => d_in,
        d_in_ready => d_in_ready,
        d_in_transmitted => d_in_transmitted,
        tx => rs232_tx
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
        nreset <= not nreset;
        wait for 2*clock_period;
        nreset <= not nreset;
        wait for 1 sec/baud_rate;

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