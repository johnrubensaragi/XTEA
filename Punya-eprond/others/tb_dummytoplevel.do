onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vcom ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd speed_select.vhd my_uart_rx.vhd my_uart_tx.vhd my_uart_top.vhd SRAM.vhd XTEA.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd DummySerial.vhd DummyTopLevel.vhd
vcom TB_DummyTopLevel.vhd

vsim tb_dummytoplevel

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/rs232_rx
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/rs232_tx
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/leds
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/sender_pulse
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_pulse
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/ccounter_enable
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/ccounter_reset
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/ccounter_out
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/serial_running
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/read_done
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/send_done
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/error_out
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/store_data
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/store_address
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/send_data
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/send_start
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/send_counter
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memory_read
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/memory_write
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/memory_address
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/enable_read
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/enable_write
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_mode
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_start
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/xtea_done
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/xtea_input
add wave -noupdate -radix ascii /tb_dummytoplevel/dummytoplevel_inst/xtea_output
add wave -noupdate -radix hexadecimal /tb_dummytoplevel/dummytoplevel_inst/xtea_key
add wave -noupdate /tb_dummytoplevel/dummytoplevel_inst/controller_cstate

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {420 ms}

run 400 ms