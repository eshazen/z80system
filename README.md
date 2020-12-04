# z80system
Yet another home-brew z80 system

NOTE:  Nothing here is done/working yet!

I'm starting (slowly, for now) on a home-brew Z80 general-purpose computer.  I'm not very interested in the 8-bit gaming or retro-Apple-Amiga world, but basically a re-creation of my development system in 1984 or so.  It had a Z80B, I think 192k or 256k RAM, a bunch of EEPROM configured as a read-only disk, 24x80 video with attributes or color and a nice double-density floppy disk interface with dual 3.5" floppy drives.  I'd like to enhance it with decent-quality graphics, maybe 640x480 or 800x600 16-color (from a palette).  Not sure yet about whether I want to fuss with a real floppy system.  If it could be portable, as in a laptop, that would be cool.

## CPU

This will be derived from my https://github.com/eshazen/retro-25 project.  Tentative feature list:

* Z80 CPU, DART, PIO
* AT28C256 32Kx8 EEPROM
* AS6C4008 512Kx8 SRAM
* Clocks: 8MHz osc /2 => 4MHz CPU clock or maybe faster
* Clocks: 1.8432MHz / 12 => 16X 9600 clock
* MAX232 or equiv; DB-25 for RS-232

## Video
Looking at various options.  For starters I think I'm going to cheat and use an FPGA, probably the Digilent CMOD A7: https://reference.digilentinc.com/reference/programmable-logic/cmod-a7

This can driver either a VGA monitor or in principle a bare RGB LCD.

Other appealing options are an MC6845 CRTC or bare TTL logic.
