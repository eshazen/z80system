open_hw
connect_hw_server
open_hw_target
set_property PROGRAM.FILE top_lcd_pmod.bit [lindex [get_hw_devices] 0]
program_hw_devices [lindex [get_hw_devices] 0]
