restart
force -freeze sim:/top/clk 1 0, 0 {50 ps} -r 100

# berhenti encrypt/decrypt di sini
force -freeze sim:/top/memory0/sram01/r_datablock(7) 00000000000000000000000000000000 0
force -freeze sim:/top/memory0/sram00/r_datablock(7) 00000000000000000000000000000000 0
run 100ps
force -freeze sim:/top/r_enable_write 1 0
force -freeze sim:/top/r_dataIn 1100110011001100110011001100110011001100110011001100110011001100 0
force -freeze sim:/top/r_address_countup 1 0
run 200ps
force -freeze sim:/top/r_dataIn 0000000000000000000000000000000000000000000000000000000000000000 0
force -freeze sim:/top/r_address_countup 0 0
force -freeze sim:/top/r_address_to_attributes 1 0
run 100ps
force -freeze sim:/top/r_enable_write 0 0
noforce sim:/top/r_address_countup
noforce sim:/top/r_address_to_attributes

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
noforce sim:/top/r_dataIn
noforce sim:/top/r_enable_write

# read attributes ke read data
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
noforce sim:/top/r_dataIn
run 88800ps

run 100ps
force -freeze sim:/top/r_enable_write 1 0
force -freeze sim:/top/r_dataIn 1100110011001100110011001100110011001100110011001100110011001100 0
force -freeze sim:/top/r_address_countup 1 0
run 200ps
force -freeze sim:/top/r_dataIn 0000000000000000000000000000000000000000000000000000000000000001 0
force -freeze sim:/top/r_address_countup 0 0
force -freeze sim:/top/r_address_to_attributes 1 0
run 100ps
force -freeze sim:/top/r_enable_write 0 0
noforce sim:/top/r_address_countup
noforce sim:/top/r_address_to_attributes

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
noforce sim:/top/r_dataIn
noforce sim:/top/r_enable_write

# read attributes ke read data
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
noforce sim:/top/r_dataIn
run 88800ps