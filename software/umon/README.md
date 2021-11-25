# UMON monitor

This is a very simple Z80 command line debugger/monitor used during
the bring-up of the calculator.  It might be useful for other purposes.
It is certainly full of bugs!

command (arguments)  |   description
-------------------  |   -----------
`d <addr> <count>      ` |   dump memory
`e <addr> <dd> <dd>... ` |   edit up to 16 bytes in memory
`o <addr> <val>        ` |   output <val> to port <addr>
`z <val>               ` |   set port zero value bits 0-6
`i <addr>              ` |   input from <addr> and display
`g <addr>              ` |   goto addr
`a <val1> <val2>       ` |   hex Arithmetic
`m <adr1> <adr2> <num> ` |   memory compare
`p <adr1> <adr2> <num> ` |   memory copy
`b <addr>              ` |   set breakpoint at <addr>
`c                     ` |   continue from breakpoint
`l                     ` |   binary load
`r                     ` |   repeat last command

Build using "make base=8100H" e.g. to build for origin 8100H.  This
results in the monitor is built with origin `8100H` with stack growing
down from the origin.  The monitor is small (1k or so).

This is a "portable" version of the monitor developed to debug my
retro-25 calculators, with calculator-specific versions removed, and
the serial I/O code moved to a separate file.

# CP/M CBIOS

@cbios_hd