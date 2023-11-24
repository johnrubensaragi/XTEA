onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vcom MUX2Data.vhd MUX4Data.vhd ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd speed_select.vhd my_uart_rx.vhd my_uart_tx.vhd my_uart_top.vhd SRAM.vhd MemoryBlock.vhd XTEA.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd DummySerial.vhd DummyTopLevel.vhd
vcom TB_XTEA.vhd

vsim tb_xtea

quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_xtea/xtea_blok/clock
add wave -noupdate /tb_xtea/xtea_blok/nreset
add wave -noupdate -radix hexadecimal /tb_xtea/xtea_blok/xtea_key
add wave -noupdate -radix ascii /tb_xtea/xtea_blok/xtea_input
add wave -noupdate /tb_xtea/xtea_blok/xtea_mode
add wave -noupdate /tb_xtea/xtea_blok/xtea_start
add wave -noupdate -radix ascii /tb_xtea/xtea_blok/xtea_output
add wave -noupdate /tb_xtea/xtea_blok/xtea_done
add wave -noupdate -radix hexadecimal /tb_xtea/xtea_blok/subkey
add wave -noupdate /tb_xtea/xtea_blok/subinput0
add wave -noupdate /tb_xtea/xtea_blok/subinput1
add wave -noupdate /tb_xtea/xtea_blok/sum
add wave -noupdate /tb_xtea/xtea_blok/counter
add wave -noupdate /tb_xtea/xtea_blok/xtea_cstate
add wave -noupdate -radix hexadecimal /tb_xtea/xtea_blok/delta

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6500000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 63
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
WaveRestoreZoom {0 ps} {10500 ns}

run 6.5 us
