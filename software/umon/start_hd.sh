#!/bin/bash
#
# load 63K IDE CP/M with UMON
#
# assumes UMON is running from ROM
julia ./load_umon.jl zout/hexload.hex 
# ./send_hex -s zout/umon_8100H.hex        # don't need to load UMON
./send_hex -s zout/cbios_hd.hex
./send_hex -s ../CPM_OS/zout/cpm_63.hex
./send_hex -s zout/putsys.hex
