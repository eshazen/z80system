rm -f *.cf
rm -f *.ghw
ghdl -a PLDworld/part1.vhd
ghdl -a PLDworld/part2.vhd
ghdl -a PLDworld/part3.vhd
ghdl -a jkff.vhd
ghdl -a horiz.vhd
ghdl -a horiz_tb.vhd
ghdl -e horiz_tb
ghdl -r horiz_tb --stop-time=2000us --wave=waves.ghw
