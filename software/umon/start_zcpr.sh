#!/bin/bash
#
# load 63K IDE CP/M with UMON
# use port A
#
julia ./load_umon.jl zout/hexload.hex 
# ./send_hex -s zout/umon_8100H.hex
./send_hex -s zout/cbios_hd.hex
./send_hex -s ../CPM_OS/zout/cpm_63.hex
./send_hex -s zcpr.hex
./send_hex -s zout/putsys.hex
