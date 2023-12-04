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
add wave -position insertpoint  \
sim:/tb_dummytoplevel/dummytoplevel_inst/xtea0/d_in_ready \
sim:/tb_dummytoplevel/dummytoplevel_inst/xtea0/d_in \
sim:/tb_dummytoplevel/dummytoplevel_inst/xtea0/key \
sim:/tb_dummytoplevel/dummytoplevel_inst/xtea0/clk \
sim:/tb_dummytoplevel/dummytoplevel_inst/xtea0/mode \
sim:/tb_dummytoplevel/dummytoplevel_inst/xtea0/d_out \
sim:/tb_dummytoplevel/dummytoplevel_inst/xtea0/d_out_ready
run 50ms