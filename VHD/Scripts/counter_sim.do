restart
force -freeze sim:/counter/i_clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/counter/i_countup 1 0, 0 {800 ps} -r 1600
run 6400ps