onbreak {resume}

if [file exists wor] {
    vdel -all
}

vlib work

vcom ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd speed_select.vhd my_uart_rx.vhd my_uart_tx.vhd my_uart_top.vhd SRAM.vhd XTEA.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd DummySerial.vhd DummyTopLevel.vhd
vcom TB_Sender.vhd

vsim tb_sender

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_sender/serialblock_inst/serial_running
add wave -noupdate /tb_sender/serialblock_inst/send_done
add wave -noupdate /tb_sender/serialblock_inst/send_start
add wave -noupdate /tb_sender/serialblock_inst/error_out
add wave -noupdate -radix ascii /tb_sender/serialblock_inst/send_data
add wave -noupdate /tb_sender/serialblock_inst/rs232_rx
add wave -noupdate /tb_sender/serialblock_inst/rs232_tx
add wave -noupdate /tb_sender/serialblock_inst/internal_error
add wave -noupdate -radix ascii /tb_sender/serialblock_inst/uart_send
add wave -noupdate /tb_sender/serialblock_inst/sender_trigger
add wave -noupdate /tb_sender/serialblock_inst/sender_enable
add wave -noupdate /tb_sender/serialblock_inst/sender_start
add wave -noupdate /tb_sender/serialblock_inst/sender_done
add wave -noupdate /tb_sender/serialblock_inst/sender_clock

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

run 500 ms