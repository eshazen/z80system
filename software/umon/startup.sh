#!/bin/bash
#
julia ../cftest/load_to_scm.jl zout/hexload.hex 
julia ./start_hexload.jl 
julia load_hex.jl zout/umon_8100H.hex
