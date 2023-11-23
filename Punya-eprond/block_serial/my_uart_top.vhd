-- Very simple UART implementation
-- by Arif Sasongko

-- library
-- library IEEE;
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity
Entity my_uart_top is
port(
		clock 			: in std_logic;
		nreset	 		: in std_logic;
		
-- paralel part
		send 			: in std_logic;
		send_data		: in std_logic_vector(7 downto 0) ;
		receive 		: out std_logic;
		receive_data	: out std_logic_vector(7 downto 0) ;
		
-- serial part
		rs232_rx 	: in std_logic;
		rs232_tx 	: out std_logic
);
end entity;

-- Architecture
Architecture structural of my_uart_top is

	component my_uart_tx is
	port(
				clk,rst_n 	: in std_logic;
				tx_data 		: in std_logic_vector(7 downto 0);
				tx_int 		: in std_logic;
				rs232_tx 	: out std_logic;
				clk_bps		: in std_logic;
				bps_start 	: out std_logic

	);
	end component;
	
	component my_uart_rx is
	port(
				clk		: in std_logic;
				rst_n		: in std_logic;
				rs232_rx	: in std_logic;
				clk_bps	: in std_logic;
				bps_start: out std_logic;
				rx_data	: out std_logic_vector(7 downto 0);
				rx_int 	: out std_logic
	);
	end component;
	
	component speed_select is
	port(
			clk 			: in std_logic;
			rst_n 		: in std_logic;
			bps_start 	: in std_logic;
			clk_bps 		: out std_logic
	);
	end component ;

	signal bps_start_rx,bps_start_tx : std_logic;	
	signal clk_bps_rx,clk_bps_tx: std_logic;		 
	
begin

	speed_rx	: speed_select
					port map (	
							clk => clock,	
							rst_n => nreset,
							bps_start => bps_start_rx,
							clk_bps => clk_bps_rx
						);
						
	speed_tx : speed_select
					port map (	
							clk => clock,	
							rst_n => nreset,
							bps_start => bps_start_tx,
							clk_bps => clk_bps_tx
						);


	receiver : my_uart_rx
					port map (		
							clk => clock,	
							rst_n => nreset,
							rs232_rx => rs232_rx,
							rx_data => receive_data,
							rx_int => receive,
							clk_bps => clk_bps_rx,
							bps_start => bps_start_rx
						);

	transmitter : my_uart_tx
					port map (		
							clk => clock,	
							rst_n => nreset,
							tx_data => send_data,
							tx_int => send,
							rs232_tx => rs232_tx,
							clk_bps => clk_bps_tx,
							bps_start => bps_start_tx
						);
						

end architecture;



