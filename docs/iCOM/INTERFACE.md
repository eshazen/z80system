# ICOM interface notes

## Command Interface

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
