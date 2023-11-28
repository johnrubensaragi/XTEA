onbreak {resume}

if [file exists work] {
vdel -all
}

vlib work

vcom C:/Users/johnr/XTEA/serial_john/ClockDiv.vhd C:/Users/johnr/XTEA/serial_john/SerialBlock.vhd C:/Users/johnr/XTEA/serial_john/TB_Reader.vhd
vsim work.tb_reader

add wave -position insertpoint  \
sim:/tb_reader/d_out_ready \
sim:/tb_reader/d_out \
sim:/tb_reader/serial_end \
sim:/tb_reader/d_in \
sim:/tb_reader/d_in_ready \
sim:/tb_reader/d_in_transmitted \
sim:/tb_reader/clock \
sim:/tb_reader/nreset \
sim:/tb_reader/rs232_rx \
sim:/tb_reader/rs232_tx \
sim:/tb_reader/uart_vector \
sim:/tb_reader/uart_tx \
sim:/tb_reader/bps_clock \
sim:/tb_reader/counter \
sim:/tb_reader/clock_frequency \
sim:/tb_reader/clock_period \
sim:/tb_reader/baud_rate \
sim:/tb_reader/string_input

run 10 ms