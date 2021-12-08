# Minimal 60 Keyboard

This is a KiCAD design for a retro-style minimal 60% keyboard.
Scanning is done by an ATMega128.  Interface connector is the
sparkfun/FTDI 6-pin SIP header, which is intended to provide
either 3.3V or 5V power, Tx, Rx and processor reset.

In addition there is a standard Atmel 2x3 programming header
(but see erratum).

## ECOS / Errata

* J1 (programming connector) is on the wrong side (so if soldered on the bottom where it is accessible the odd/even rows are swapped)

