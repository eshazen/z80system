#
set_part xc7a35tcpg236-1
# read sources
read_xdc  ../src/top_constr.xdc
read_vhdl ../src/top.vhd
read_vhdl ../src/mem_text.vhd
read_vhdl ../src/mem_font.vhd
read_vhdl ../src/vga80x40_col1fixed.vhd
read_vhdl ../src/ctrm.vhd
read_vhdl ../src/losr.vhd
# add ip
read_ip ../ip_cores/clk_vga/clk_vga.xci
set_property target_language VHDL [current_project]
generate_target all [get_ips clk_vga]
synth_ip [get_ips clk_vga]


