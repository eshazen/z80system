
EXECS = zout/umon_8100H.hex zout/hexload.hex send_hex simple_server \
	com2db

all: $(EXECS)

Z80ASM = /home/hazen/bin/zmac
base=8100H

CFLAGS = -ggdb -O0
CPPFLAGS = -ggdb -O0

zout/umon_8100H.hex: umon_nobase.asm serial.asm console.asm hex.asm c-link.asm
ifeq ($(base),xxx)
echo "Missing base=value"
exit 1
endif
	sed s/UMON_ORIGIN/$(base)/ <umon_nobase.asm >umon_$(base).asm
	$(Z80ASM) umon_$(base).asm

zout/hexload.hex: hexload.asm
	$(Z80ASM) hexload.asm

clean:
	rm -f *~ *.bin *.hex *.lis *.o
	rm -r $(EXECS)

send_hex.o: send_hex.cc serial_command.hh

serial_command.o: serial_command.cc serial_command.hh

screen_test.o: screen_test.cc serial_command.hh

screen_test: screen_test.o serial_command.o
	g++ -o screen_test screen_test.o serial_command.o -lserial

send_hex: send_hex.o serial_command.o
	g++ -o send_hex send_hex.o serial_command.o -lserial

sio_server.o: sio_server.c sio_server.h

simple_server.o: simple_server.c sio_server.h

simple_server: simple_server.o sio_server.o
	cc -o simple_server simple_server.o sio_server.o

com2db: com2db.o
	cc -o com2db com2db.o

com2db.o: com2db.c
