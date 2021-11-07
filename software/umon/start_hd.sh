#!/bin/bash
#
# load 63K IDE CP/M with UMON
#
julia ./load_scm.jl zout/hexload.hex 
julia ./start_hexload.jl 
julia load_hex.jl zout/umon_8100H.hex
julia ./start_hexload.jl 
julia load_hex.jl zout/cbios_hd.hex
julia ./start_hexload.jl 
julia load_hex.jl ../CPM_OS/zout/cpm_63.hex
