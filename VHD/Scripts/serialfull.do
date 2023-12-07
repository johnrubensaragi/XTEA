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
add wave -position insertpoint  \
sim:/top/clk
add wave -position insertpoint  \
sim:/top/serial_running
add wave -position insertpoint  \
sim:/top/serial_done
add wave -position insertpoint  \
sim:/top/error_check
add wave -position insertpoint  \
sim:/top/store_datatype
add wave -position insertpoint  \
sim:/top/store_checkout
add wave -position insertpoint  \
sim:/top/serial_output
add wave -position insertpoint  \
sim:/top/controlFSM0/current_state
add wave -position insertpoint  \
sim:/top/controlFSM0/next_state
add wave -position insertpoint  \
sim:/top/memory0/address
add wave -position insertpoint sim:/top/addressCounter/*
add wave -position insertpoint  \
sim:/top/xtea0/d_in_ready \
sim:/top/xtea0/d_in \
sim:/top/xtea0/key \
sim:/top/xtea0/clk \
sim:/top/xtea0/mode \
sim:/top/xtea0/d_out \
sim:/top/xtea0/d_out_ready
add wave -position insertpoint  \
sim:/top/memory0/sram00/r_datablock
add wave -position insertpoint  \
sim:/top/memory0/sram01/r_datablock