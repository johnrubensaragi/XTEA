transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/TestSender.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/SerialBlock.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/PulseGenerator.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/my_uart_tx.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/my_uart_top.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/my_uart_rx.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/ClockDiv.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/SerialSender.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/SerialReader.vhd}
vcom -93 -work work {C:/Users/irfan/Documents/ITB/Kuliah/Semester3/Sistem-Digital/Tugas-Kelompok/Tugas-2/Codes/XTEA/Punya-eprond/XTEASistem/speed_select.vhd}

