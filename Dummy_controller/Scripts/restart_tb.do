vcom -work work C:/School/Kuliah/ITB/Matkul/Sisdig/Tubes/XTEA/Dummy_controller/tb_top.vhd
vsim work.tb_dummytoplevel
add wave -position insertpoint sim:/tb_dummytoplevel/dummytoplevel_inst/controlFSM0/*
add wave -position insertpoint  \
sim:/tb_dummytoplevel/dummytoplevel_inst/r_address
add wave -position insertpoint sim:/tb_dummytoplevel/dummytoplevel_inst/serialblock_inst/*
add wave -position insertpoint  \
sim:/tb_dummytoplevel/dummytoplevel_inst/memory0/sram00/r_datablock
add wave -position insertpoint  \
sim:/tb_dummytoplevel/dummytoplevel_inst/memory0/sram01/r_datablock
run 50ms