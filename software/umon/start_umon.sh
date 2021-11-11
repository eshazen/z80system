#!/bin/bash
#
julia ./load_scm.jl zout/hexload.hex 
sleep 0.1
./send_hex -s zout/umon_8100H.hex
