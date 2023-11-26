onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vcom Register.vhd MUX1Bit.vhd MUX2Data.vhd MUX4Data.vhd DEMUX2Data.vhd DEMUX4Data.vhd ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd speed_select.vhd my_uart_rx.vhd my_uart_tx.vhd my_uart_top.vhd SRAM.vhd MemoryBlock.vhd XTEA.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd AddressCounter.vhd Controller.vhd DummyTopLevel.vhd
vcom TB_DummyTopLevel.vhd

vsim tb_dummytoplevel

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/nreset
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/rs232_rx
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/rs232_tx
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/error_out
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/reader_running
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/sender_running
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/read_done
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/send_start
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/send_done
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/send_data
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/store_data
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/store_datatype
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_start
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_done
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_mode
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/xtea_input
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/xtea_output
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/xtea_key
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/enable_write
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memory_write
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memory_read
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/countup_trigger
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/force_enable
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/force_address
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/address_out
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/selector_ctrigger
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/selector_datawrite
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/selector_datareset
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/selector_dataread
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/selector_datasend
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/selector_dataxtea
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/selector_datatext
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/countup_pulse
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/countup_pulse_trigger
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/sender_pulse
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/sender_pulse_enable
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/sender_pulse_trigger
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_pulse
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_pulse_enable
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_pulse_trigger
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/controller_inst/controller_cstate
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/ccounter_out
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/ccounter_enable
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/ccounter_reset
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/controller_inst/done_clear
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/memory_null
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/address_null
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram00_inst/ram
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram01_inst/ram
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram10_inst/ram
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram11_inst/ram
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram20_inst/ram
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram21_inst/ram
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram30_inst/ram
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memoryblock_inst/sram31_inst/ram

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8388750000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 140
configure wave -valuecolwidth 105
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
WaveRestoreZoom {0 ps} {52500103168 ps}

run 30 ms