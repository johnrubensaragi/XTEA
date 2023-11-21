-- Copyright (C) 2023  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 22.1std.2 Build 922 07/20/2023 SC Lite Edition"

-- DATE "11/21/2023 13:46:10"

-- 
-- Device: Altera EP4CE6E22C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_101,	 I/O Standard: 2.5 V,	 Current Strength: 8mA


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	DummySerial IS
    PORT (
	clock : IN std_logic;
	nreset : IN std_logic;
	rs232_rx : IN std_logic;
	rs232_tx : OUT std_logic;
	keys : IN std_logic_vector(3 DOWNTO 0);
	switch : IN std_logic_vector(3 DOWNTO 0);
	leds : OUT std_logic_vector(3 DOWNTO 0)
	);
END DummySerial;

-- Design Ports Information
-- rs232_tx	=>  Location: PIN_114,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- keys[0]	=>  Location: PIN_88,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- keys[1]	=>  Location: PIN_89,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- keys[2]	=>  Location: PIN_90,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- switch[0]	=>  Location: PIN_74,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- switch[1]	=>  Location: PIN_143,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- switch[2]	=>  Location: PIN_68,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- switch[3]	=>  Location: PIN_77,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[0]	=>  Location: PIN_87,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[1]	=>  Location: PIN_86,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[2]	=>  Location: PIN_85,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[3]	=>  Location: PIN_84,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- keys[3]	=>  Location: PIN_91,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs232_rx	=>  Location: PIN_115,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- nreset	=>  Location: PIN_25,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF DummySerial IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_nreset : std_logic;
SIGNAL ww_rs232_rx : std_logic;
SIGNAL ww_rs232_tx : std_logic;
SIGNAL ww_keys : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_switch : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_leds : std_logic_vector(3 DOWNTO 0);
SIGNAL \serialblock_inst|clockdiv_inst|div_out~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \nreset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \Selector86~0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \keys[0]~input_o\ : std_logic;
SIGNAL \keys[1]~input_o\ : std_logic;
SIGNAL \keys[2]~input_o\ : std_logic;
SIGNAL \switch[0]~input_o\ : std_logic;
SIGNAL \switch[1]~input_o\ : std_logic;
SIGNAL \switch[2]~input_o\ : std_logic;
SIGNAL \switch[3]~input_o\ : std_logic;
SIGNAL \keys[3]~input_o\ : std_logic;
SIGNAL \rs232_rx~input_o\ : std_logic;
SIGNAL \rs232_tx~output_o\ : std_logic;
SIGNAL \leds[0]~output_o\ : std_logic;
SIGNAL \leds[1]~output_o\ : std_logic;
SIGNAL \leds[2]~output_o\ : std_logic;
SIGNAL \leds[3]~output_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~13_combout\ : std_logic;
SIGNAL \nreset~input_o\ : std_logic;
SIGNAL \nreset~inputclkctrl_outclk\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[0]~31_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~5_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[22]~76\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[23]~77_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[23]~78\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[24]~79_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[24]~80\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[25]~81_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[25]~82\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[26]~83_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[26]~84\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[27]~85_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[27]~86\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[28]~87_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[28]~88\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[29]~89_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[29]~90\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[30]~91_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~8_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~9_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~1_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~2_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~3_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~4_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~10_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[0]~32\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[1]~33_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[1]~34\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[2]~35_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[2]~36\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[3]~37_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[3]~38\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[4]~39_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[4]~40\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[5]~41_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[5]~42\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[6]~43_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[6]~44\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[7]~45_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[7]~46\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[8]~47_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[8]~48\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[9]~49_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[9]~50\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[10]~51_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[10]~52\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[11]~53_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[11]~54\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[12]~55_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[12]~56\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[13]~57_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[13]~58\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[14]~59_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[14]~60\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[15]~61_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[15]~62\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[16]~63_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[16]~64\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[17]~65_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[17]~66\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[18]~67_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[18]~68\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[19]~69_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[19]~70\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[20]~71_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[20]~72\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[21]~73_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[21]~74\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|count[22]~75_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~6_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|LessThan0~7_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|div_out~0_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|div_out~feeder_combout\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|div_out~q\ : std_logic;
SIGNAL \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|data_counter[0]~2_combout\ : std_logic;
SIGNAL \controller_nstate.sending_error_3386~combout\ : std_logic;
SIGNAL \controller_cstate.sending_error~q\ : std_logic;
SIGNAL \Selector86~0_combout\ : std_logic;
SIGNAL \Selector86~0clkctrl_outclk\ : std_logic;
SIGNAL \controller_nstate.reading_serial_3419~combout\ : std_logic;
SIGNAL \controller_cstate.reading_serial~feeder_combout\ : std_logic;
SIGNAL \controller_cstate.reading_serial~q\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \controller_nstate.idle_3452~combout\ : std_logic;
SIGNAL \controller_cstate.idle~0_combout\ : std_logic;
SIGNAL \controller_cstate.idle~q\ : std_logic;
SIGNAL \WideOr2~combout\ : std_logic;
SIGNAL \pulse10clock_int|counter[0]~3_combout\ : std_logic;
SIGNAL \pulse10clock_int|counter[2]~1_combout\ : std_logic;
SIGNAL \pulse10clock_int|counter[3]~0_combout\ : std_logic;
SIGNAL \pulse10clock_int|counter[1]~2_combout\ : std_logic;
SIGNAL \pulse10clock_int|LessThan0~0_combout\ : std_logic;
SIGNAL \pulse10clock_int|pulse_out~q\ : std_logic;
SIGNAL \send_start~combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|data_counter[1]~1_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|sender_done~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|data_counter[2]~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|sender_done~1_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|sender_done~q\ : std_logic;
SIGNAL \serialblock_inst|sender_start~0_combout\ : std_logic;
SIGNAL \serialblock_inst|sender_start~q\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|n_state~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|n_state~1_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|n_state~feeder_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|n_state~q\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|c_state~feeder_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|c_state~q\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulse_enable~feeder_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulse_enable~q\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~5_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[1]~4_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~1_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[2]~3_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~2_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~0_combout\ : std_logic;
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~feeder_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~feeder_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~21_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~25_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~27_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~29_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~35_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~36\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[12]~37_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~19_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|process_1~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[0]~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[1]~2_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[2]~3_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[3]~4_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_en~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt\ : std_logic_vector(12 DOWNTO 0);
SIGNAL \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \serialblock_inst|clockdiv_inst|count\ : std_logic_vector(30 DOWNTO 0);
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \serialblock_inst|serialsender_inst|data_counter\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \pulse10clock_int|counter\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|ALT_INV_rs232_tx_r~q\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_clock <= clock;
ww_nreset <= nreset;
ww_rs232_rx <= rs232_rx;
rs232_tx <= ww_rs232_tx;
ww_keys <= keys;
ww_switch <= switch;
leds <= ww_leds;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\serialblock_inst|clockdiv_inst|div_out~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \serialblock_inst|clockdiv_inst|div_out~q\);

\nreset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \nreset~input_o\);

\Selector86~0clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \Selector86~0_combout\);

\clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock~input_o\);
\serialblock_inst|my_uart_top_inst|transmitter|ALT_INV_rs232_tx_r~q\ <= NOT \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X28_Y24_N16
\rs232_tx~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \serialblock_inst|my_uart_top_inst|transmitter|ALT_INV_rs232_tx_r~q\,
	devoe => ww_devoe,
	o => \rs232_tx~output_o\);

-- Location: IOOBUF_X34_Y10_N9
\leds[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \leds[0]~output_o\);

-- Location: IOOBUF_X34_Y9_N2
\leds[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \leds[1]~output_o\);

-- Location: IOOBUF_X34_Y9_N9
\leds[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \leds[2]~output_o\);

-- Location: IOOBUF_X34_Y9_N16
\leds[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \leds[3]~output_o\);

-- Location: IOIBUF_X0_Y11_N8
\clock~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G2
\clock~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock~inputclkctrl_outclk\);

-- Location: LCCOMB_X16_Y20_N4
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~13_combout\ = \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0) $ (VCC)
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\ = CARRY(\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0),
	datad => VCC,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~13_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\);

-- Location: IOIBUF_X0_Y11_N22
\nreset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_nreset,
	o => \nreset~input_o\);

-- Location: CLKCTRL_G0
\nreset~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \nreset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \nreset~inputclkctrl_outclk\);

-- Location: LCCOMB_X30_Y23_N2
\serialblock_inst|clockdiv_inst|count[0]~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[0]~31_combout\ = \serialblock_inst|clockdiv_inst|count\(0) $ (VCC)
-- \serialblock_inst|clockdiv_inst|count[0]~32\ = CARRY(\serialblock_inst|clockdiv_inst|count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(0),
	datad => VCC,
	combout => \serialblock_inst|clockdiv_inst|count[0]~31_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[0]~32\);

-- Location: LCCOMB_X31_Y22_N18
\serialblock_inst|clockdiv_inst|LessThan0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~5_combout\ = (!\serialblock_inst|clockdiv_inst|count\(19) & (!\serialblock_inst|clockdiv_inst|count\(18) & (!\serialblock_inst|clockdiv_inst|count\(20) & !\serialblock_inst|clockdiv_inst|count\(17))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(19),
	datab => \serialblock_inst|clockdiv_inst|count\(18),
	datac => \serialblock_inst|clockdiv_inst|count\(20),
	datad => \serialblock_inst|clockdiv_inst|count\(17),
	combout => \serialblock_inst|clockdiv_inst|LessThan0~5_combout\);

-- Location: LCCOMB_X30_Y22_N14
\serialblock_inst|clockdiv_inst|count[22]~75\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[22]~75_combout\ = (\serialblock_inst|clockdiv_inst|count\(22) & (\serialblock_inst|clockdiv_inst|count[21]~74\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(22) & (!\serialblock_inst|clockdiv_inst|count[21]~74\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[22]~76\ = CARRY((\serialblock_inst|clockdiv_inst|count\(22) & !\serialblock_inst|clockdiv_inst|count[21]~74\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(22),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[21]~74\,
	combout => \serialblock_inst|clockdiv_inst|count[22]~75_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[22]~76\);

-- Location: LCCOMB_X30_Y22_N16
\serialblock_inst|clockdiv_inst|count[23]~77\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[23]~77_combout\ = (\serialblock_inst|clockdiv_inst|count\(23) & (!\serialblock_inst|clockdiv_inst|count[22]~76\)) # (!\serialblock_inst|clockdiv_inst|count\(23) & ((\serialblock_inst|clockdiv_inst|count[22]~76\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[23]~78\ = CARRY((!\serialblock_inst|clockdiv_inst|count[22]~76\) # (!\serialblock_inst|clockdiv_inst|count\(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(23),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[22]~76\,
	combout => \serialblock_inst|clockdiv_inst|count[23]~77_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[23]~78\);

-- Location: FF_X30_Y22_N17
\serialblock_inst|clockdiv_inst|count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[23]~77_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(23));

-- Location: LCCOMB_X30_Y22_N18
\serialblock_inst|clockdiv_inst|count[24]~79\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[24]~79_combout\ = (\serialblock_inst|clockdiv_inst|count\(24) & (\serialblock_inst|clockdiv_inst|count[23]~78\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(24) & (!\serialblock_inst|clockdiv_inst|count[23]~78\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[24]~80\ = CARRY((\serialblock_inst|clockdiv_inst|count\(24) & !\serialblock_inst|clockdiv_inst|count[23]~78\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(24),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[23]~78\,
	combout => \serialblock_inst|clockdiv_inst|count[24]~79_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[24]~80\);

-- Location: FF_X30_Y22_N19
\serialblock_inst|clockdiv_inst|count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[24]~79_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(24));

-- Location: LCCOMB_X30_Y22_N20
\serialblock_inst|clockdiv_inst|count[25]~81\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[25]~81_combout\ = (\serialblock_inst|clockdiv_inst|count\(25) & (!\serialblock_inst|clockdiv_inst|count[24]~80\)) # (!\serialblock_inst|clockdiv_inst|count\(25) & ((\serialblock_inst|clockdiv_inst|count[24]~80\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[25]~82\ = CARRY((!\serialblock_inst|clockdiv_inst|count[24]~80\) # (!\serialblock_inst|clockdiv_inst|count\(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(25),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[24]~80\,
	combout => \serialblock_inst|clockdiv_inst|count[25]~81_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[25]~82\);

-- Location: FF_X30_Y22_N21
\serialblock_inst|clockdiv_inst|count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[25]~81_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(25));

-- Location: LCCOMB_X30_Y22_N22
\serialblock_inst|clockdiv_inst|count[26]~83\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[26]~83_combout\ = (\serialblock_inst|clockdiv_inst|count\(26) & (\serialblock_inst|clockdiv_inst|count[25]~82\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(26) & (!\serialblock_inst|clockdiv_inst|count[25]~82\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[26]~84\ = CARRY((\serialblock_inst|clockdiv_inst|count\(26) & !\serialblock_inst|clockdiv_inst|count[25]~82\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(26),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[25]~82\,
	combout => \serialblock_inst|clockdiv_inst|count[26]~83_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[26]~84\);

-- Location: FF_X30_Y22_N23
\serialblock_inst|clockdiv_inst|count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[26]~83_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(26));

-- Location: LCCOMB_X30_Y22_N24
\serialblock_inst|clockdiv_inst|count[27]~85\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[27]~85_combout\ = (\serialblock_inst|clockdiv_inst|count\(27) & (!\serialblock_inst|clockdiv_inst|count[26]~84\)) # (!\serialblock_inst|clockdiv_inst|count\(27) & ((\serialblock_inst|clockdiv_inst|count[26]~84\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[27]~86\ = CARRY((!\serialblock_inst|clockdiv_inst|count[26]~84\) # (!\serialblock_inst|clockdiv_inst|count\(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(27),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[26]~84\,
	combout => \serialblock_inst|clockdiv_inst|count[27]~85_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[27]~86\);

-- Location: FF_X30_Y22_N25
\serialblock_inst|clockdiv_inst|count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[27]~85_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(27));

-- Location: LCCOMB_X30_Y22_N26
\serialblock_inst|clockdiv_inst|count[28]~87\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[28]~87_combout\ = (\serialblock_inst|clockdiv_inst|count\(28) & (\serialblock_inst|clockdiv_inst|count[27]~86\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(28) & (!\serialblock_inst|clockdiv_inst|count[27]~86\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[28]~88\ = CARRY((\serialblock_inst|clockdiv_inst|count\(28) & !\serialblock_inst|clockdiv_inst|count[27]~86\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(28),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[27]~86\,
	combout => \serialblock_inst|clockdiv_inst|count[28]~87_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[28]~88\);

-- Location: FF_X30_Y22_N27
\serialblock_inst|clockdiv_inst|count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[28]~87_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(28));

-- Location: LCCOMB_X30_Y22_N28
\serialblock_inst|clockdiv_inst|count[29]~89\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[29]~89_combout\ = (\serialblock_inst|clockdiv_inst|count\(29) & (!\serialblock_inst|clockdiv_inst|count[28]~88\)) # (!\serialblock_inst|clockdiv_inst|count\(29) & ((\serialblock_inst|clockdiv_inst|count[28]~88\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[29]~90\ = CARRY((!\serialblock_inst|clockdiv_inst|count[28]~88\) # (!\serialblock_inst|clockdiv_inst|count\(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(29),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[28]~88\,
	combout => \serialblock_inst|clockdiv_inst|count[29]~89_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[29]~90\);

-- Location: FF_X30_Y22_N29
\serialblock_inst|clockdiv_inst|count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[29]~89_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(29));

-- Location: LCCOMB_X30_Y22_N30
\serialblock_inst|clockdiv_inst|count[30]~91\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[30]~91_combout\ = \serialblock_inst|clockdiv_inst|count\(30) $ (!\serialblock_inst|clockdiv_inst|count[29]~90\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(30),
	cin => \serialblock_inst|clockdiv_inst|count[29]~90\,
	combout => \serialblock_inst|clockdiv_inst|count[30]~91_combout\);

-- Location: FF_X30_Y22_N31
\serialblock_inst|clockdiv_inst|count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[30]~91_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(30));

-- Location: LCCOMB_X31_Y22_N2
\serialblock_inst|clockdiv_inst|LessThan0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~8_combout\ = (!\serialblock_inst|clockdiv_inst|count\(28) & (!\serialblock_inst|clockdiv_inst|count\(25) & (!\serialblock_inst|clockdiv_inst|count\(27) & !\serialblock_inst|clockdiv_inst|count\(26))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(28),
	datab => \serialblock_inst|clockdiv_inst|count\(25),
	datac => \serialblock_inst|clockdiv_inst|count\(27),
	datad => \serialblock_inst|clockdiv_inst|count\(26),
	combout => \serialblock_inst|clockdiv_inst|LessThan0~8_combout\);

-- Location: LCCOMB_X31_Y22_N14
\serialblock_inst|clockdiv_inst|LessThan0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~9_combout\ = (!\serialblock_inst|clockdiv_inst|count\(30) & (!\serialblock_inst|clockdiv_inst|count\(29) & \serialblock_inst|clockdiv_inst|LessThan0~8_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(30),
	datac => \serialblock_inst|clockdiv_inst|count\(29),
	datad => \serialblock_inst|clockdiv_inst|LessThan0~8_combout\,
	combout => \serialblock_inst|clockdiv_inst|LessThan0~9_combout\);

-- Location: LCCOMB_X31_Y22_N30
\serialblock_inst|clockdiv_inst|LessThan0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~1_combout\ = ((!\serialblock_inst|clockdiv_inst|count\(11) & !\serialblock_inst|clockdiv_inst|count\(10))) # (!\serialblock_inst|clockdiv_inst|count\(12))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(11),
	datab => \serialblock_inst|clockdiv_inst|count\(10),
	datad => \serialblock_inst|clockdiv_inst|count\(12),
	combout => \serialblock_inst|clockdiv_inst|LessThan0~1_combout\);

-- Location: LCCOMB_X31_Y22_N4
\serialblock_inst|clockdiv_inst|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~0_combout\ = (!\serialblock_inst|clockdiv_inst|count\(15) & (!\serialblock_inst|clockdiv_inst|count\(16) & (!\serialblock_inst|clockdiv_inst|count\(13) & !\serialblock_inst|clockdiv_inst|count\(14))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(15),
	datab => \serialblock_inst|clockdiv_inst|count\(16),
	datac => \serialblock_inst|clockdiv_inst|count\(13),
	datad => \serialblock_inst|clockdiv_inst|count\(14),
	combout => \serialblock_inst|clockdiv_inst|LessThan0~0_combout\);

-- Location: LCCOMB_X30_Y23_N0
\serialblock_inst|clockdiv_inst|LessThan0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~2_combout\ = ((!\serialblock_inst|clockdiv_inst|count\(5) & ((!\serialblock_inst|clockdiv_inst|count\(3)) # (!\serialblock_inst|clockdiv_inst|count\(4))))) # (!\serialblock_inst|clockdiv_inst|count\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(4),
	datab => \serialblock_inst|clockdiv_inst|count\(3),
	datac => \serialblock_inst|clockdiv_inst|count\(6),
	datad => \serialblock_inst|clockdiv_inst|count\(5),
	combout => \serialblock_inst|clockdiv_inst|LessThan0~2_combout\);

-- Location: LCCOMB_X31_Y22_N28
\serialblock_inst|clockdiv_inst|LessThan0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~3_combout\ = (!\serialblock_inst|clockdiv_inst|count\(8) & (!\serialblock_inst|clockdiv_inst|count\(7) & (!\serialblock_inst|clockdiv_inst|count\(11) & !\serialblock_inst|clockdiv_inst|count\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(8),
	datab => \serialblock_inst|clockdiv_inst|count\(7),
	datac => \serialblock_inst|clockdiv_inst|count\(11),
	datad => \serialblock_inst|clockdiv_inst|count\(9),
	combout => \serialblock_inst|clockdiv_inst|LessThan0~3_combout\);

-- Location: LCCOMB_X31_Y22_N16
\serialblock_inst|clockdiv_inst|LessThan0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~4_combout\ = (\serialblock_inst|clockdiv_inst|LessThan0~0_combout\ & ((\serialblock_inst|clockdiv_inst|LessThan0~1_combout\) # ((\serialblock_inst|clockdiv_inst|LessThan0~2_combout\ & 
-- \serialblock_inst|clockdiv_inst|LessThan0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|LessThan0~1_combout\,
	datab => \serialblock_inst|clockdiv_inst|LessThan0~0_combout\,
	datac => \serialblock_inst|clockdiv_inst|LessThan0~2_combout\,
	datad => \serialblock_inst|clockdiv_inst|LessThan0~3_combout\,
	combout => \serialblock_inst|clockdiv_inst|LessThan0~4_combout\);

-- Location: LCCOMB_X31_Y22_N12
\serialblock_inst|clockdiv_inst|LessThan0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~10_combout\ = (((!\serialblock_inst|clockdiv_inst|LessThan0~4_combout\) # (!\serialblock_inst|clockdiv_inst|LessThan0~9_combout\)) # (!\serialblock_inst|clockdiv_inst|LessThan0~5_combout\)) # 
-- (!\serialblock_inst|clockdiv_inst|LessThan0~6_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|LessThan0~6_combout\,
	datab => \serialblock_inst|clockdiv_inst|LessThan0~5_combout\,
	datac => \serialblock_inst|clockdiv_inst|LessThan0~9_combout\,
	datad => \serialblock_inst|clockdiv_inst|LessThan0~4_combout\,
	combout => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\);

-- Location: FF_X30_Y23_N3
\serialblock_inst|clockdiv_inst|count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[0]~31_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(0));

-- Location: LCCOMB_X30_Y23_N4
\serialblock_inst|clockdiv_inst|count[1]~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[1]~33_combout\ = (\serialblock_inst|clockdiv_inst|count\(1) & (!\serialblock_inst|clockdiv_inst|count[0]~32\)) # (!\serialblock_inst|clockdiv_inst|count\(1) & ((\serialblock_inst|clockdiv_inst|count[0]~32\) # (GND)))
-- \serialblock_inst|clockdiv_inst|count[1]~34\ = CARRY((!\serialblock_inst|clockdiv_inst|count[0]~32\) # (!\serialblock_inst|clockdiv_inst|count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(1),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[0]~32\,
	combout => \serialblock_inst|clockdiv_inst|count[1]~33_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[1]~34\);

-- Location: FF_X30_Y23_N5
\serialblock_inst|clockdiv_inst|count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[1]~33_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(1));

-- Location: LCCOMB_X30_Y23_N6
\serialblock_inst|clockdiv_inst|count[2]~35\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[2]~35_combout\ = (\serialblock_inst|clockdiv_inst|count\(2) & (\serialblock_inst|clockdiv_inst|count[1]~34\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(2) & (!\serialblock_inst|clockdiv_inst|count[1]~34\ & 
-- VCC))
-- \serialblock_inst|clockdiv_inst|count[2]~36\ = CARRY((\serialblock_inst|clockdiv_inst|count\(2) & !\serialblock_inst|clockdiv_inst|count[1]~34\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(2),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[1]~34\,
	combout => \serialblock_inst|clockdiv_inst|count[2]~35_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[2]~36\);

-- Location: FF_X30_Y23_N7
\serialblock_inst|clockdiv_inst|count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[2]~35_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(2));

-- Location: LCCOMB_X30_Y23_N8
\serialblock_inst|clockdiv_inst|count[3]~37\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[3]~37_combout\ = (\serialblock_inst|clockdiv_inst|count\(3) & (!\serialblock_inst|clockdiv_inst|count[2]~36\)) # (!\serialblock_inst|clockdiv_inst|count\(3) & ((\serialblock_inst|clockdiv_inst|count[2]~36\) # (GND)))
-- \serialblock_inst|clockdiv_inst|count[3]~38\ = CARRY((!\serialblock_inst|clockdiv_inst|count[2]~36\) # (!\serialblock_inst|clockdiv_inst|count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(3),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[2]~36\,
	combout => \serialblock_inst|clockdiv_inst|count[3]~37_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[3]~38\);

-- Location: FF_X30_Y23_N9
\serialblock_inst|clockdiv_inst|count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[3]~37_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(3));

-- Location: LCCOMB_X30_Y23_N10
\serialblock_inst|clockdiv_inst|count[4]~39\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[4]~39_combout\ = (\serialblock_inst|clockdiv_inst|count\(4) & (\serialblock_inst|clockdiv_inst|count[3]~38\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(4) & (!\serialblock_inst|clockdiv_inst|count[3]~38\ & 
-- VCC))
-- \serialblock_inst|clockdiv_inst|count[4]~40\ = CARRY((\serialblock_inst|clockdiv_inst|count\(4) & !\serialblock_inst|clockdiv_inst|count[3]~38\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(4),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[3]~38\,
	combout => \serialblock_inst|clockdiv_inst|count[4]~39_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[4]~40\);

-- Location: FF_X30_Y23_N11
\serialblock_inst|clockdiv_inst|count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[4]~39_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(4));

-- Location: LCCOMB_X30_Y23_N12
\serialblock_inst|clockdiv_inst|count[5]~41\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[5]~41_combout\ = (\serialblock_inst|clockdiv_inst|count\(5) & (!\serialblock_inst|clockdiv_inst|count[4]~40\)) # (!\serialblock_inst|clockdiv_inst|count\(5) & ((\serialblock_inst|clockdiv_inst|count[4]~40\) # (GND)))
-- \serialblock_inst|clockdiv_inst|count[5]~42\ = CARRY((!\serialblock_inst|clockdiv_inst|count[4]~40\) # (!\serialblock_inst|clockdiv_inst|count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(5),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[4]~40\,
	combout => \serialblock_inst|clockdiv_inst|count[5]~41_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[5]~42\);

-- Location: FF_X30_Y23_N13
\serialblock_inst|clockdiv_inst|count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[5]~41_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(5));

-- Location: LCCOMB_X30_Y23_N14
\serialblock_inst|clockdiv_inst|count[6]~43\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[6]~43_combout\ = (\serialblock_inst|clockdiv_inst|count\(6) & (\serialblock_inst|clockdiv_inst|count[5]~42\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(6) & (!\serialblock_inst|clockdiv_inst|count[5]~42\ & 
-- VCC))
-- \serialblock_inst|clockdiv_inst|count[6]~44\ = CARRY((\serialblock_inst|clockdiv_inst|count\(6) & !\serialblock_inst|clockdiv_inst|count[5]~42\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(6),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[5]~42\,
	combout => \serialblock_inst|clockdiv_inst|count[6]~43_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[6]~44\);

-- Location: FF_X30_Y23_N15
\serialblock_inst|clockdiv_inst|count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[6]~43_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(6));

-- Location: LCCOMB_X30_Y23_N16
\serialblock_inst|clockdiv_inst|count[7]~45\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[7]~45_combout\ = (\serialblock_inst|clockdiv_inst|count\(7) & (!\serialblock_inst|clockdiv_inst|count[6]~44\)) # (!\serialblock_inst|clockdiv_inst|count\(7) & ((\serialblock_inst|clockdiv_inst|count[6]~44\) # (GND)))
-- \serialblock_inst|clockdiv_inst|count[7]~46\ = CARRY((!\serialblock_inst|clockdiv_inst|count[6]~44\) # (!\serialblock_inst|clockdiv_inst|count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(7),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[6]~44\,
	combout => \serialblock_inst|clockdiv_inst|count[7]~45_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[7]~46\);

-- Location: FF_X30_Y23_N17
\serialblock_inst|clockdiv_inst|count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[7]~45_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(7));

-- Location: LCCOMB_X30_Y23_N18
\serialblock_inst|clockdiv_inst|count[8]~47\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[8]~47_combout\ = (\serialblock_inst|clockdiv_inst|count\(8) & (\serialblock_inst|clockdiv_inst|count[7]~46\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(8) & (!\serialblock_inst|clockdiv_inst|count[7]~46\ & 
-- VCC))
-- \serialblock_inst|clockdiv_inst|count[8]~48\ = CARRY((\serialblock_inst|clockdiv_inst|count\(8) & !\serialblock_inst|clockdiv_inst|count[7]~46\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(8),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[7]~46\,
	combout => \serialblock_inst|clockdiv_inst|count[8]~47_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[8]~48\);

-- Location: FF_X30_Y23_N19
\serialblock_inst|clockdiv_inst|count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[8]~47_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(8));

-- Location: LCCOMB_X30_Y23_N20
\serialblock_inst|clockdiv_inst|count[9]~49\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[9]~49_combout\ = (\serialblock_inst|clockdiv_inst|count\(9) & (!\serialblock_inst|clockdiv_inst|count[8]~48\)) # (!\serialblock_inst|clockdiv_inst|count\(9) & ((\serialblock_inst|clockdiv_inst|count[8]~48\) # (GND)))
-- \serialblock_inst|clockdiv_inst|count[9]~50\ = CARRY((!\serialblock_inst|clockdiv_inst|count[8]~48\) # (!\serialblock_inst|clockdiv_inst|count\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(9),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[8]~48\,
	combout => \serialblock_inst|clockdiv_inst|count[9]~49_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[9]~50\);

-- Location: FF_X30_Y23_N21
\serialblock_inst|clockdiv_inst|count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[9]~49_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(9));

-- Location: LCCOMB_X30_Y23_N22
\serialblock_inst|clockdiv_inst|count[10]~51\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[10]~51_combout\ = (\serialblock_inst|clockdiv_inst|count\(10) & (\serialblock_inst|clockdiv_inst|count[9]~50\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(10) & (!\serialblock_inst|clockdiv_inst|count[9]~50\ & 
-- VCC))
-- \serialblock_inst|clockdiv_inst|count[10]~52\ = CARRY((\serialblock_inst|clockdiv_inst|count\(10) & !\serialblock_inst|clockdiv_inst|count[9]~50\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(10),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[9]~50\,
	combout => \serialblock_inst|clockdiv_inst|count[10]~51_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[10]~52\);

-- Location: FF_X30_Y23_N23
\serialblock_inst|clockdiv_inst|count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[10]~51_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(10));

-- Location: LCCOMB_X30_Y23_N24
\serialblock_inst|clockdiv_inst|count[11]~53\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[11]~53_combout\ = (\serialblock_inst|clockdiv_inst|count\(11) & (!\serialblock_inst|clockdiv_inst|count[10]~52\)) # (!\serialblock_inst|clockdiv_inst|count\(11) & ((\serialblock_inst|clockdiv_inst|count[10]~52\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[11]~54\ = CARRY((!\serialblock_inst|clockdiv_inst|count[10]~52\) # (!\serialblock_inst|clockdiv_inst|count\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(11),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[10]~52\,
	combout => \serialblock_inst|clockdiv_inst|count[11]~53_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[11]~54\);

-- Location: FF_X30_Y23_N25
\serialblock_inst|clockdiv_inst|count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[11]~53_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(11));

-- Location: LCCOMB_X30_Y23_N26
\serialblock_inst|clockdiv_inst|count[12]~55\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[12]~55_combout\ = (\serialblock_inst|clockdiv_inst|count\(12) & (\serialblock_inst|clockdiv_inst|count[11]~54\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(12) & (!\serialblock_inst|clockdiv_inst|count[11]~54\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[12]~56\ = CARRY((\serialblock_inst|clockdiv_inst|count\(12) & !\serialblock_inst|clockdiv_inst|count[11]~54\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(12),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[11]~54\,
	combout => \serialblock_inst|clockdiv_inst|count[12]~55_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[12]~56\);

-- Location: FF_X30_Y23_N27
\serialblock_inst|clockdiv_inst|count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[12]~55_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(12));

-- Location: LCCOMB_X30_Y23_N28
\serialblock_inst|clockdiv_inst|count[13]~57\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[13]~57_combout\ = (\serialblock_inst|clockdiv_inst|count\(13) & (!\serialblock_inst|clockdiv_inst|count[12]~56\)) # (!\serialblock_inst|clockdiv_inst|count\(13) & ((\serialblock_inst|clockdiv_inst|count[12]~56\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[13]~58\ = CARRY((!\serialblock_inst|clockdiv_inst|count[12]~56\) # (!\serialblock_inst|clockdiv_inst|count\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(13),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[12]~56\,
	combout => \serialblock_inst|clockdiv_inst|count[13]~57_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[13]~58\);

-- Location: FF_X30_Y23_N29
\serialblock_inst|clockdiv_inst|count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[13]~57_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(13));

-- Location: LCCOMB_X30_Y23_N30
\serialblock_inst|clockdiv_inst|count[14]~59\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[14]~59_combout\ = (\serialblock_inst|clockdiv_inst|count\(14) & (\serialblock_inst|clockdiv_inst|count[13]~58\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(14) & (!\serialblock_inst|clockdiv_inst|count[13]~58\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[14]~60\ = CARRY((\serialblock_inst|clockdiv_inst|count\(14) & !\serialblock_inst|clockdiv_inst|count[13]~58\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(14),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[13]~58\,
	combout => \serialblock_inst|clockdiv_inst|count[14]~59_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[14]~60\);

-- Location: FF_X30_Y23_N31
\serialblock_inst|clockdiv_inst|count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[14]~59_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(14));

-- Location: LCCOMB_X30_Y22_N0
\serialblock_inst|clockdiv_inst|count[15]~61\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[15]~61_combout\ = (\serialblock_inst|clockdiv_inst|count\(15) & (!\serialblock_inst|clockdiv_inst|count[14]~60\)) # (!\serialblock_inst|clockdiv_inst|count\(15) & ((\serialblock_inst|clockdiv_inst|count[14]~60\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[15]~62\ = CARRY((!\serialblock_inst|clockdiv_inst|count[14]~60\) # (!\serialblock_inst|clockdiv_inst|count\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(15),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[14]~60\,
	combout => \serialblock_inst|clockdiv_inst|count[15]~61_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[15]~62\);

-- Location: FF_X30_Y22_N1
\serialblock_inst|clockdiv_inst|count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[15]~61_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(15));

-- Location: LCCOMB_X30_Y22_N2
\serialblock_inst|clockdiv_inst|count[16]~63\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[16]~63_combout\ = (\serialblock_inst|clockdiv_inst|count\(16) & (\serialblock_inst|clockdiv_inst|count[15]~62\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(16) & (!\serialblock_inst|clockdiv_inst|count[15]~62\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[16]~64\ = CARRY((\serialblock_inst|clockdiv_inst|count\(16) & !\serialblock_inst|clockdiv_inst|count[15]~62\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(16),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[15]~62\,
	combout => \serialblock_inst|clockdiv_inst|count[16]~63_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[16]~64\);

-- Location: FF_X30_Y22_N3
\serialblock_inst|clockdiv_inst|count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[16]~63_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(16));

-- Location: LCCOMB_X30_Y22_N4
\serialblock_inst|clockdiv_inst|count[17]~65\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[17]~65_combout\ = (\serialblock_inst|clockdiv_inst|count\(17) & (!\serialblock_inst|clockdiv_inst|count[16]~64\)) # (!\serialblock_inst|clockdiv_inst|count\(17) & ((\serialblock_inst|clockdiv_inst|count[16]~64\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[17]~66\ = CARRY((!\serialblock_inst|clockdiv_inst|count[16]~64\) # (!\serialblock_inst|clockdiv_inst|count\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(17),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[16]~64\,
	combout => \serialblock_inst|clockdiv_inst|count[17]~65_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[17]~66\);

-- Location: FF_X30_Y22_N5
\serialblock_inst|clockdiv_inst|count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[17]~65_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(17));

-- Location: LCCOMB_X30_Y22_N6
\serialblock_inst|clockdiv_inst|count[18]~67\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[18]~67_combout\ = (\serialblock_inst|clockdiv_inst|count\(18) & (\serialblock_inst|clockdiv_inst|count[17]~66\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(18) & (!\serialblock_inst|clockdiv_inst|count[17]~66\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[18]~68\ = CARRY((\serialblock_inst|clockdiv_inst|count\(18) & !\serialblock_inst|clockdiv_inst|count[17]~66\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(18),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[17]~66\,
	combout => \serialblock_inst|clockdiv_inst|count[18]~67_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[18]~68\);

-- Location: FF_X30_Y22_N7
\serialblock_inst|clockdiv_inst|count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[18]~67_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(18));

-- Location: LCCOMB_X30_Y22_N8
\serialblock_inst|clockdiv_inst|count[19]~69\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[19]~69_combout\ = (\serialblock_inst|clockdiv_inst|count\(19) & (!\serialblock_inst|clockdiv_inst|count[18]~68\)) # (!\serialblock_inst|clockdiv_inst|count\(19) & ((\serialblock_inst|clockdiv_inst|count[18]~68\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[19]~70\ = CARRY((!\serialblock_inst|clockdiv_inst|count[18]~68\) # (!\serialblock_inst|clockdiv_inst|count\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|count\(19),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[18]~68\,
	combout => \serialblock_inst|clockdiv_inst|count[19]~69_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[19]~70\);

-- Location: FF_X30_Y22_N9
\serialblock_inst|clockdiv_inst|count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[19]~69_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(19));

-- Location: LCCOMB_X30_Y22_N10
\serialblock_inst|clockdiv_inst|count[20]~71\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[20]~71_combout\ = (\serialblock_inst|clockdiv_inst|count\(20) & (\serialblock_inst|clockdiv_inst|count[19]~70\ $ (GND))) # (!\serialblock_inst|clockdiv_inst|count\(20) & (!\serialblock_inst|clockdiv_inst|count[19]~70\ 
-- & VCC))
-- \serialblock_inst|clockdiv_inst|count[20]~72\ = CARRY((\serialblock_inst|clockdiv_inst|count\(20) & !\serialblock_inst|clockdiv_inst|count[19]~70\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(20),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[19]~70\,
	combout => \serialblock_inst|clockdiv_inst|count[20]~71_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[20]~72\);

-- Location: FF_X30_Y22_N11
\serialblock_inst|clockdiv_inst|count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[20]~71_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(20));

-- Location: LCCOMB_X30_Y22_N12
\serialblock_inst|clockdiv_inst|count[21]~73\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|count[21]~73_combout\ = (\serialblock_inst|clockdiv_inst|count\(21) & (!\serialblock_inst|clockdiv_inst|count[20]~72\)) # (!\serialblock_inst|clockdiv_inst|count\(21) & ((\serialblock_inst|clockdiv_inst|count[20]~72\) # 
-- (GND)))
-- \serialblock_inst|clockdiv_inst|count[21]~74\ = CARRY((!\serialblock_inst|clockdiv_inst|count[20]~72\) # (!\serialblock_inst|clockdiv_inst|count\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(21),
	datad => VCC,
	cin => \serialblock_inst|clockdiv_inst|count[20]~72\,
	combout => \serialblock_inst|clockdiv_inst|count[21]~73_combout\,
	cout => \serialblock_inst|clockdiv_inst|count[21]~74\);

-- Location: FF_X30_Y22_N13
\serialblock_inst|clockdiv_inst|count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[21]~73_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(21));

-- Location: FF_X30_Y22_N15
\serialblock_inst|clockdiv_inst|count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|count[22]~75_combout\,
	sclr => \serialblock_inst|clockdiv_inst|LessThan0~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|count\(22));

-- Location: LCCOMB_X31_Y22_N26
\serialblock_inst|clockdiv_inst|LessThan0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~6_combout\ = (!\serialblock_inst|clockdiv_inst|count\(22) & (!\serialblock_inst|clockdiv_inst|count\(24) & (!\serialblock_inst|clockdiv_inst|count\(23) & !\serialblock_inst|clockdiv_inst|count\(21))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|count\(22),
	datab => \serialblock_inst|clockdiv_inst|count\(24),
	datac => \serialblock_inst|clockdiv_inst|count\(23),
	datad => \serialblock_inst|clockdiv_inst|count\(21),
	combout => \serialblock_inst|clockdiv_inst|LessThan0~6_combout\);

-- Location: LCCOMB_X31_Y22_N22
\serialblock_inst|clockdiv_inst|LessThan0~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|LessThan0~7_combout\ = (\serialblock_inst|clockdiv_inst|LessThan0~6_combout\ & \serialblock_inst|clockdiv_inst|LessThan0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \serialblock_inst|clockdiv_inst|LessThan0~6_combout\,
	datad => \serialblock_inst|clockdiv_inst|LessThan0~5_combout\,
	combout => \serialblock_inst|clockdiv_inst|LessThan0~7_combout\);

-- Location: LCCOMB_X31_Y22_N24
\serialblock_inst|clockdiv_inst|div_out~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|div_out~0_combout\ = \serialblock_inst|clockdiv_inst|div_out~q\ $ ((((!\serialblock_inst|clockdiv_inst|LessThan0~4_combout\) # (!\serialblock_inst|clockdiv_inst|LessThan0~9_combout\)) # 
-- (!\serialblock_inst|clockdiv_inst|LessThan0~7_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000011100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|clockdiv_inst|LessThan0~7_combout\,
	datab => \serialblock_inst|clockdiv_inst|LessThan0~9_combout\,
	datac => \serialblock_inst|clockdiv_inst|div_out~q\,
	datad => \serialblock_inst|clockdiv_inst|LessThan0~4_combout\,
	combout => \serialblock_inst|clockdiv_inst|div_out~0_combout\);

-- Location: LCCOMB_X31_Y22_N20
\serialblock_inst|clockdiv_inst|div_out~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|clockdiv_inst|div_out~feeder_combout\ = \serialblock_inst|clockdiv_inst|div_out~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|clockdiv_inst|div_out~0_combout\,
	combout => \serialblock_inst|clockdiv_inst|div_out~feeder_combout\);

-- Location: FF_X31_Y22_N21
\serialblock_inst|clockdiv_inst|div_out\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|clockdiv_inst|div_out~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|clockdiv_inst|div_out~q\);

-- Location: CLKCTRL_G9
\serialblock_inst|clockdiv_inst|div_out~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\);

-- Location: LCCOMB_X5_Y9_N4
\serialblock_inst|serialsender_inst|data_counter[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|data_counter[0]~2_combout\ = !\serialblock_inst|serialsender_inst|data_counter\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \serialblock_inst|serialsender_inst|data_counter\(0),
	combout => \serialblock_inst|serialsender_inst|data_counter[0]~2_combout\);

-- Location: LCCOMB_X1_Y11_N6
\controller_nstate.sending_error_3386\ : cycloneive_lcell_comb
-- Equation(s):
-- \controller_nstate.sending_error_3386~combout\ = (GLOBAL(\Selector86~0clkctrl_outclk\) & (\controller_cstate.reading_serial~q\)) # (!GLOBAL(\Selector86~0clkctrl_outclk\) & ((\controller_nstate.sending_error_3386~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller_cstate.reading_serial~q\,
	datac => \controller_nstate.sending_error_3386~combout\,
	datad => \Selector86~0clkctrl_outclk\,
	combout => \controller_nstate.sending_error_3386~combout\);

-- Location: FF_X1_Y11_N7
\controller_cstate.sending_error\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \controller_nstate.sending_error_3386~combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller_cstate.sending_error~q\);

-- Location: LCCOMB_X1_Y11_N8
\Selector86~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector86~0_combout\ = (\controller_cstate.reading_serial~q\) # ((!\controller_cstate.sending_error~q\ & \controller_cstate.idle~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller_cstate.sending_error~q\,
	datac => \controller_cstate.idle~q\,
	datad => \controller_cstate.reading_serial~q\,
	combout => \Selector86~0_combout\);

-- Location: CLKCTRL_G1
\Selector86~0clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Selector86~0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Selector86~0clkctrl_outclk\);

-- Location: LCCOMB_X1_Y11_N24
\controller_nstate.reading_serial_3419\ : cycloneive_lcell_comb
-- Equation(s):
-- \controller_nstate.reading_serial_3419~combout\ = (GLOBAL(\Selector86~0clkctrl_outclk\) & ((!\controller_cstate.idle~q\))) # (!GLOBAL(\Selector86~0clkctrl_outclk\) & (\controller_nstate.reading_serial_3419~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller_nstate.reading_serial_3419~combout\,
	datac => \controller_cstate.idle~q\,
	datad => \Selector86~0clkctrl_outclk\,
	combout => \controller_nstate.reading_serial_3419~combout\);

-- Location: LCCOMB_X1_Y11_N26
\controller_cstate.reading_serial~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \controller_cstate.reading_serial~feeder_combout\ = \controller_nstate.reading_serial_3419~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \controller_nstate.reading_serial_3419~combout\,
	combout => \controller_cstate.reading_serial~feeder_combout\);

-- Location: FF_X1_Y11_N27
\controller_cstate.reading_serial\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~input_o\,
	d => \controller_cstate.reading_serial~feeder_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller_cstate.reading_serial~q\);

-- Location: LCCOMB_X1_Y11_N14
\Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = (\controller_cstate.sending_error~q\) # ((\controller_cstate.idle~q\ & !\controller_cstate.reading_serial~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller_cstate.idle~q\,
	datac => \controller_cstate.reading_serial~q\,
	datad => \controller_cstate.sending_error~q\,
	combout => \Selector6~0_combout\);

-- Location: LCCOMB_X1_Y11_N28
\controller_nstate.idle_3452\ : cycloneive_lcell_comb
-- Equation(s):
-- \controller_nstate.idle_3452~combout\ = (GLOBAL(\Selector86~0clkctrl_outclk\) & ((\Selector6~0_combout\))) # (!GLOBAL(\Selector86~0clkctrl_outclk\) & (\controller_nstate.idle_3452~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller_nstate.idle_3452~combout\,
	datac => \Selector6~0_combout\,
	datad => \Selector86~0clkctrl_outclk\,
	combout => \controller_nstate.idle_3452~combout\);

-- Location: LCCOMB_X1_Y11_N30
\controller_cstate.idle~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \controller_cstate.idle~0_combout\ = !\controller_nstate.idle_3452~combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \controller_nstate.idle_3452~combout\,
	combout => \controller_cstate.idle~0_combout\);

-- Location: FF_X1_Y11_N31
\controller_cstate.idle\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \controller_cstate.idle~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller_cstate.idle~q\);

-- Location: LCCOMB_X1_Y11_N12
WideOr2 : cycloneive_lcell_comb
-- Equation(s):
-- \WideOr2~combout\ = ((\controller_cstate.reading_serial~q\) # (!\controller_cstate.sending_error~q\)) # (!\controller_cstate.idle~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller_cstate.idle~q\,
	datac => \controller_cstate.reading_serial~q\,
	datad => \controller_cstate.sending_error~q\,
	combout => \WideOr2~combout\);

-- Location: LCCOMB_X1_Y11_N18
\pulse10clock_int|counter[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \pulse10clock_int|counter[0]~3_combout\ = \pulse10clock_int|counter\(0) $ ((((!\pulse10clock_int|counter\(1) & !\pulse10clock_int|counter\(2))) # (!\pulse10clock_int|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pulse10clock_int|counter\(1),
	datab => \pulse10clock_int|counter\(2),
	datac => \pulse10clock_int|counter\(0),
	datad => \pulse10clock_int|counter\(3),
	combout => \pulse10clock_int|counter[0]~3_combout\);

-- Location: FF_X1_Y11_N19
\pulse10clock_int|counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \pulse10clock_int|counter[0]~3_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pulse10clock_int|counter\(0));

-- Location: LCCOMB_X1_Y11_N10
\pulse10clock_int|counter[2]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \pulse10clock_int|counter[2]~1_combout\ = \pulse10clock_int|counter\(2) $ (((\pulse10clock_int|counter\(1) & (!\pulse10clock_int|counter\(3) & \pulse10clock_int|counter\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pulse10clock_int|counter\(1),
	datab => \pulse10clock_int|counter\(3),
	datac => \pulse10clock_int|counter\(2),
	datad => \pulse10clock_int|counter\(0),
	combout => \pulse10clock_int|counter[2]~1_combout\);

-- Location: FF_X1_Y11_N11
\pulse10clock_int|counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \pulse10clock_int|counter[2]~1_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pulse10clock_int|counter\(2));

-- Location: LCCOMB_X1_Y11_N20
\pulse10clock_int|counter[3]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \pulse10clock_int|counter[3]~0_combout\ = (\pulse10clock_int|counter\(3)) # ((\pulse10clock_int|counter\(1) & (\pulse10clock_int|counter\(2) & \pulse10clock_int|counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pulse10clock_int|counter\(1),
	datab => \pulse10clock_int|counter\(2),
	datac => \pulse10clock_int|counter\(3),
	datad => \pulse10clock_int|counter\(0),
	combout => \pulse10clock_int|counter[3]~0_combout\);

-- Location: FF_X1_Y11_N21
\pulse10clock_int|counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \pulse10clock_int|counter[3]~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pulse10clock_int|counter\(3));

-- Location: LCCOMB_X1_Y11_N22
\pulse10clock_int|counter[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \pulse10clock_int|counter[1]~2_combout\ = (\pulse10clock_int|counter\(3) & ((\pulse10clock_int|counter\(1)) # ((!\pulse10clock_int|counter\(2) & \pulse10clock_int|counter\(0))))) # (!\pulse10clock_int|counter\(3) & ((\pulse10clock_int|counter\(1) $ 
-- (\pulse10clock_int|counter\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010011111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pulse10clock_int|counter\(3),
	datab => \pulse10clock_int|counter\(2),
	datac => \pulse10clock_int|counter\(1),
	datad => \pulse10clock_int|counter\(0),
	combout => \pulse10clock_int|counter[1]~2_combout\);

-- Location: FF_X1_Y11_N23
\pulse10clock_int|counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \pulse10clock_int|counter[1]~2_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pulse10clock_int|counter\(1));

-- Location: LCCOMB_X1_Y11_N16
\pulse10clock_int|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \pulse10clock_int|LessThan0~0_combout\ = ((!\pulse10clock_int|counter\(1) & !\pulse10clock_int|counter\(2))) # (!\pulse10clock_int|counter\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001101110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \pulse10clock_int|counter\(1),
	datab => \pulse10clock_int|counter\(3),
	datad => \pulse10clock_int|counter\(2),
	combout => \pulse10clock_int|LessThan0~0_combout\);

-- Location: FF_X1_Y11_N17
\pulse10clock_int|pulse_out\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \pulse10clock_int|LessThan0~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pulse10clock_int|pulse_out~q\);

-- Location: LCCOMB_X1_Y11_N4
send_start : cycloneive_lcell_comb
-- Equation(s):
-- \send_start~combout\ = (\WideOr2~combout\ & (\send_start~combout\)) # (!\WideOr2~combout\ & ((\pulse10clock_int|pulse_out~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \WideOr2~combout\,
	datac => \send_start~combout\,
	datad => \pulse10clock_int|pulse_out~q\,
	combout => \send_start~combout\);

-- Location: LCCOMB_X4_Y9_N30
\serialblock_inst|serialsender_inst|data_counter[1]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|data_counter[1]~1_combout\ = \serialblock_inst|serialsender_inst|data_counter\(1) $ (((\serialblock_inst|serialsender_inst|c_state~q\ & \serialblock_inst|serialsender_inst|data_counter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|serialsender_inst|c_state~q\,
	datac => \serialblock_inst|serialsender_inst|data_counter\(1),
	datad => \serialblock_inst|serialsender_inst|data_counter\(0),
	combout => \serialblock_inst|serialsender_inst|data_counter[1]~1_combout\);

-- Location: FF_X4_Y9_N31
\serialblock_inst|serialsender_inst|data_counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|data_counter[1]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|data_counter\(1));

-- Location: LCCOMB_X4_Y9_N24
\serialblock_inst|serialsender_inst|sender_done~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|sender_done~0_combout\ = (\serialblock_inst|serialsender_inst|c_state~q\ & ((\serialblock_inst|serialsender_inst|data_counter\(1)) # (\serialblock_inst|serialsender_inst|sender_done~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|data_counter\(1),
	datac => \serialblock_inst|serialsender_inst|c_state~q\,
	datad => \serialblock_inst|serialsender_inst|sender_done~q\,
	combout => \serialblock_inst|serialsender_inst|sender_done~0_combout\);

-- Location: LCCOMB_X4_Y9_N28
\serialblock_inst|serialsender_inst|data_counter[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|data_counter[2]~0_combout\ = \serialblock_inst|serialsender_inst|data_counter\(2) $ (((\serialblock_inst|serialsender_inst|data_counter\(1) & (\serialblock_inst|serialsender_inst|data_counter\(0) & 
-- \serialblock_inst|serialsender_inst|c_state~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|data_counter\(1),
	datab => \serialblock_inst|serialsender_inst|data_counter\(0),
	datac => \serialblock_inst|serialsender_inst|data_counter\(2),
	datad => \serialblock_inst|serialsender_inst|c_state~q\,
	combout => \serialblock_inst|serialsender_inst|data_counter[2]~0_combout\);

-- Location: FF_X4_Y9_N29
\serialblock_inst|serialsender_inst|data_counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|data_counter[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|data_counter\(2));

-- Location: LCCOMB_X4_Y9_N10
\serialblock_inst|serialsender_inst|sender_done~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|sender_done~1_combout\ = (\serialblock_inst|serialsender_inst|sender_done~0_combout\ & ((\serialblock_inst|serialsender_inst|sender_done~q\) # ((\serialblock_inst|serialsender_inst|data_counter\(0) & 
-- \serialblock_inst|serialsender_inst|data_counter\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|sender_done~0_combout\,
	datab => \serialblock_inst|serialsender_inst|data_counter\(0),
	datac => \serialblock_inst|serialsender_inst|sender_done~q\,
	datad => \serialblock_inst|serialsender_inst|data_counter\(2),
	combout => \serialblock_inst|serialsender_inst|sender_done~1_combout\);

-- Location: FF_X4_Y9_N11
\serialblock_inst|serialsender_inst|sender_done\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|sender_done~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|sender_done~q\);

-- Location: LCCOMB_X4_Y9_N6
\serialblock_inst|sender_start~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|sender_start~0_combout\ = (\send_start~combout\) # ((\serialblock_inst|sender_start~q\ & !\serialblock_inst|serialsender_inst|sender_done~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \send_start~combout\,
	datac => \serialblock_inst|sender_start~q\,
	datad => \serialblock_inst|serialsender_inst|sender_done~q\,
	combout => \serialblock_inst|sender_start~0_combout\);

-- Location: FF_X4_Y9_N7
\serialblock_inst|sender_start\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|sender_start~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|sender_start~q\);

-- Location: LCCOMB_X4_Y9_N4
\serialblock_inst|serialsender_inst|n_state~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|n_state~0_combout\ = (((!\serialblock_inst|serialsender_inst|data_counter\(0)) # (!\serialblock_inst|serialsender_inst|data_counter\(1))) # (!\serialblock_inst|serialsender_inst|c_state~q\)) # 
-- (!\serialblock_inst|serialsender_inst|data_counter\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|data_counter\(2),
	datab => \serialblock_inst|serialsender_inst|c_state~q\,
	datac => \serialblock_inst|serialsender_inst|data_counter\(1),
	datad => \serialblock_inst|serialsender_inst|data_counter\(0),
	combout => \serialblock_inst|serialsender_inst|n_state~0_combout\);

-- Location: LCCOMB_X4_Y9_N8
\serialblock_inst|serialsender_inst|n_state~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|n_state~1_combout\ = (\serialblock_inst|serialsender_inst|c_state~q\ & (((\serialblock_inst|serialsender_inst|n_state~0_combout\ & \serialblock_inst|serialsender_inst|n_state~q\)))) # 
-- (!\serialblock_inst|serialsender_inst|c_state~q\ & ((\serialblock_inst|sender_start~q\) # ((\serialblock_inst|serialsender_inst|n_state~0_combout\ & \serialblock_inst|serialsender_inst|n_state~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|c_state~q\,
	datab => \serialblock_inst|sender_start~q\,
	datac => \serialblock_inst|serialsender_inst|n_state~0_combout\,
	datad => \serialblock_inst|serialsender_inst|n_state~q\,
	combout => \serialblock_inst|serialsender_inst|n_state~1_combout\);

-- Location: LCCOMB_X4_Y9_N18
\serialblock_inst|serialsender_inst|n_state~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|n_state~feeder_combout\ = \serialblock_inst|serialsender_inst|n_state~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \serialblock_inst|serialsender_inst|n_state~1_combout\,
	combout => \serialblock_inst|serialsender_inst|n_state~feeder_combout\);

-- Location: FF_X4_Y9_N19
\serialblock_inst|serialsender_inst|n_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|n_state~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|n_state~q\);

-- Location: LCCOMB_X4_Y9_N0
\serialblock_inst|serialsender_inst|c_state~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|c_state~feeder_combout\ = \serialblock_inst|serialsender_inst|n_state~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \serialblock_inst|serialsender_inst|n_state~q\,
	combout => \serialblock_inst|serialsender_inst|c_state~feeder_combout\);

-- Location: FF_X4_Y9_N1
\serialblock_inst|serialsender_inst|c_state\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|c_state~feeder_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|c_state~q\);

-- Location: FF_X5_Y9_N5
\serialblock_inst|serialsender_inst|data_counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|data_counter[0]~2_combout\,
	ena => \serialblock_inst|serialsender_inst|c_state~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|data_counter\(0));

-- Location: LCCOMB_X5_Y9_N18
\serialblock_inst|serialsender_inst|pulse_enable~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulse_enable~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \serialblock_inst|serialsender_inst|pulse_enable~feeder_combout\);

-- Location: FF_X5_Y9_N19
\serialblock_inst|serialsender_inst|pulse_enable\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \serialblock_inst|clockdiv_inst|div_out~clkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|pulse_enable~feeder_combout\,
	ena => \serialblock_inst|serialsender_inst|c_state~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|pulse_enable~q\);

-- Location: LCCOMB_X5_Y9_N10
\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~0_combout\ = (\nreset~input_o\ & ((\serialblock_inst|serialsender_inst|pulse_enable~q\ & (\serialblock_inst|serialsender_inst|data_counter\(0))) # 
-- (!\serialblock_inst|serialsender_inst|pulse_enable~q\ & ((\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\))))) # (!\nreset~input_o\ & (((\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \nreset~input_o\,
	datab => \serialblock_inst|serialsender_inst|data_counter\(0),
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\,
	datad => \serialblock_inst|serialsender_inst|pulse_enable~q\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~0_combout\);

-- Location: FF_X5_Y9_N11
\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\);

-- Location: LCCOMB_X5_Y9_N14
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\ = (\serialblock_inst|serialsender_inst|pulse_enable~q\ & ((\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\ $ 
-- (\serialblock_inst|serialsender_inst|data_counter\(0))) # (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111110100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\,
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\,
	datac => \serialblock_inst|serialsender_inst|data_counter\(0),
	datad => \serialblock_inst|serialsender_inst|pulse_enable~q\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\);

-- Location: LCCOMB_X5_Y9_N16
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\ = (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\ & (\serialblock_inst|serialsender_inst|pulse_enable~q\ & 
-- (\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\ $ (!\serialblock_inst|serialsender_inst|data_counter\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\,
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_reset1~q\,
	datac => \serialblock_inst|serialsender_inst|data_counter\(0),
	datad => \serialblock_inst|serialsender_inst|pulse_enable~q\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\);

-- Location: LCCOMB_X5_Y9_N12
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~5_combout\ = (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0) & (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\)) # 
-- (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0) & ((\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\,
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0),
	datad => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~5_combout\);

-- Location: FF_X5_Y9_N13
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~5_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0));

-- Location: LCCOMB_X5_Y9_N28
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[1]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[1]~4_combout\ = (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1) & (((!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0) & 
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\)) # (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\))) # (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1) & 
-- (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0) & (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0),
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\,
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1),
	datad => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[1]~4_combout\);

-- Location: FF_X5_Y9_N29
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[1]~4_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1));

-- Location: LCCOMB_X5_Y9_N20
\serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~1_combout\ = \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2) $ (((\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0) & 
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101001101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2),
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0),
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1),
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~1_combout\);

-- Location: LCCOMB_X5_Y9_N22
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[2]~3_combout\ = (\serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~1_combout\ & ((\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\) # 
-- ((!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\ & \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2))))) # (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~1_combout\ & 
-- (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\ & (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~1_combout\,
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\,
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2),
	datad => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[2]~3_combout\);

-- Location: FF_X5_Y9_N23
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[2]~3_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2));

-- Location: LCCOMB_X5_Y9_N26
\serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~0_combout\ = \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3) $ (((\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2) & 
-- (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0) & \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2),
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(0),
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1),
	datad => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3),
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~0_combout\);

-- Location: LCCOMB_X5_Y9_N24
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~2_combout\ = (\serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~0_combout\ & ((\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\) # 
-- ((!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\ & \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3))))) # (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~0_combout\ & 
-- (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\ & (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|Add0~0_combout\,
	datab => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~1_combout\,
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3),
	datad => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[0]~0_combout\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~2_combout\);

-- Location: FF_X5_Y9_N25
\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter[3]~2_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3));

-- Location: LCCOMB_X5_Y9_N30
\serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\ = (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3) & ((\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2)) # 
-- (\serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(2),
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(1),
	datad => \serialblock_inst|serialsender_inst|pulsegenerator_inst|counter\(3),
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\);

-- Location: LCCOMB_X5_Y9_N8
\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~0_combout\ = (\serialblock_inst|serialsender_inst|pulse_enable~q\ & (!\serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\)) # 
-- (!\serialblock_inst|serialsender_inst|pulse_enable~q\ & ((\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|serialsender_inst|pulsegenerator_inst|LessThan0~0_combout\,
	datac => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~q\,
	datad => \serialblock_inst|serialsender_inst|pulse_enable~q\,
	combout => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~0_combout\);

-- Location: FF_X5_Y9_N9
\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~q\);

-- Location: LCCOMB_X13_Y20_N24
\serialblock_inst|my_uart_top_inst|transmitter|tx_int0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~0_combout\ = !\serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \serialblock_inst|serialsender_inst|pulsegenerator_inst|pulse_out~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~0_combout\);

-- Location: FF_X13_Y20_N25
\serialblock_inst|my_uart_top_inst|transmitter|tx_int0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~q\);

-- Location: LCCOMB_X17_Y20_N16
\serialblock_inst|my_uart_top_inst|transmitter|tx_int1~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~feeder_combout\ = \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~feeder_combout\);

-- Location: FF_X17_Y20_N17
\serialblock_inst|my_uart_top_inst|transmitter|tx_int1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~feeder_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\);

-- Location: LCCOMB_X17_Y20_N18
\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~feeder_combout\ = \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~feeder_combout\);

-- Location: FF_X17_Y20_N19
\serialblock_inst|my_uart_top_inst|transmitter|tx_int2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~feeder_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\);

-- Location: LCCOMB_X17_Y20_N30
\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ & ((\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\) # 
-- ((\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ & !\serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\)))) # (!\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ & (\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ 
-- & ((!\serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\,
	datad => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0_combout\);

-- Location: FF_X17_Y20_N31
\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\);

-- Location: LCCOMB_X16_Y20_N10
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~19_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~19_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\);

-- Location: LCCOMB_X16_Y20_N12
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~21_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\ $ (GND))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4) & 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\ & VCC))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\ = CARRY((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4) & !\serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~21_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\);

-- Location: FF_X16_Y20_N13
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~21_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4));

-- Location: LCCOMB_X16_Y20_N14
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\);

-- Location: FF_X16_Y20_N15
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5));

-- Location: LCCOMB_X16_Y20_N16
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~25_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\ $ (GND))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6) & 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\ & VCC))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\ = CARRY((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6) & !\serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~25_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\);

-- Location: FF_X16_Y20_N17
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~25_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6));

-- Location: LCCOMB_X16_Y20_N18
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~27_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~27_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\);

-- Location: FF_X16_Y20_N19
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~27_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7));

-- Location: LCCOMB_X16_Y20_N20
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~29_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\ $ (GND))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8) & 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\ & VCC))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\ = CARRY((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8) & !\serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~29_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\);

-- Location: FF_X16_Y20_N21
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~29_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8));

-- Location: LCCOMB_X17_Y20_N10
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\ = (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6) & 
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5),
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\);

-- Location: LCCOMB_X16_Y20_N0
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\ = (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2) & 
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4),
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\);

-- Location: LCCOMB_X16_Y20_N22
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\);

-- Location: FF_X16_Y20_N23
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9));

-- Location: LCCOMB_X16_Y20_N24
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ $ (GND))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ & VCC))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\ = CARRY((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & !\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\);

-- Location: FF_X16_Y20_N25
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10));

-- Location: LCCOMB_X16_Y20_N26
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~35\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~35_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~36\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~35_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~36\);

-- Location: FF_X16_Y20_N27
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~35_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11));

-- Location: LCCOMB_X16_Y20_N28
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[12]~37\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[12]~37_combout\ = \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~36\ $ (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(12))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(12),
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~36\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[12]~37_combout\);

-- Location: FF_X16_Y20_N29
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[12]~37_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(12));

-- Location: LCCOMB_X16_Y20_N30
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\ = (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11) & 
-- !\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(12),
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\);

-- Location: LCCOMB_X17_Y20_N24
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\ & \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\,
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\);

-- Location: LCCOMB_X16_Y20_N2
\serialblock_inst|my_uart_top_inst|speed_tx|process_0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\ = ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8) & (\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\ & \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\))) # 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\,
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\);

-- Location: FF_X16_Y20_N5
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~13_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0));

-- Location: LCCOMB_X16_Y20_N6
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\);

-- Location: FF_X16_Y20_N7
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1));

-- Location: LCCOMB_X16_Y20_N8
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ $ (GND))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2) & 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ & VCC))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\ = CARRY((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2) & !\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\);

-- Location: FF_X16_Y20_N9
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2));

-- Location: FF_X16_Y20_N11
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~19_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	sclr => \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3));

-- Location: LCCOMB_X17_Y20_N12
\serialblock_inst|my_uart_top_inst|speed_tx|process_1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0) & (\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\ & 
-- !\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\,
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5),
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\);

-- Location: LCCOMB_X17_Y20_N28
\serialblock_inst|my_uart_top_inst|speed_tx|process_1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|process_1~1_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\ & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6) & 
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|process_1~1_combout\);

-- Location: FF_X17_Y20_N29
\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|speed_tx|process_1~1_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\);

-- Location: LCCOMB_X18_Y20_N10
\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & ((\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\) # 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datad => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\);

-- Location: LCCOMB_X18_Y20_N18
\serialblock_inst|my_uart_top_inst|transmitter|num[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[0]~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & ((\serialblock_inst|my_uart_top_inst|transmitter|num\(0) & (\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ & 
-- !\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\)) # (!\serialblock_inst|my_uart_top_inst|transmitter|num\(0) & ((\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\))))) # (!\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & 
-- (((\serialblock_inst|my_uart_top_inst|transmitter|num\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[0]~0_combout\);

-- Location: FF_X18_Y20_N19
\serialblock_inst|my_uart_top_inst|transmitter|num[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|num[0]~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|num\(0));

-- Location: LCCOMB_X18_Y20_N28
\serialblock_inst|my_uart_top_inst|transmitter|num[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[1]~2_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & (\serialblock_inst|my_uart_top_inst|transmitter|num\(0) $ 
-- (\serialblock_inst|my_uart_top_inst|transmitter|num\(1))))) # (!\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (((\serialblock_inst|my_uart_top_inst|transmitter|num\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[1]~2_combout\);

-- Location: FF_X18_Y20_N29
\serialblock_inst|my_uart_top_inst|transmitter|num[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|num[1]~2_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|num\(1));

-- Location: LCCOMB_X18_Y20_N20
\serialblock_inst|my_uart_top_inst|transmitter|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\ = \serialblock_inst|my_uart_top_inst|transmitter|num\(2) $ (((\serialblock_inst|my_uart_top_inst|transmitter|num\(1) & \serialblock_inst|my_uart_top_inst|transmitter|num\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\);

-- Location: LCCOMB_X18_Y20_N22
\serialblock_inst|my_uart_top_inst|transmitter|num[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[2]~3_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (\serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\ & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\)))) # (!\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (((\serialblock_inst|my_uart_top_inst|transmitter|num\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[2]~3_combout\);

-- Location: FF_X18_Y20_N23
\serialblock_inst|my_uart_top_inst|transmitter|num[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|num[2]~3_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|num\(2));

-- Location: LCCOMB_X18_Y20_N26
\serialblock_inst|my_uart_top_inst|transmitter|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\ = \serialblock_inst|my_uart_top_inst|transmitter|num\(3) $ (((\serialblock_inst|my_uart_top_inst|transmitter|num\(2) & (\serialblock_inst|my_uart_top_inst|transmitter|num\(1) & 
-- \serialblock_inst|my_uart_top_inst|transmitter|num\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(3),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\);

-- Location: LCCOMB_X18_Y20_N24
\serialblock_inst|my_uart_top_inst|transmitter|num[3]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[3]~4_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (\serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\ & 
-- (\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\))) # (!\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (((\serialblock_inst|my_uart_top_inst|transmitter|num\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(3),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~4_combout\);

-- Location: FF_X18_Y20_N25
\serialblock_inst|my_uart_top_inst|transmitter|num[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~4_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|num\(3));

-- Location: LCCOMB_X18_Y20_N16
\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num\(2)) # (((!\serialblock_inst|my_uart_top_inst|transmitter|num\(3)) # (!\serialblock_inst|my_uart_top_inst|transmitter|num\(1))) # 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|num\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(3),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\);

-- Location: LCCOMB_X17_Y20_N26
\serialblock_inst|my_uart_top_inst|transmitter|tx_en~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|tx_en~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ & ((\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\) # ((\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ 
-- & !\serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\)))) # (!\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ & (\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ & 
-- ((!\serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datad => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~0_combout\);

-- Location: FF_X17_Y20_N27
\serialblock_inst|my_uart_top_inst|transmitter|tx_en\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\);

-- Location: LCCOMB_X18_Y20_N14
\serialblock_inst|my_uart_top_inst|transmitter|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num\(3) & ((\serialblock_inst|my_uart_top_inst|transmitter|num\(2)) # ((\serialblock_inst|my_uart_top_inst|transmitter|num\(1)) # 
-- (\serialblock_inst|my_uart_top_inst|transmitter|num\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(3),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\);

-- Location: LCCOMB_X18_Y20_N12
\serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & ((\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & ((\serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\))))) # 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & (((\serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\,
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0_combout\);

-- Location: FF_X18_Y20_N13
\serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\);

-- Location: IOIBUF_X34_Y12_N22
\keys[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_keys(0),
	o => \keys[0]~input_o\);

-- Location: IOIBUF_X34_Y12_N15
\keys[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_keys(1),
	o => \keys[1]~input_o\);

-- Location: IOIBUF_X34_Y12_N8
\keys[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_keys(2),
	o => \keys[2]~input_o\);

-- Location: IOIBUF_X34_Y2_N15
\switch[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_switch(0),
	o => \switch[0]~input_o\);

-- Location: IOIBUF_X1_Y24_N1
\switch[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_switch(1),
	o => \switch[1]~input_o\);

-- Location: IOIBUF_X30_Y0_N8
\switch[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_switch(2),
	o => \switch[2]~input_o\);

-- Location: IOIBUF_X34_Y4_N15
\switch[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_switch(3),
	o => \switch[3]~input_o\);

-- Location: IOIBUF_X34_Y12_N1
\keys[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_keys(3),
	o => \keys[3]~input_o\);

-- Location: IOIBUF_X28_Y24_N22
\rs232_rx~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rs232_rx,
	o => \rs232_rx~input_o\);

ww_rs232_tx <= \rs232_tx~output_o\;

ww_leds(0) <= \leds[0]~output_o\;

ww_leds(1) <= \leds[1]~output_o\;

ww_leds(2) <= \leds[2]~output_o\;

ww_leds(3) <= \leds[3]~output_o\;
END structure;


