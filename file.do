vsim -gui work.xtea

# Resume macro file
onbreak {resume}
# Menghapus library yang telah dibuat jika ada
if [file exists work] {
vdel -all
}
# Membuat library
vlib work

vcom C:/tubes_sisdig/xtea.vhd

add wave -position insertpoint  \
sim:/xtea/d_in_ready \
sim:/xtea/d_in \
sim:/xtea/key \
sim:/xtea/clk \
sim:/xtea/mode \
sim:/xtea/d_out \
sim:/xtea/d_out_ready \
sim:/xtea/v1 \
sim:/xtea/v0 \
sim:/xtea/sum \
sim:/xtea/i \
sim:/xtea/s \
sim:/xtea/zero32
force -freeze sim:/xtea/mode 0 0
force -freeze sim:/xtea/key 01110000011000010111001101110011011101110110111101110010011001000011000100110010001100110011010000110101001101100011011100111000 0
force -freeze sim:/xtea/d_in 0101001101100011011100100111010001001101011100110110011100101110 0
force -freeze sim:/xtea/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/xtea/d_in_ready 0 0
run 500
force -freeze sim:/xtea/d_in_ready 1 0
run
force -freeze sim:/xtea/d_in_ready 0 0
run 6500
force -freeze sim:/xtea/mode 1 0
force -freeze sim:/xtea/key [examine sim:/xtea/key] 0
force -freeze sim:/xtea/d_in [examine sim:/xtea/d_out]  0
force -freeze sim:/xtea/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/xtea/d_in_ready 0 0
run 500
force -freeze sim:/xtea/d_in_ready 1 0
run
force -freeze sim:/xtea/d_in_ready 0 0
run 7000
