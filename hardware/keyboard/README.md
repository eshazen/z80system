Thinking of a "60%" inspired minimalist keyboard without any post-1980 keys.



Here is a nice python tool which more-or-less handles transition from
the online keyboard-layout-editor.com to KiCAD.  There are a few bugs,
but overall it does a reasonable job:

* https://github.com/jeroen94704/klepcbgen

Depating how to readout the keyboard.  For a "period" implementation,
could scan directly with the Z80.  This would be OK but would require
a timer interrupt or something to behave well.

The CDP1871A looks like a possible option, though the ASCII code is
quite archaic and a few things like "~" and "`" are missing entirely!
A LUT or a bit of code could fix this easily though.

