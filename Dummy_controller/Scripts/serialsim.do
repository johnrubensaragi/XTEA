restart

force -freeze sim:/top/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 00 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 0000000000000000000000000000000000000000000000000000000000000000 0
run 400ps

force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 00 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 0000000000000000000000000000000000000000000000000000000000000000 0
run 100ps

force -freeze sim:/top/enable 1 0
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 00 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 0000000000000000000000000000000000000000000000000000000000000000 0
run 400ps

force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 00 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 0011001100110011001100110011001100110011001100110011001100110011 0
run 400ps

force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 00 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 0011001100110011001100110011001100110011001100110011001100110011 0
run 800ps

force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 10 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 0000000000000000000000000000000000000000000000000000000000000000 0
run 400ps

force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 10 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 0000000000000000000000000000000000000000000000000000000000000000 0
run 800ps

force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 01 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 1100110011001100110011001100110011001100110011001100110011001100 0
run 400ps

force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 01 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 1100110011001100110011001100110011001100110011001100110011001100 0
run 800ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 1111111111111111111111111111111111111111111111111111111111111111 0
run 400ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 1111111111111111111111111111111111111111111111111111111111111111 0
run 800ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 1010101010101010101010101010101010101010101010101010101010101010 0
run 400ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 1010101010101010101010101010101010101010101010101010101010101010 0
run 800ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 1111111111111111111111111111111111111111111111111111111111111111 0
run 400ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 1111111111111111111111111111111111111111111111111111111111111111 0
run 800ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 1010101010101010101010101010101010101010101010101010101010101010 0
run 400ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 1010101010101010101010101010101010101010101010101010101010101010 0
run 800ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 1111111111111111111111111111111111111111111111111111111111111111 0
run 400ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 1111111111111111111111111111111111111111111111111111111111111111 0
run 800ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 1 0
force -freeze sim:/top/serial_output 1010101010101010101010101010101010101010101010101010101010101010 0
run 400ps

#data
force -freeze sim:/top/serial_running 1 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 11 0
force -freeze sim:/top/store_checkout 0 0
force -freeze sim:/top/serial_output 1010101010101010101010101010101010101010101010101010101010101010 0
run 800ps

force -freeze sim:/top/serial_running 0 0
force -freeze sim:/top/serial_done 0 0
force -freeze sim:/top/error_check 0 0
force -freeze sim:/top/store_datatype 00 0
force -freeze sim:/top/store_checkout 0 0
run 400ps