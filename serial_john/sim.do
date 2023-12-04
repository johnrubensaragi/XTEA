onbreak {resume}

if [file exists work] {
vdel -all
}

vlib work

vcom -reportprogress 300 -work work C:/Users/johnr/XTEA/serial_john/my_uart_top.vhd

vsim -gui work.my_uart_top

add wave -position insertpoint  \
sim:/my_uart_top/nreset \
sim:/my_uart_top/clk \
sim:/my_uart_top/rx \
sim:/my_uart_top/d_out_ready \
-radix ascii sim:/my_uart_top/d_out \
sim:/my_uart_top/serial_end \
-radix ascii sim:/my_uart_top/d_in \
sim:/my_uart_top/d_in_ready \
sim:/my_uart_top/d_in_transmitted \
sim:/my_uart_top/tx \
sim:/my_uart_top/d \
sim:/my_uart_top/count_rx \
sim:/my_uart_top/count_tx \
sim:/my_uart_top/count_bit_rx \
sim:/my_uart_top/count_bit_tx \
sim:/my_uart_top/state_rx \
sim:/my_uart_top/state_tx \
sim:/my_uart_top/rx_buffer \
sim:/my_uart_top/t \
sim:/my_uart_top/baud_rate \
sim:/my_uart_top/freq \
sim:/my_uart_top/timeOut

force -freeze sim:/my_uart_top/clk 1 0, 0 {10000 ps} -r {20 ns}

#idle
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns

# start bit, kirim "t"
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

#bit 1-8
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

# stop bit, idle
force -freeze sim:/my_uart_top/rx 1 0
run 50000 ns

# start bit, kirim "tes"
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

#bit 1-8 
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

# stop bit, no idle, 1 stop bit only
force -freeze sim:/my_uart_top/rx 1 0
run 8600 ns

# start bit
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

#bit 1-8
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

# stop bit
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns

# start bit
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

#bit 1-8
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns
force -freeze sim:/my_uart_top/rx 0 0
run 8680 ns

# stop bit
force -freeze sim:/my_uart_top/rx 1 0
run 8680 ns

#idle
run 50000 ns

# transmit "o"
force -freeze sim:/my_uart_top/d_in(7) 0 0
force -freeze sim:/my_uart_top/d_in(6) 1 0
force -freeze sim:/my_uart_top/d_in(5) 1 0
force -freeze sim:/my_uart_top/d_in(4) 0 0
force -freeze sim:/my_uart_top/d_in(3) 1 0
force -freeze sim:/my_uart_top/d_in(2) 1 0
force -freeze sim:/my_uart_top/d_in(1) 1 0
force -freeze sim:/my_uart_top/d_in(0) 1 0
force -freeze sim:/my_uart_top/d_in_ready 1 0
run 78100 ns

# transmit "k"
force -freeze sim:/my_uart_top/d_in(7) 0 0
force -freeze sim:/my_uart_top/d_in(6) 1 0
force -freeze sim:/my_uart_top/d_in(5) 1 0
force -freeze sim:/my_uart_top/d_in(4) 0 0
force -freeze sim:/my_uart_top/d_in(3) 1 0
force -freeze sim:/my_uart_top/d_in(2) 0 0
force -freeze sim:/my_uart_top/d_in(1) 1 0
force -freeze sim:/my_uart_top/d_in(0) 1 0
force -freeze sim:/my_uart_top/d_in_ready 1 0
run 86800 ns

# turn off transmit
force -freeze sim:/my_uart_top/d_in_ready 0 0
run 50000 ns





