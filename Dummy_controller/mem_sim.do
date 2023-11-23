force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 0000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 1000ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 1 0
force -freeze sim:/sram2d/address 0000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 1 0
force -freeze sim:/sram2d/address 0001 0
force -freeze sim:/sram2d/dataIn 0111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 1 0
force -freeze sim:/sram2d/address 0010 0
force -freeze sim:/sram2d/dataIn 0011111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 0 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 0000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 500ps

force -freeze sim:/sram2d/rd 1 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 0000 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 1 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 0001 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps

force -freeze sim:/sram2d/rd 1 0
force -freeze sim:/sram2d/wrt 0 0
force -freeze sim:/sram2d/address 0010 0
force -freeze sim:/sram2d/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run 100ps