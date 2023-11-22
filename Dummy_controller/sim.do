restart
force -freeze sim:/top/clk 1 0, 0 {50 ps} -r 100
run 200ps

force -freeze sim:/top/sram2d0/r_datablock(0)(0) 0001001000110100010101100111100000010010001101000101011001111000 0
force -freeze sim:/top/sram2d0/r_datablock(0)(1) 1001000010101011110011011110111110010000101010111100110111101111 0
force -freeze sim:/top/sram2d0/r_datablock(0)(2) 0000000000000000000000000000000000000000000000000000000000000001 0
force -freeze sim:/top/sram2d0/r_datablock(3)(3) 0000000000000000000000000000000000000000000000000000000000000000 0
# idle ke write raw data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/enable 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# write raw data ke send error
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 1 0
force -freeze sim:/top/nreset 0 0
run 200ps

# send error ke idle
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 1 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# idle ke write raw data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/enable 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# write raw data ke read attributes
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 1 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# read attributes ke read data
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
noforce sim:/top/r_dataIn
run 88800ps

force -freeze sim:/top/sram2d0/r_datablock(0)(0) 0001001000110100010101100111100000010010001101000101011001111000 0
force -freeze sim:/top/sram2d0/r_datablock(0)(1) 1001000010101011110011011110111110010000101010111100110111101111 0
force -freeze sim:/top/sram2d0/r_datablock(0)(2) 0000000000000000000000000000000000000000000000000000000000000000 0
force -freeze sim:/top/sram2d0/r_datablock(3)(3) 0000000000000000000000000000000000000000000000000000000000000000 0
# idle ke write raw data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/enable 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# write raw data ke send error
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 1 0
force -freeze sim:/top/nreset 0 0
run 200ps

# send error ke idle
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 1 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# idle ke write raw data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/enable 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# write raw data ke read attributes
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 1 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
run 200ps

# read attributes ke read data
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
noforce sim:/top/r_dataIn
run 78800ps



