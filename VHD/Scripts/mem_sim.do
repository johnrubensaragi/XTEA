add wave sim:/memory/*
force -freeze sim:/memory/clk 1 0, 0 {50 ps} -r 100
noforce sim:/memory/rd
force -freeze sim:/memory/rd 0 0
force -freeze sim:/memory/wrt 1 0
force -freeze sim:/memory/dataIn 1111111111111111111111111111111111111111111111111111111111111111 0
run
run
run
force -freeze sim:/memory/address 0000000000 0
run
run
run
run
run
run
run
run
force -freeze sim:/memory/address 1100000000 0
run
run
run
run
run
run
force -freeze sim:/memory/wrt 0 0
run
run
force -freeze sim:/memory/rd 1 0
force -freeze sim:/memory/address 0000000000 0
run
run
run
run
run
force -freeze sim:/memory/address 0100000000 0
run
run
run
run
run
run
run
run
run
run