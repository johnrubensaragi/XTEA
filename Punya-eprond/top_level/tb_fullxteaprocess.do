onbreak {resume}

if [file exists work] {
    vdel -all
}

vlib work

vcom Register.vhd MUX1Bit.vhd MUX2Data.vhd MUX4Data.vhd DEMUX2Data.vhd DEMUX4Data.vhd ClockCounter.vhd ClockDiv.vhd PulseGenerator.vhd speed_select.vhd my_uart_rx.vhd my_uart_tx.vhd my_uart_top.vhd SRAM.vhd MemoryBlock.vhd XTEA.vhd SerialReader.vhd SerialSender.vhd SerialBlock.vhd AddressCounter.vhd Controller.vhd DummyTopLevel.vhd
vcom TB_FullXTEAProcess.vhd

vsim tb_fullxteaprocess
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fullxteaprocess/XteaSistem1_inst/rs232_rx
add wave -noupdate /tb_fullxteaprocess/XteaSistem1_inst/rs232_tx
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem1_inst/send_data
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem1_inst/store_data
add wave -noupdate /tb_fullxteaprocess/XteaSistem1_inst/controller_inst/controller_cstate
add wave -noupdate /tb_fullxteaprocess/XteaSistem2_inst/rs232_rx
add wave -noupdate /tb_fullxteaprocess/XteaSistem2_inst/rs232_tx
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem2_inst/send_data
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem2_inst/store_data
add wave -noupdate /tb_fullxteaprocess/XteaSistem2_inst/controller_inst/controller_cstate
add wave -noupdate /tb_fullxteaprocess/XteaSistem2_inst/serialblock_inst/reader_trigger
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem2_inst/serialblock_inst/reader_data_in
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem1_inst/memoryblock_inst/sram00_inst/ram
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem1_inst/memoryblock_inst/sram01_inst/ram
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem2_inst/memoryblock_inst/sram00_inst/ram
add wave -noupdate -radix ascii /tb_fullxteaprocess/XteaSistem2_inst/memoryblock_inst/sram01_inst/ram

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19519261630 ps} 0} {{Cursor 2} {48575912808 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
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
configure wave -timelineunits sec
update
WaveRestoreZoom {13323893748 ps} {25904206252 ps}

run 35 ms