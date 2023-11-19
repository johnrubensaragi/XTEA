onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate sim:/testbench/dut/data_length
add wave -noupdate sim:/testbench/dut/address_length
add wave -noupdate sim:/testbench/dut/clock
add wave -noupdate sim:/testbench/dut/nreset
add wave -noupdate sim:/testbench/dut/check_address
add wave -noupdate -radix ascii sim:/testbench/dut/check_data
add wave -noupdate -radix ascii sim:/testbench/dut/read_input
add wave -noupdate sim:/testbench/dut/start_read
add wave -noupdate sim:/testbench/dut/trigger
add wave -noupdate sim:/testbench/dut/enable_read
add wave -noupdate sim:/testbench/dut/enable_write
add wave -noupdate sim:/testbench/dut/serial_address
add wave -noupdate sim:/testbench/dut/memory_address
add wave -noupdate -radix ascii sim:/testbench/dut/serial_data
add wave -noupdate -radix ascii sim:/testbench/dut/memory_write
add wave -noupdate -radix ascii sim:/testbench/dut/memory_read
add wave -noupdate sim:/testbench/dut/serial_done
add wave -noupdate sim:/testbench/dut/check_error
add wave -noupdate sim:/testbench/dut/controller_cstate
add wave -noupdate sim:/testbench/dut/controller_nstate
add wave -noupdate -radix ascii sim:/testbench/dut/ram/memory_write
add wave -noupdate -radix ascii sim:/testbench/dut/ram/memory_read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7108775 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 81
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10500 ns}
