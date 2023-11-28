onbreak {resume}

if [file exists work] {
vdel -all
}

vlib work

vcom -reportprogress 300 -work work C:/Users/johnr/XTEA/serial_john/serial.vhd

vsim -gui work.top

add wave -position insertpoint  \
sim:/top/nreset \
sim:/top/clk \
sim:/top/rx \
sim:/top/d_out_ready \
sim:/top/d_out \
sim:/top/serial_end \
sim:/top/d_in \
sim:/top/d_in_ready \
sim:/top/d_in_transmitted \
sim:/top/tx \
sim:/top/d \
sim:/top/count_rx \
sim:/top/count_tx \
sim:/top/count_bit_rx \
sim:/top/count_bit_tx \
sim:/top/state_rx \
sim:/top/state_tx \
sim:/top/rx_buffer \
sim:/top/t \
sim:/top/baud_rate \
sim:/top/freq \
sim:/top/timeOut

force -freeze sim:/top/clk 1 0, 0 {10000 ps} -r {20 ns}

#idle
force -freeze sim:/top/rx 1 0
run 8680 ns

# start bit, kirim "t"
force -freeze sim:/top/rx 0 0
run 8680 ns

#bit 1-8
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns

# stop bit, idle
force -freeze sim:/top/rx 1 0
run 50000 ns

# start bit, kirim "tes"
force -freeze sim:/top/rx 0 0
run 8680 ns

#bit 1-8 
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns

# stop bit, no idle, 1 stop bit only
force -freeze sim:/top/rx 1 0
run 8600 ns

# start bit
force -freeze sim:/top/rx 0 0
run 8680 ns

#bit 1-8
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns

# stop bit
force -freeze sim:/top/rx 1 0
run 8680 ns

# start bit
force -freeze sim:/top/rx 0 0
run 8680 ns

#bit 1-8
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 1 0
run 8680 ns
force -freeze sim:/top/rx 0 0
run 8680 ns

# stop bit
force -freeze sim:/top/rx 1 0
run 8680 ns

#idle
run 50000 ns

# transmit "o"
force -freeze sim:/top/d_in(7) 0 0
force -freeze sim:/top/d_in(6) 1 0
force -freeze sim:/top/d_in(5) 1 0
force -freeze sim:/top/d_in(4) 0 0
force -freeze sim:/top/d_in(3) 1 0
force -freeze sim:/top/d_in(2) 1 0
force -freeze sim:/top/d_in(1) 1 0
force -freeze sim:/top/d_in(0) 1 0
force -freeze sim:/top/d_in_ready 1 0
run 78100 ns

# transmit "k"
force -freeze sim:/top/d_in(7) 0 0
force -freeze sim:/top/d_in(6) 1 0
force -freeze sim:/top/d_in(5) 1 0
force -freeze sim:/top/d_in(4) 0 0
force -freeze sim:/top/d_in(3) 1 0
force -freeze sim:/top/d_in(2) 0 0
force -freeze sim:/top/d_in(1) 1 0
force -freeze sim:/top/d_in(0) 1 0
force -freeze sim:/top/d_in_ready 1 0
run 86800 ns

# turn off transmit
force -freeze sim:/top/d_in_ready 0 0
run 50000 ns





