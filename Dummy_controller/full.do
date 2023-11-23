vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/controlFSM.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/counter.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/sram2d.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/top.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/xtea.vhd
vsim work.top
add wave -r sim:/top/*