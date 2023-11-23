onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tester/nreset
add wave -noupdate /tester/uart_vector
add wave -noupdate /tester/uart_tx
add wave -noupdate /tester/counter
add wave -noupdate /tester/send
add wave -noupdate /tester/receive
add wave -noupdate /tester/send_data
add wave -noupdate -radix ascii /tester/receive_data
add wave -noupdate /tester/rs232_rx
add wave -noupdate /tester/rs232_tx
add wave -noupdate /tester/string_input
add wave -noupdate /tester/bps_clock
add wave -noupdate /tester/bps_clock2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 1} {{Cursor 2} {140000 ps} 1} {{Cursor 3} {190000 ps} 1} {{Cursor 4} {82530000 ps} 1} {{Cursor 5} {87050000 ps} 1} {{Cursor 7} {7915570000 ps} 0}
quietly wave cursor active 6
configure wave -namecolwidth 130
configure wave -valuecolwidth 40
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
WaveRestoreZoom {7892699406 ps} {7933715214 ps}
