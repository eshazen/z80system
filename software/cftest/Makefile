
Z80ASM=/home/hazen/work/z88dk/bin/z80asm

all: CFDriver.hex

clean:
	rm -f *.bin *.hex *.lis *.o *.sym *.map

%.hex : %.bin
	srec_cat $< -binary -offset 0x8000 -o $@ -intel

%.bin : %.asm
	$(Z80ASM) -mz80 -r0x8000 -b -l -s -m $<
