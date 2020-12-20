#
# generate IP products
#
create_project -in_memory -part xc7a35tcpg236-1
read_ip ../ip_cores/clk_vga/clk_vga.xci
set_property target_language VHDL [current_project]
generate_target all [get_ips clk_vga]
