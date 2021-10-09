all: umon.hex hexload.hex

Z80ASM = /home/hazen/bin/zmac
base=8100H

umon.hex: umon_nobase.asm serial.asm console.asm hex.asm c-link.asm
ifeq ($(base),xxx)
	echo "Missing base=value"
	exit 1
endif
	sed s/UMON_ORIGIN/$(base)/ <umon_nobase.asm >umon_$(base).asm
	$(Z80ASM) umon_$(base).asm

hexload.hex: hexload.asm
	$(Z80ASM) hexload.asm

# umon.hex: umon.bin
#	srec_cat umon.bin -binary -o umon.hex -intel

#umon.bin: umon.asm console.asm hex.asm
#	$(Z80ASM) -l -b umon.asm

clean:
	rm -f *~ *.bin *.hex *.lis *.o
	rm -r zout


