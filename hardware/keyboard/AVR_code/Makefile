#
# makefile for BlinkyPovAvr code
#

MCU = atmega8

F_OSC = 1000000

CFLAGS = -std=c99 -g -Os -mmcu=$(MCU) -DF_CPU=$(F_OSC)

LDFLAGS = -Wl,-Map=$(<:.o=.map),--cref -mmcu=$(MCU)

DUDEPORT  = -c avrispmkII -P usb
DUDEMCU = m8
AVRDUDE  = avrdude $(DUDEPORT) -p $(DUDEMCU) -y -u 

objects = new.o

all: new.hex

clean:
	rm -f *.o *~ *.hex *.elf *.map *.lst

flash: new.hex
	sudo $(AVRDUDE) -U flash:w:$^:i

list:
	avr-objdump -h -S new.elf > new.lst
	avr-size --common -d new.elf

$(objects): %.o: %.c
	avr-gcc -c $(CFLAGS) $< -o $@

new.elf: new.o 
	avr-gcc $(LDFLAGS) new.o -o $@

new.hex: new.elf
	avr-objcopy -j .text -j .data -O ihex $< $@
	echo "'make flash' to program"
