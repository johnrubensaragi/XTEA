restart
force -freeze sim:/sram2d/clk 1 0, 0 {50 ps} -r 100

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 00000000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 1000ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 1 0
force -freeze sim:/sram2d/address 00000000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 1 0
force -freeze sim:/sram2d/address 00000001 0
force -freeze sim:/sram2d/dataIn 0111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 1 0
force -freeze sim:/sram2d/address 00000010 0
force -freeze sim:/sram2d/dataIn 0011111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 00000000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 500ps

force -freeze sim:/sram2d/rd 1 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 00000000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 1 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 00000001 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 1 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 00000010 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps