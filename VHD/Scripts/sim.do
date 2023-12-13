do scripts/serialsim.do

# read attributes ke read data
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/enable 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/nreset 0 0
noforce sim:/top/r_dataIn
run 52800ps

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