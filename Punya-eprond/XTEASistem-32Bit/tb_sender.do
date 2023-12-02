onbreak {resume}

if [file exists wor] {
    vdel -all
}

vlib work

vcom ascii2hex.vhd hex2ascii.vhd Register.vhd MUX1Bit.vhd MUX2Data.vhd MUX4Data.vhd MUX8Data.vhd MUX16Data.vhd DEMUX2Data.vhd DEMUX4Data.vhd ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd uart_interpreter.vhd SRAM.vhd MemoryBlock.vhd XTEA.vhd Custom64BitShifter.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd AddressCounter.vhd Controller.vhd DummyTopLevel.vhd
vcom TB_Sender.vhd

vsim tb_sender

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_sender/rs232_rx
add wave -noupdate /tb_sender/rs232_tx
add wave -noupdate /tb_sender/error_format
add wave -noupdate /tb_sender/sender_running
add wave -noupdate /tb_sender/send_done
add wave -noupdate -radix ascii /tb_sender/send_data
add wave -noupdate -radix ascii /tb_sender/serialblock_inst/serialsender_inst/sender_data_in
add wave -noupdate -radix ascii /tb_sender/serialblock_inst/serialsender_inst/sender_data_out
add wave -noupdate /tb_sender/send_start
add wave -noupdate /tb_sender/serialblock_inst/sender_trigger
add wave -noupdate /tb_sender/send_convert
add wave -noupdate /tb_sender/serialblock_inst/serialsender_inst/c_state
add wave -noupdate /tb_sender/serialblock_inst/serialsender_inst/n_state
add wave -noupdate -radix ascii /tb_sender/serialblock_inst/serialsender_inst/rawdata_out
add wave -noupdate -radix ascii /tb_sender/serialblock_inst/serialsender_inst/convdata_out
add wave -noupdate /tb_sender/serialblock_inst/uart_interpreter_inst/d_in_ready
add wave -noupdate /tb_sender/serialblock_inst/uart_interpreter_inst/d_in_transmitted
add wave -noupdate /tb_sender/serialblock_inst/serialsender_inst/sender_transmit
add wave -noupdate /tb_sender/serialblock_inst/serialsender_inst/convdata_selector
add wave -noupdate /tb_sender/serialblock_inst/serialsender_inst/rawdata_selector

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {62889716916 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits sec
update
WaveRestoreZoom {21662457975 ps} {156754607475 ps}

run 5.5 ms