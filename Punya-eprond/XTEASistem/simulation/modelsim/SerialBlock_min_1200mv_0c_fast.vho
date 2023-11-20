-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "11/20/2023 22:56:42"

-- 
-- Device: Altera EP4CE6E22C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	TestSender IS
    PORT (
	clock : IN std_logic;
	nreset : IN std_logic;
	rs232_rx : IN std_logic;
	rs232_tx : OUT std_logic
	);
END TestSender;

-- Design Ports Information
-- rs232_tx	=>  Location: PIN_46,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs232_rx	=>  Location: PIN_128,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- nreset	=>  Location: PIN_24,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF TestSender IS
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
SIGNAL \nreset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~21_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[2]~3_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_en~0_combout\ : std_logic;
SIGNAL \rs232_rx~input_o\ : std_logic;
SIGNAL \rs232_tx~output_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~13_combout\ : std_logic;
SIGNAL \nreset~input_o\ : std_logic;
SIGNAL \nreset~inputclkctrl_outclk\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~19_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~35_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[11]~36\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[12]~37_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|process_0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[3]~20\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~25_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[6]~26\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~27_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[7]~28\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~29_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~feeder_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[0]~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[3]~4_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num[1]~2_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|process_1~1_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0_combout\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\ : std_logic;
SIGNAL \serialblock_inst|my_uart_top_inst|speed_tx|cnt\ : std_logic_vector(12 DOWNTO 0);
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|num\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \serialblock_inst|my_uart_top_inst|transmitter|ALT_INV_rs232_tx_r~q\ : std_logic;

BEGIN

ww_clock <= clock;
ww_nreset <= nreset;
ww_rs232_rx <= rs232_rx;
rs232_tx <= ww_rs232_tx;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\nreset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \nreset~input_o\);

\clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock~input_o\);
\serialblock_inst|my_uart_top_inst|transmitter|ALT_INV_rs232_tx_r~q\ <= NOT \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\;

-- Location: FF_X8_Y5_N11
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

-- Location: LCCOMB_X8_Y5_N10
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

-- Location: FF_X9_Y5_N27
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

-- Location: FF_X9_Y5_N23
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

-- Location: LCCOMB_X9_Y5_N6
\serialblock_inst|my_uart_top_inst|transmitter|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\ = \serialblock_inst|my_uart_top_inst|transmitter|num\(2) $ (((\serialblock_inst|my_uart_top_inst|transmitter|num\(0) & \serialblock_inst|my_uart_top_inst|transmitter|num\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\);

-- Location: LCCOMB_X9_Y5_N26
\serialblock_inst|my_uart_top_inst|transmitter|num[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[2]~3_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (\serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\ & 
-- (\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\))) # (!\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (((\serialblock_inst|my_uart_top_inst|transmitter|num\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|Add0~0_combout\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[2]~3_combout\);

-- Location: LCCOMB_X9_Y5_N12
\serialblock_inst|my_uart_top_inst|transmitter|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\ = \serialblock_inst|my_uart_top_inst|transmitter|num\(3) $ (((\serialblock_inst|my_uart_top_inst|transmitter|num\(2) & (\serialblock_inst|my_uart_top_inst|transmitter|num\(0) & 
-- \serialblock_inst|my_uart_top_inst|transmitter|num\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(3),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Add0~1_combout\);

-- Location: FF_X9_Y5_N7
\serialblock_inst|my_uart_top_inst|transmitter|tx_int2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\,
	clrn => \nreset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\);

-- Location: LCCOMB_X9_Y5_N22
\serialblock_inst|my_uart_top_inst|transmitter|tx_en~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|tx_en~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ & (((\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\)) 
-- # (!\serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\))) # (!\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ & (((\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & 
-- \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datad => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~0_combout\);

-- Location: IOOBUF_X7_Y0_N2
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

-- Location: LCCOMB_X8_Y5_N2
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

-- Location: IOIBUF_X0_Y11_N15
\nreset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_nreset,
	o => \nreset~input_o\);

-- Location: CLKCTRL_G4
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

-- Location: LCCOMB_X8_Y5_N8
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

-- Location: FF_X8_Y5_N9
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

-- Location: LCCOMB_X8_Y5_N12
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[4]~22\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~23_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[5]~24\);

-- Location: FF_X8_Y5_N13
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

-- Location: LCCOMB_X9_Y5_N14
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\ = (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5) & 
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0),
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~3_combout\);

-- Location: LCCOMB_X8_Y5_N6
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ $ (GND))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2) & 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ & VCC))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\ = CARRY((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2) & !\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~17_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[2]~18\);

-- Location: FF_X8_Y5_N7
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

-- Location: LCCOMB_X8_Y5_N0
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1) & 
-- !\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(4),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(7),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(2),
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\);

-- Location: LCCOMB_X8_Y5_N18
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

-- Location: LCCOMB_X8_Y5_N20
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[8]~30\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~31_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\);

-- Location: LCCOMB_X8_Y5_N22
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ $ (GND))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\ & VCC))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\ = CARRY((\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & !\serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[9]~32\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~33_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[10]~34\);

-- Location: FF_X8_Y5_N23
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

-- Location: LCCOMB_X8_Y5_N24
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

-- Location: FF_X8_Y5_N25
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

-- Location: LCCOMB_X8_Y5_N26
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

-- Location: FF_X8_Y5_N27
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

-- Location: FF_X8_Y5_N21
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

-- Location: LCCOMB_X8_Y5_N28
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\ = (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(12) & 
-- !\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(10),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(11),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(12),
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(9),
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\);

-- Location: LCCOMB_X8_Y5_N30
\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\ & \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~0_combout\,
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~1_combout\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\);

-- Location: LCCOMB_X9_Y5_N8
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

-- Location: FF_X8_Y5_N3
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

-- Location: LCCOMB_X8_Y5_N4
\serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\)) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1) & 
-- ((\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\) # (GND)))
-- \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\ = CARRY((!\serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\) # (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(1),
	datad => VCC,
	cin => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[0]~14\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~15_combout\,
	cout => \serialblock_inst|my_uart_top_inst|speed_tx|cnt[1]~16\);

-- Location: FF_X8_Y5_N5
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

-- Location: LCCOMB_X8_Y5_N14
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

-- Location: FF_X8_Y5_N15
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

-- Location: LCCOMB_X8_Y5_N16
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

-- Location: FF_X8_Y5_N17
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

-- Location: FF_X8_Y5_N19
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

-- Location: LCCOMB_X10_Y5_N12
\serialblock_inst|my_uart_top_inst|transmitter|tx_int0~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~feeder_combout\);

-- Location: FF_X10_Y5_N13
\serialblock_inst|my_uart_top_inst|transmitter|tx_int0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~feeder_combout\,
	clrn => \nreset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~q\);

-- Location: FF_X9_Y5_N11
\serialblock_inst|my_uart_top_inst|transmitter|tx_int1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \serialblock_inst|my_uart_top_inst|transmitter|tx_int0~q\,
	clrn => \nreset~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\);

-- Location: LCCOMB_X9_Y5_N28
\serialblock_inst|my_uart_top_inst|transmitter|num[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[0]~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & ((\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & (!\serialblock_inst|my_uart_top_inst|transmitter|num\(0))) # 
-- (!\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & (\serialblock_inst|my_uart_top_inst|transmitter|num\(0) & \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\)))) # (!\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & 
-- (((\serialblock_inst|my_uart_top_inst|transmitter|num\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100001011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[0]~0_combout\);

-- Location: FF_X9_Y5_N29
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

-- Location: LCCOMB_X9_Y5_N10
\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & ((\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\) # 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	datad => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\);

-- Location: LCCOMB_X9_Y5_N4
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

-- Location: FF_X9_Y5_N5
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

-- Location: LCCOMB_X9_Y5_N20
\serialblock_inst|my_uart_top_inst|transmitter|num[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|num[1]~2_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & (\serialblock_inst|my_uart_top_inst|transmitter|num\(1) $ 
-- (\serialblock_inst|my_uart_top_inst|transmitter|num\(0))))) # (!\serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\ & (((\serialblock_inst|my_uart_top_inst|transmitter|num\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101100011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num[3]~1_combout\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|num[1]~2_combout\);

-- Location: FF_X9_Y5_N21
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

-- Location: LCCOMB_X9_Y5_N18
\serialblock_inst|my_uart_top_inst|transmitter|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num\(2)) # (((!\serialblock_inst|my_uart_top_inst|transmitter|num\(1)) # (!\serialblock_inst|my_uart_top_inst|transmitter|num\(3))) # 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|num\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(3),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\);

-- Location: LCCOMB_X9_Y5_N2
\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ & (((\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\ & 
-- \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\)) # (!\serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\))) # (!\serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\ & 
-- (((\serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\ & \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|tx_int2~q\,
	datab => \serialblock_inst|my_uart_top_inst|transmitter|tx_int1~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\,
	datad => \serialblock_inst|my_uart_top_inst|transmitter|Equal0~0_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~0_combout\);

-- Location: FF_X9_Y5_N3
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

-- Location: LCCOMB_X9_Y5_N30
\serialblock_inst|my_uart_top_inst|speed_tx|process_1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\ = (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5) & (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3) & 
-- \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(0),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(5),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(3),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|bps_start_r~q\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\);

-- Location: LCCOMB_X9_Y5_N24
\serialblock_inst|my_uart_top_inst|speed_tx|process_1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|speed_tx|process_1~1_combout\ = (\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6) & (!\serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8) & (\serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\ & 
-- \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(6),
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|cnt\(8),
	datac => \serialblock_inst|my_uart_top_inst|speed_tx|process_1~0_combout\,
	datad => \serialblock_inst|my_uart_top_inst|speed_tx|Equal0~2_combout\,
	combout => \serialblock_inst|my_uart_top_inst|speed_tx|process_1~1_combout\);

-- Location: FF_X9_Y5_N25
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

-- Location: LCCOMB_X9_Y5_N0
\serialblock_inst|my_uart_top_inst|transmitter|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|num\(3) & ((\serialblock_inst|my_uart_top_inst|transmitter|num\(2)) # ((\serialblock_inst|my_uart_top_inst|transmitter|num\(0)) # 
-- (\serialblock_inst|my_uart_top_inst|transmitter|num\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|num\(2),
	datab => \serialblock_inst|my_uart_top_inst|transmitter|num\(0),
	datac => \serialblock_inst|my_uart_top_inst|transmitter|num\(3),
	datad => \serialblock_inst|my_uart_top_inst|transmitter|num\(1),
	combout => \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\);

-- Location: LCCOMB_X9_Y5_N16
\serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0_combout\ = (\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & ((\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & 
-- ((!\serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\))) # (!\serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\ & (\serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\)))) # 
-- (!\serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\ & (((\serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \serialblock_inst|my_uart_top_inst|transmitter|tx_en~q\,
	datab => \serialblock_inst|my_uart_top_inst|speed_tx|clk_bps_r~q\,
	datac => \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~q\,
	datad => \serialblock_inst|my_uart_top_inst|transmitter|Mux0~0_combout\,
	combout => \serialblock_inst|my_uart_top_inst|transmitter|rs232_tx_r~0_combout\);

-- Location: FF_X9_Y5_N17
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

-- Location: IOIBUF_X16_Y24_N15
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
END structure;


