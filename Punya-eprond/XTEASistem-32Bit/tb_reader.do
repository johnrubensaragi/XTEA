onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vcom ascii2hex.vhd hex2ascii.vhd Register.vhd MUX1Bit.vhd MUX2Data.vhd MUX4Data.vhd MUX8Data.vhd MUX16Data.vhd DEMUX2Data.vhd DEMUX4Data.vhd ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd SRAM.vhd MemoryBlock.vhd XTEA.vhd Custom64BitShifter.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd AddressCounter.vhd Controller.vhd DummyTopLevel.vhd
vcom TB_Reader.vhd

vsim tb_reader

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_reader/serialblock_inst/rs232_rx
add wave -noupdate /tb_reader/serialblock_inst/rs232_tx
add wave -noupdate /tb_reader/serialblock_inst/reader_running
add wave -noupdate /tb_reader/serialblock_inst/read_done
add wave -noupdate /tb_reader/serialblock_inst/error_out
add wave -noupdate -radix hexadecimal /tb_reader/serialblock_inst/store_data
add wave -noupdate /tb_reader/serialblock_inst/store_datatype
add wave -noupdate /tb_reader/serialblock_inst/store_checkout
add wave -noupdate /tb_reader/serialblock_inst/reader_data_in
add wave -noupdate /tb_reader/serialblock_inst/reader_trigger
add wave -noupdate /tb_reader/serialblock_inst/reader_enable
add wave -noupdate /tb_reader/serialblock_inst/reader_start
add wave -noupdate /tb_reader/serialblock_inst/reader_finish
add wave -noupdate /tb_reader/serialblock_inst/reader_done
add wave -noupdate /tb_reader/serialblock_inst/reader_trigger_signal
add wave -noupdate /tb_reader/serialblock_inst/reader_trigger_buffer
add wave -noupdate -radix ascii /tb_reader/serialblock_inst/serialreader_inst/shifter_8bit_dataout
add wave -noupdate -radix hexadecimal /tb_reader/serialblock_inst/serialreader_inst/shifter_4bit_dataout
add wave -noupdate -radix ascii /tb_reader/serialblock_inst/reader_data_out
add wave -noupdate /tb_reader/serialblock_inst/reader_data_type
add wave -noupdate /tb_reader/serialblock_inst/reader_data_checkout
add wave -noupdate /tb_reader/serialblock_inst/internal_error
add wave -noupdate /tb_reader/serialblock_inst/serialreader_inst/c_state

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {233142725031 ps} 0}
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
WaveRestoreZoom {0 ps} {7 ms}

run 9 ms