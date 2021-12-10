#!/bin/bash
#
# load 63K IDE CP/M with UMON
# use port B
#
julia ./load_scm.jl zout/hexloadb.hex 
./send_hex -s zout/umon_8100H.hex
./send_hex -s zout/cbios_hd.hex
./send_hex -s ../CPM_OS/zout/cpm_63.hex
./send_hex -s ../ZCPR2/zcpr.hex
./send_hex -s zout/putsys.hex
