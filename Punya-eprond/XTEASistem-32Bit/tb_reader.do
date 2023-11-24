onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vcom MUX2Data.vhd MUX4Data.vhd ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd speed_select.vhd my_uart_rx.vhd my_uart_tx.vhd my_uart_top.vhd SRAM.vhd MemoryBlock.vhd XTEA.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd DummySerial.vhd DummyTopLevel.vhd
vcom TB_Reader.vhd

vsim tb_reader

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_reader/serialblock_inst/serial_running
add wave -noupdate /tb_reader/serialblock_inst/read_done
add wave -noupdate /tb_reader/serialblock_inst/send_done
add wave -noupdate /tb_reader/serialblock_inst/error_out
add wave -noupdate -radix ascii /tb_reader/serialblock_inst/store_data
add wave -noupdate /tb_reader/serialblock_inst/store_datatype
add wave -noupdate /tb_reader/serialblock_inst/store_checkout
add wave -noupdate /tb_reader/serialblock_inst/rs232_rx
add wave -noupdate /tb_reader/serialblock_inst/rs232_tx
add wave -noupdate /tb_reader/serialblock_inst/serialreader_inst/temp_data
add wave -noupdate -radix ascii /tb_reader/serialblock_inst/reader_data_in
add wave -noupdate -radix ascii /tb_reader/serialblock_inst/reader_data_out
add wave -noupdate /tb_reader/serialblock_inst/reader_data_type
add wave -noupdate /tb_reader/serialblock_inst/reader_data_checkout
add wave -noupdate /tb_reader/serialblock_inst/reader_trigger
add wave -noupdate /tb_reader/serialblock_inst/reader_enable
add wave -noupdate /tb_reader/serialblock_inst/reader_start
add wave -noupdate /tb_reader/serialblock_inst/reader_done
add wave -noupdate /tb_reader/serialblock_inst/receive
add wave -noupdate /tb_reader/serialblock_inst/receive_c
add wave -noupdate /tb_reader/serialblock_inst/internal_error

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
WaveRestoreZoom {0 ps} {367500 us}

run 5 ms