#!/bin/bash
#
julia ./start_hexload.jl 
sleep 0.1
julia ./load_hex.jl zout/umon_8100H.hex
