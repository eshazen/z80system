# LCD/VGA adapter for Digilent CMOD A7

This is a new RC2014 board which provides VGA display.
It can connect either to a surplus VGA LCD via flex connector
or standard VGA.

RC2014 interface via serial, with 6 pin connector for
a serial keyboard.

A possible PS/2 keyboard interface.

_Rev A Errors_

The VGA connector overlaps several resistors and C2.  This is salvageable
by either cutting away part of the VGA or mounting the other parts on the back.

It turns out that the CMOD-A7 has a built-in oscillator, so the oscillator module
and 3.3V regulator aren't needed at all, so I left them out.

Also it is *highly recommended* to put a Schottky diode in series with the power
to the CMOD-A7 so you can freely use either USB power or RC2014 power.
Plus the CMOD-A7 can take 5V directly.  I cut the trace to pin 24 of the CMOD
and soldered a diode from 5V to this pin.  
