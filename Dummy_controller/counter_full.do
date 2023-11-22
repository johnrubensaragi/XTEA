vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/counter.vhd
vsim work.counter
add wave sim:/counter/*
force -freeze sim:/counter/i_clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/counter/i_countup 1 0, 0 {800 ps} -r 1600
force -freeze sim:/counter/i_rst 0 0, 1 {100 ps} -r 1600
run 6400ps