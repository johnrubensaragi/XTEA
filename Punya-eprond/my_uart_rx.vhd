


-- library
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity my_uart_rx is
port(
	clk: in std_logic;
	rst_n: in std_logic;
	rs232_rx: in std_logic;
	clk_bps: in std_logic;
	bps_start: out std_logic;
	rx_data: out std_logic_vector(7 downto 0);
	rx_int : out std_logic
);
end entity my_uart_rx;



architecture RTL of my_uart_rx is

-- signal for interrupt
	signal rs232_rx0,rs232_rx1,rs232_rx2,rs232_rx3: std_logic;
	signal neg_rs232_rx: std_logic;

	signal bps_start_r: std_logic;
	signal num: unsigned(3 downto 0);
	signal rx_int_i: std_logic;
	
	signal rx_temp_data, rx_data_r: std_logic_vector(7 downto 0);


begin

----------------------------------------------------------------

process(clk, rst_n)
begin
	if (rst_n = '0') then 
--		begin
			rs232_rx0 <= '0';
			rs232_rx1 <= '0';
			rs232_rx2 <= '0';
			rs232_rx3 <= '0';
		
--		end;
	elsif (clk='1' and clk'event) then
--		begin
			rs232_rx0 <= rs232_rx;
			rs232_rx1 <= rs232_rx0;
			rs232_rx2 <= rs232_rx1;
			rs232_rx3 <= rs232_rx2;
--		end;
	end if;
end process;

	neg_rs232_rx <= rs232_rx3 and rs232_rx2 and (not rs232_rx1) and (not rs232_rx0);

	process( clk, rst_n)
	begin
		if (rst_n = '0') then
				bps_start_r <= 'Z';
				rx_int_i <= '0';
		elsif clk = '1' and clk'event then
			if (neg_rs232_rx= '1') then
				bps_start_r <= '1';	
				rx_int_i <= '1';			
			elsif (num = "1010") then
				bps_start_r <= '0';
				rx_int_i <= '0';		
			end if;
		end if;
	end process;


	bps_start <= bps_start_r;

	process(clk, rst_n)
	begin
		if (rst_n = '0') then
				rx_temp_data <= "00000000";
				num <= "0000";
				rx_data_r <= "00000000";		
		elsif (clk = '1' and clk'event) then
			if (rx_int_i = '1') then
				if(clk_bps = '1') then
						num <= num + "0001";
						case num is
								when "0001" =>  rx_temp_data(0) <= rs232_rx;	--//0bit
								when "0010" =>  rx_temp_data(1) <= rs232_rx;	--//1bit
								when "0011" =>  rx_temp_data(2) <= rs232_rx;	--//2bit
								when "0100" =>  rx_temp_data(3) <= rs232_rx;	--//3bit
								when "0101" =>  rx_temp_data(4) <= rs232_rx;	--//4bit
								when "0110" =>  rx_temp_data(5) <= rs232_rx;	--//5bit
								when "0111" =>  rx_temp_data(6) <= rs232_rx;	--//6bit
								when "1000" =>  rx_temp_data(7) <= rs232_rx;	--//7bit
								when others =>  
						end case;
--					end;
				elsif (num = "1010") then
						num <= "0000";			
						rx_data_r <= rx_temp_data;	
				end if;
			end if;
		end if;
	end process;


	rx_data <= rx_data_r;	
	rx_int <= rx_int_i;
	
end architecture;
