Thinking of a "60%" inspired minimalist keyboard without any post-1980 keys, with
Ctrl in the correct location and no caps lock, alt, windoze keys etc.  Might consider
to fill in the empty spaces around the space bar with some extra keys.

<img src="https://github.com/eshazen/z80system/blob/master/docs/kb_example.png" width=600>

Here is a nice python tool which more-or-less handles transition from
the online keyboard-layout-editor.com to KiCAD.  There are a few bugs,
but overall it does a reasonable job:

* https://github.com/jeroen94704/klepcbgen

Thinking to make a PCB with key switches and diodes only and a mezzanine card
site for the decoder.  

Decoder options (most practical first):

* Arduino Pro Mini or bare ATMega328
* <a href="https://github.com/eshazen/z80system/blob/master/docs/CDP1871A.pdf">Intersil CDP1871A</a>.   These are very hard to obtain now, and have parallel output
* KR-9600 (aka AY5-3600-PRO as used in the Apple II and others).  More or less available.
* 
Finally, period-correct microcontrollers:

* Z80:  Minimum system would be Z80, RAM (6116), EEPROM (28C16), 8255 (I/O).  Serial output would be bit-banged.
* 80C51 (actually e.g. AT89C51RB2-3CSUM with flash) or even an original 87C51 with UV EPROM.
