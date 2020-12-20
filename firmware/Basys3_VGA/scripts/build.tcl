#
# read_xdc src/Nexys4_Master.xdc
# read_vhdl src/top.vhd
synth_design -top top_lcd_pmod
opt_design 
place_design 
route_design
write_bitstream -force top_lcd_pmod.bit
