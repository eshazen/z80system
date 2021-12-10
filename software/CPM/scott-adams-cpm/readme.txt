
Scott Adams Adventures for CP/M

From the banner text:

  Scott Adams (c)'79
    CP/M Conversion by Russ Wetmore
  * ADVENTURE * (Version:8.4c)

The interpreter ADVENTUR.COM has been checked on CP/M 2.2 and CP/M 3.0
and is known to have a problem under emulation where the Z-80 emulation
is not sufficiently close to the real hardware.  In particular, the
routine to generate random number from 1-100 is implemented thusly:

PERCENT:
  LD A,R
  JP M, PERCENT
  JR Z, PERCENT
  CP 0x65
  RET M
  LD A, 0x32
  RET

The R register is the DRAM refresh counter.  On a real Z-80, it 
increments every M1 cycle, and every instruction has one or more
M1 cycles.  Some Z-80 emulators do not increment this register
in the fashion of the genuine hardware.  They may support LD A,R
and LD R,A, but not the behind-the-scenes incrementing.  A processor
reset puts a 0 into R, so if the emulator isn't bumping the number,
it just stays 0, and this routine loops endlessly.  The symptom is
that the game appears to start normally, right up to the "press <CR>"
prompt after loading the game data and as far as printing the initial
room description, but the game hangs before asking the player "Tell
me what to do?"  

Included is a test program, RNDTST.ASM compiled to RNDTST.COM.  It
reads the R register and displays the raw contents as a decimal
number.  If the results don't change at all (typically always zero)
or are above 128 all the time, then this system will not be able to
run ADVENTUR.COM.

Emulators tested and known to work:
  Simh altairz80 V4.0-0 Beta (after 17-Dec-2016)
  RunCPM 5.5 (after 07-Jun-2021)
  VICE x128 Version 2.4*

Emulators tested and known not to work:
  simcpm010
  Simh altairz80 V3.9-0
  EMUZ80 for Raspberry Pi (14-Nov-2016 and prior)
  RunCPM version 5.4 

* VICE x128 Version 2.4 did work, but it mattered which CP/M disk was
tested as the disk image cpm.system.6228129311.d64 worked while
another image on zimmers.net, cpm.system.622-3282252.d64, hung in
a different place, when taking the player's first input.  This is
done with a CP/M BDOS call to function 10, C_READSTR - Buffered
console input.

The entire list of required BDOS calls is:

  BDOS function  2 (C_WRITE) - Console output
  BDOS function 10 (C_READSTR) - Buffered console input
  BDOS function 15 (F_OPEN) - Open file
  BDOS function 16 (F_CLOSE) - Close file
  BDOS function 20 (F_READ) - read next record
  BDOS function 21 (F_WRITE) - write next record

It seems that there is some issue with that specific version of CP/M
and reading console input.  

