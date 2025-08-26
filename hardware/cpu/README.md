# CPU board

Working in 'develop' as of 2025-08-26

Some thoughts:

* Change design rules to 6/6 mil so 2 tracks between 100 mil pads (done)
* Expansion connector should have more GNDs.  So maybe 50 pins (done)
* Should the buses be buffered?  Expansion buses? (nope)
* Integrated IDE interface?  Ditch the PIO for 8255 for this?
* Simpler baud rate generator?
* Ensure SIO pinout compatible with FTDI module/cable
 (or integrate FTDI modules on board)
 
Looking at IDE.  See for example [RC2014
IDE](https://rc2014.co.uk/modules/ide-hard-drive-module/).  This needs
16 data + 8 control signals.  Z80 PIO doesn't provide this!  However,
can operate with 8 bit data so maybe it's ok?