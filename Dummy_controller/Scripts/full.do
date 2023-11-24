vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/top.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Memory/demux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Memory/memory.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Memory/mux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Memory/sram.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Memory/vector_demux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Memory/vector_mux.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/XTEA/xtea.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Utils/controlFSM.vhd
vcom -reportprogress 300 -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/Utils/counter.vhd
vsim work.top
#add wave -r sim:/top/*
add wave -position insertpoint  \
sim:/top/controlFSM0/current_state
add wave sim:/top/*
add wave sim:/top/xtea0/*
add wave -position insertpoint  \
sim:/top/memory0/sram00/r_datablock
add wave -position insertpoint  \
sim:/top/memory0/sram01/r_datablock