vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/controlFSM.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/counter.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/memory.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/top.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/xtea.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/mux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/vector_demux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/demux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/vector_mux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/sram.vhd
vsim work.top
add wave -r sim:/top/*