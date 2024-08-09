# arduino_icom_8255

This is an Arduino shield with an 82C55 Programmable Peripheral Interface (PPI)
chip.  20 and 26-pin ribbon cable pinouts match (hopefully) the iCOM interface.

Unfortunately I put the Arduino shield footprint on the wrong side (front)
while it should be on the back, so the board has to mount component-side
down on the Arduino.  This is fine with tall headers, but no good for the
ribbon cables, so will need to put headers on the back and do the old parity
flip thing with wire-wrap connectors.
