
# Development log re-start 2024

**2024-08-14** Updating z88dk per:  https://github.com/z88dk/z88dk/wiki/installation

This fails.  Start over:

    cd ~/work
	rm -rf z88dk
	git clone  --recursive  https://github.com/z88dk/z88dk.git
	cd z88dk
    export BUILD_SDCC=1
    export BUILD_SDCC_HTTP=1
    chmod 777 build.sh
    ./build.sh
	
(long build).  Should probably have captured output...
Ends with:

    curl: (7) Failed to connect to nightly.z88dk.org port 80 after 1485 ms: No route to host
    make: *** [Makefile:93: zsdcc_r14648_src.tar.gz] Error 7

Seems that nightly.z88dk.org is offline and this has happened before.
Registered for the [forum](https://www.z88dk.org/forum/) and posted a message.
Awaiting moderation.

## CP/M Sizing review

Online [table](https://static.wixstatic.com/media/ce503a_ae4b9b2a827bfac2b4486715b647b7e3.gif).
from Oscar Vermeulen is **wrong**!

In our CBIOS we have:

	; for standard 20k system...
    ;ccp:	equ	03400h		;base of ccp
    ;bdos:	equ	03C06h		;bdos entry
    ;bios:	equ	04A00h		;base of bios

    ;;; this CBIOS requires 63k max so enddat < ffff
    MEM:    EQU 63      ;CP/M system size in K
        
    ccp:    equ (MEM-7)*1024
    bdos:   equ ccp+0806h
    bios:   equ ccp+1600h
	
My attempt at a map (offset from 64k to 20k is B000H)

    20k ref   64k   63k  
    FFFF      FFFF          top of RAM
    4A00      FA00  F600    BIOS
    3C06      EE06  E806    BDOS
    3400      E400  E000    CCP

Our cbios_hd.asm works for a "63K" syste with 330 bytes to spare.
The cbios_combo.asm requires 62K.
