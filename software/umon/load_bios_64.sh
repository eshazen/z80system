#!/bin/bash
#
julia ./start_hexload.jl 
julia load_hex.jl zout/cbios_disk.hex
julia ./start_hexload.jl 
julia load_hex.jl ../CPM_OS/zout/cpm_64.hex

