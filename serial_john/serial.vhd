library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        nreset:     in  std_logic;
        clk:        in  std_logic;                      -- 50 MHz

        rx:         in  std_logic;                      -- 115200 baud
        d_out_ready:out std_logic;                      -- jika ada data baru (ditandai dengan stop bit), new_data <= '1'
        d_out:      out std_logic_vector(7 downto 0);   -- data yang keluar besarnya 1 karakter (8 bit)
        serial_end: out  std_logic;                     -- jika semua data (keseluruhan string) telah diterima, serial_end <= '1'
                              
        d_in:       in  std_logic_vector(7 downto 0);   -- data yang masuk
        d_in_ready: in  std_logic;                      -- jika d_in_ready = '1', data sudah siap ditransmit
        d_in_transmitted:  out std_logic;               -- bernilai '1' jika data sudah selesai dikirim
        tx:         out std_logic
        
        --;led:        out std_logic_vector(3 downto 0)    -- debug purpose
    );
end top;

architecture arch of top is
    signal d : std_logic_vector(7 downto 0) := (others => '0');
    signal count_rx : integer := 0;
    signal count_tx : integer := 0;
    signal count_bit_rx: integer := 0;
    signal count_bit_tx: integer := 0;
    type state is (idle, active);
    signal state_rx: state := idle;
    signal state_tx: state := idle;
    signal rx_buffer : std_logic_vector(3 downto 0) := "1111";      -- ensuring protection against hazards (instead of just falling edge)
    constant baud_rate: integer := 115200;                          -- baud rate
    constant freq: integer := 50e6;                                 -- FPGA freq in Hz
    constant timeOut : integer := 2*freq/baud_rate;                 -- time out duration to indicate the rx is done
    signal t : integer := 0;                                        -- time since last rx = '0'

begin

    process(clk)
    begin
        if nreset = '1' then
            d_out_ready <= '0';
            d_out <= (others => '0');
            serial_end <= '1';
            d_in_transmitted <= '0';
            tx <= '1';
            d <= (others => '0');
            count_rx <= 0;
            count_tx <= 0;
            count_bit_rx <= 0;
            state_rx <= idle;
            state_tx <= idle;
            rx_buffer <= "1111";
            t <= timeOut;

        else
            if(clk'event and clk = '1') then
                --if(s = idle) then led <= "0110";
                --elsif(s = receive) then led <= "1101";
                --elsif(s = transmit) then led <= "1011";
                --end if;
                rx_buffer <= rx_buffer(2 downto 0) & rx;
                if(rx = '0') then
                    t <= 0;
                elsif t < timeOut then
                    t <= t + 1;
                end if;

                if state_rx = idle then
                    if(rx_buffer = "1100") then
                        d_out_ready <= '0';
                        serial_end <= '0';
                        state_rx <= active;
                        count_rx <= count_rx + 1;
                    elsif (rx = '1' and t = timeOut) then
                        serial_end <= '1';
                    else
                        count_rx <= 0;
                    end if;
                else
                    if count_rx = 3*freq/(2*baud_rate) then -- bit 0
                        d(0) <= rx;
                        count_bit_rx <= 1;
                    elsif count_rx = 5*freq/(2*baud_rate) then -- bit 1
                        d(1) <= rx;
                        count_bit_rx <= 2;
                    elsif count_rx = 7*freq/(2*baud_rate) then -- bit 2
                        d(2) <= rx;
                        count_bit_rx <= 3;
                    elsif count_rx = 9*freq/(2*baud_rate) then -- bit 3
                        d(3) <= rx;
                        count_bit_rx <= 4;
                    elsif count_rx = 11*freq/(2*baud_rate) then -- bit 4
                        d(4) <= rx;
                        count_bit_rx <= 5;
                    elsif count_rx = 13*freq/(2*baud_rate) then -- bit 5
                        d(5) <= rx;
                        count_bit_rx <= 6;
                    elsif count_rx = 15*freq/(2*baud_rate) then -- bit 6
                        d(6) <= rx;
                        count_bit_rx <= 7;
                    elsif count_rx = 17*freq/(2*baud_rate) then -- bit 7
                        d(7) <= rx;
                        count_bit_rx <= 8;
                    elsif count_rx = 18*freq/(2*baud_rate) then -- stop bit
                        d_out <= d;
                        state_rx <= idle;
                        d_out_ready <= '1';
                    end if;
                    if count_rx = 20*freq/(2*baud_rate)-1 then -- end
                        count_rx <= 0;
                        count_bit_rx <= 0;
                        
                    else 
                        count_rx <= count_rx + 1;
                    end if;
                end if;

                if state_tx = idle then
                    tx <= '1';
                    count_tx <= 0;
                    if d_in_ready = '1' then
                        state_tx <= active;
                        d_in_transmitted <= '0';
                    end if;
                elsif state_tx = active then
                    if(count_tx = 0) then      --start bit
                        tx <= '0';
                    elsif count_tx = freq/baud_rate then   -- bit 1
                        tx <= d_in(0);
                        count_bit_tx <= 1;
                    elsif count_tx = 2*freq/baud_rate then
                        tx <= d_in(1);
                        count_bit_tx <= 2;
                    elsif count_tx = 3*freq/baud_rate then
                        tx <= d_in(2);
                        count_bit_tx <= 3;
                    elsif count_tx = 4*freq/baud_rate then
                        tx <= d_in(3);
                        count_bit_tx <= 4;
                    elsif count_tx = 5*freq/baud_rate then
                        tx <= d_in(4);
                        count_bit_tx <= 5;
                    elsif count_tx = 6*freq/baud_rate then
                        tx <= d_in(5);
                        count_bit_tx <= 6;
                    elsif count_tx = 7*freq/baud_rate then
                        tx <= d_in(6);
                        count_bit_tx <= 7;
                    elsif count_tx = 8*freq/baud_rate then
                        tx <= d_in(7);
                        count_bit_tx <= 8;
                    elsif count_tx = 9*freq/baud_rate then --stop bit
                        tx <= '1';
                        d_in_transmitted <= '1';
                        count_bit_tx <= 0;
                    end if;
                
                    if count_tx = 10*freq/baud_rate then --reset
                        count_tx <= 0;
                        state_tx <= idle;
                    else
                        count_tx <= count_tx + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
end architecture;