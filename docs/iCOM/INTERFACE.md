# ICOM interface notes

## 2023-09-04

Assembled the [8255 interface](https://github.com/eshazen/z80system/tree/master/hardware/arduino_icom_8255) PCB
(Arduino shield).  Somehow our Arduino shield footprint is mirrored (!) so the component side faces
the Arduino.  It works but no way the ribbon cables will fit, so need to solder the headers
on the back and flip the ribbon cable parity.  Got stuff from EDF for this.

Ordered a set of new caps for the power supply.  Could *probably* power the thing up using
the siglent supply.

Wrote an [Arduino sketch](https://github.com/eshazen/z80system/tree/master/software/arduino/test_8255)
using the Arduino shield which allows read/write to 8255 registers.
Plan is to add iCOM functions to read/write sectors, etc.

Forked [z80pack](https://github.com/eshazen/z80pack) at 1.37 release.

If the drives seem to work a possible plan is to create a minimal CP/M
BIOS in z80pack which can talk to the drives over a USB/serial link.
Having disk access at 115.2k baud would probably be fine.


## 2023-09-01

Someone's CBIOS [link](http://cini.classiccmp.org/pdf/iCOM/iCOM%20CBIOS%20CPM%202.2%20(071380).pdf) does it this way:

    STUP:   ; setup track/sector on output
		    MVI A,21H      ; issue set unit/sector
		    CALL LOOP
		    ;
    LOOP:   OUT CNTRL
		    SUB A
		    OUT CNTRL
	LOOP1:  IN DATAI
		    RAR
		    JC LOOP1
		    RET
		  
So it seems likely we can just output a command on the 82C55 and then
output zero, and all will be happy.

**BUT** the data is all inverted, so we have to take care of that
in the software.

To read the data, they do this:

	        MVI C,128
			LHLD DMAADR

    RDLUP:  MVI A,40H    ; request a byte
	        OUT CNTRL
			IN DATAI
			MOV M,A
			INX H
			MVI A,41H    ; increment
			CALL LOOP
			DCR C
			JNZ RDLUP
			RET
