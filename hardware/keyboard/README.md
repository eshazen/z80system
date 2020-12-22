Thinking of a "60%" inspired minimalist keyboard without any post-1980 keys, with
Ctrl in the correct location and no caps lock, alt, windoze keys etc.  Might consider
to fill in the empty spaces around the space bar with some extra keys.

<img src="https://github.com/eshazen/z80system/blob/master/docs/kb_example.png" width=600>

Here is a nice python tool which more-or-less handles transition from
the online keyboard-layout-editor.com to KiCAD.  There are a few bugs,
but overall it does a reasonable job:

* https://github.com/jeroen94704/klepcbgen

For decoding, I like the classic 
<a href="https://github.com/eshazen/z80system/blob/master/docs/CDP1871A.pdf">Intersil CDP1871A</a>.  
The ASCII code is a bit funny
but that could be fixed with a LUT.  Also, it needs a clock in the sub-MHz range and
has parallel output.  

