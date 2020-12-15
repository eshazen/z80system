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
Targeting at least 24x80 or greater VGA text with 640x480 pixel resolution.  Eventually would like an in-period solution, maybe an MC6845.  First version will use a Basys-3 FPGA board with this opencores VHDL code:  https://opencores.org/projects/interface_vga80x40.  I bought a 5.7 in 640x480 LCD:  <a href="https://www.ebay.com/itm/5-7-LCD-Touchscreen-Display-640x480-OSD644803-6UFLWB-VGG644803-6UFLWB/112554850427?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2057872.m2749.l2649">eBay</a>.  It has an annoying 0.5mm pitch flexi connector so I made a breakout board:

<img src=https://github.com/eshazen/z80system/blob/master/pictures/screen_boardH.jpg width=300>
