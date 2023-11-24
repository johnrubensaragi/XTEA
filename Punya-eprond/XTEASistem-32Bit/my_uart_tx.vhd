-- Arif Sasongko

-- library
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity my_uart_tx is
port(
				clk,rst_n : in std_logic;
				tx_data : in std_logic_vector(7 downto 0);
				tx_int : in std_logic;
				rs232_tx : out std_logic;
				clk_bps: in std_logic;
				bps_start : out std_logic

);
end entity my_uart_tx;

--architecture

architecture RTL of my_uart_tx is
	signal tx_int0,tx_int1,tx_int2, rs232_tx_r : std_logic;
	signal neg_tx_int : std_logic;
	signal tx_data_i : std_logic_vector(7 downto 0);
	signal bps_start_r : std_logic;
	signal tx_en: std_logic;
	signal num : unsigned(3 downto 0);

	
begin
-- The process below is to ensure 'neg_rx_int' react to negative edge of rx interrupt 
	process (clk,rst_n)
	begin
		if rst_n = '0' then
			tx_int0 <='0';
			tx_int1 <='0';
			tx_int2 <='0';
		elsif (clk = '1' and clk'event) then
			tx_int0 <= tx_int;
			tx_int1 <= tx_int0;
			tx_int2 <= tx_int1;		
		end if;
	end process;

	neg_tx_int <=  ((not tx_int1) and tx_int2);


	
-- The process below is to control the transmission process:
-- --> take data from input (freeze the data)
-- --> generate bps_start_r signal
-- --> enable transmit signal (tx_en)

	process( clk, rst_n)
	begin
		if rst_n = '0' then
			bps_start_r <= 'Z';
			tx_en <= '0';
			tx_data_i <= "00000000";
		elsif (clk= '1' and clk'event) then
			if (neg_tx_int = '1') then
				bps_start_r <= '1';
				tx_data_i <= tx_data;
				tx_en <= '1';
			elsif (num = "1011") then
				bps_start_r <= '0';
				tx_en <= '0';				
			end if;
		end if;
	end process;
	
	bps_start <= bps_start_r;


-- The process below send the data through the rs232_tx_r when tx_en is '1':
-- --> take data from input (freeze the data)
-- --> generate bps_start_r signal
-- --> enable transmit signal (tx_en)
	
	process(clk, rst_n)
	begin
		if (rst_n = '0') then
			num <= "0000";
			rs232_tx_r <= '1';
		elsif (clk = '1' and clk'event) then
			if(tx_en = '1') then
				if(clk_bps = '1')	then
						num <= num + "0001";
						case num is
							when "0000" => rs232_tx_r <= '0' ; 	
							when "0001" => rs232_tx_r <= tx_data_i(0);	
							when "0010" => rs232_tx_r <= tx_data_i(1);	
							when "0011" => rs232_tx_r <= tx_data_i(2);	
							when "0100" => rs232_tx_r <= tx_data_i(3);	
							when "0101" => rs232_tx_r <= tx_data_i(4);	
							when "0110" => rs232_tx_r <= tx_data_i(5);	
							when "0111" => rs232_tx_r <= tx_data_i(6);	
							when "1000" => rs232_tx_r <= tx_data_i(7);	
							when "1001" => rs232_tx_r <= '1';	
							when others => rs232_tx_r <= '1';
						end case;
				elsif(num= "1011") then
					num <= "0000"; 
				end if;	
			end if;		
		end if;
	end process;

 rs232_tx <= rs232_tx_r;

end architecture;
