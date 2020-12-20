#
set_part xc7a35tcpg236-1
# read sources
read_xdc  ../src/top_lcd_pmod.xdc
read_vhdl ../src/top_lcd_pmod.vhd
read_vhdl ../src/mem_font.vhd
read_vhdl ../src/vga80x40_col1fixed.vhd
read_vhdl ../src/ctrm.vhd
read_vhdl ../src/losr.vhd
# add ip
read_ip ../ip_cores/clk_vga/clk_vga.xci
synth_ip [get_ips clk_vga]


