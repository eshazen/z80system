#!/bin/bash
#
# make CP/M system disk
#
# delete any old disk
rm -f cpm.dsk
# create empty formatted disk
julia ./make_disk.jl cpm64.dsk
# add in CBIOS
julia ./make_cpm.jl ../umon/zout/cbios_disk.hex cpm64.dsk
# add in CCP, BDOS
julia ./make_cpm.jl zout/cpm_64.hex cpm64.dsk
echo "Disk cpm.dsk is ready"

