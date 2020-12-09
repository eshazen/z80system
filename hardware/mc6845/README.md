# MC6845 Video Board

Text-only video board, nominally VGA resolution (640x480).
Memory now 512kx8 which is enough for (8) 640x480 bitmaps
or 30x80 character cells of 8x16 pixels.

```
Text mode:
  MA0-MA11 to RAM A0-A11 (to address up to 4k characters)
  RA0-RA3 to char gen (for 16 rows per character)
Bitmap mode:
  MA0-MA11 to RAM A0-A11 (to address up to 4k cells)
  RA0-RA3 to RAM A12-A15 (to address 16 rows)
```

The upper 3 address bits would probably just be a CPU-controlled latch.

This implies a CPU addressing scheme which can address a full 64K of
RAM somehow.

Current design has a 16-bit CPU address latch and Arduino
footprint.  Maybe this should be moved to an Arduino shield?

Todo:

- finish the decoding logic for a Z80 bus interface
- add bypass caps
- figure out a bitmap mode
   - bypass the character generator
   - route RA0-RA3 to the RAM

