#!/bin/bash
#
julia ./load_scm.jl zout/hexload.hex 
julia ./start_hexload.jl 
julia load_hex.jl zout/umon_8100H.hex
julia ./start_hexload.jl 
julia load_hex.jl zout/cbios_disk.hex
julia ./start_hexload.jl 
julia load_hex.jl ../CPM_OS/zout/cpm_64.hex
