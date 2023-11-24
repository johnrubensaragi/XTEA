onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vcom MUX2Data.vhd MUX4Data.vhd ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd speed_select.vhd my_uart_rx.vhd my_uart_tx.vhd my_uart_top.vhd SRAM.vhd MemoryBlock.vhd XTEA.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd DummySerial.vhd DummyTopLevel.vhd
vcom TB_DummySerial.vhd

vsim tb_dummyserial

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dummyserial/dummyserial_inst/rs232_rx
add wave -noupdate /tb_dummyserial/dummyserial_inst/rs232_tx
add wave -noupdate /tb_dummyserial/dummyserial_inst/keys
add wave -noupdate /tb_dummyserial/dummyserial_inst/leds
add wave -noupdate /tb_dummyserial/dummyserial_inst/sender_pulse_trigger
add wave -noupdate /tb_dummyserial/dummyserial_inst/sender_pulse_enable
add wave -noupdate /tb_dummyserial/dummyserial_inst/sender_pulse
add wave -noupdate /tb_dummyserial/dummyserial_inst/ccounter_enable
add wave -noupdate /tb_dummyserial/dummyserial_inst/ccounter_reset
add wave -noupdate /tb_dummyserial/dummyserial_inst/serial_running
add wave -noupdate /tb_dummyserial/dummyserial_inst/read_done
add wave -noupdate /tb_dummyserial/dummyserial_inst/send_done
add wave -noupdate /tb_dummyserial/dummyserial_inst/send_done_buffer
add wave -noupdate /tb_dummyserial/dummyserial_inst/error_out
add wave -noupdate -radix ascii /tb_dummyserial/dummyserial_inst/store_data
add wave -noupdate /tb_dummyserial/dummyserial_inst/store_address
add wave -noupdate -radix ascii /tb_dummyserial/dummyserial_inst/send_data
add wave -noupdate /tb_dummyserial/dummyserial_inst/send_start
add wave -noupdate /tb_dummyserial/dummyserial_inst/send_counter
add wave -noupdate -radix ascii /tb_dummyserial/dummyserial_inst/memory_read
add wave -noupdate -radix ascii /tb_dummyserial/dummyserial_inst/memory_write
add wave -noupdate /tb_dummyserial/dummyserial_inst/memory_address
add wave -noupdate /tb_dummyserial/dummyserial_inst/enable_read
add wave -noupdate /tb_dummyserial/dummyserial_inst/enable_write
add wave -noupdate /tb_dummyserial/dummyserial_inst/controller_cstate
add wave -noupdate /tb_dummyserial/dummyserial_inst/ccounter_out

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {117364364982 ps} 0}
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

run 400 ms
