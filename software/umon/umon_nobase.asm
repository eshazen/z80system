;;;
;;; simple Z80 monitor
;;;
;;; d <addr> <count>           dump memory
;;; e <addr> <dd> <dd>...      edit up to 16 bytes in memory
;;; o <port> <val>             output <val> to <port>
;;; i <port>                   input from <port> and display
;;; g <addr>                   goto address (restore regs)
;;; b <addr>                   set breakpoint (currently 3-byte call)
;;; a <val1> <val2>            hex Arithmetic
;;; c                          continue from breakpoint
;;; c <addr>                   continue, set new breakpoint
;;; m <start> <end> <size>     memory region compare
;;; p <start> <end> <size>     memory region copy
;;; l			       binary load
;;; f <n>                      restore regs, call function <n> from jump table       
;;; r                          display stored regs
;;; r <reg> <val>              edit stored regs
;;; x <lba_h> <lba_l> <addr>   read sector
;;; y <lba_h> <lba_l> <addr>   write sector
;;; w <start> <size> <patt>    zero or pattern-fill memory (size in WORDS)
;;; 
; 	org	08100H
 	org	UMON_ORIGIN	

stak:	equ	$		;stack grows down from start

;;; jump table for useful entry points
jump_table:	
	;;                    fn_no   offset    description
	jmp	main		;00   0000	cold start
	jmp	save_state	;01   0003	save state (breakpoint)
	jmp	getc		;02   0006	read serial input to A
	jmp	putc		;03   0009	output serial from A
	jmp	crlf		;04   000c	output CR/LF
	jmp	puts		;05   000f	output string from HL
	jmp	phex2		;06   0012	output hex byte from A
	jmp	phex4		;07   0015	output hex word from HL

	jmp IDE_Initialize      ;08   0018	setup PPI, reset drive
	jmp IDE_Byte_Read       ;09   001b	read byte from reg C to A
	jmp IDE_Word_Read       ;0a   001e	read word from reg C to HL
	jmp IDE_Byte_Write      ;0b   0021	write data in A to reg C (uses B)
	jmp IDE_Word_Write      ;0c   0024	write data in HL to reg C (uses B)
	jmp IDE_Get_Status      ;0d   0027	read status register to A
	jmp IDE_Wait_Ready      ;0e   002a	wait for busy=0, ready=1
	jmp IDE_Wait_DRQ        ;0f   002d	wait for DRQ=1
	jmp IDE_Do_Cmd	        ;10   0030	issue a command from A (use b, c)
	jmp IDE_Setup_LBA       ;11   0033	set LBA from DEHL
	jmp IDE_Read_ID	        ;12   0036	Read 512 byte ID to (DE)
	jmp IDE_Read_Sector	;13   0039	Read sector from LBA=DEHL to IX
	jmp IDE_Write_Sector    ;14   003c      Write sector from IX to LBA=DEHL

;;; ---- data area ----

;;; save CPU state coming from extrnal prog
savein:	db	0,0,0		;instruction overwritten by breakpoint
savead:	dw	0		;address of breakpoint
savesp:	dw	0		;caller's stack pointer

;;; saved registers
saviy:	dw	0
savix:	dw	0

savhlp:	dw	0
savdep:	dw	0
savbcp:	dw	0
savafp:	dw	0
	
savhl:	dw	0
savde:	dw	0
savbc:	dw	0
savaf:	dw	0
	
savetop: equ	$
	
lastc:	db	0		;last command byte

maxarg:	equ	18		;maximum number of arguments
argc:	db	0
	
argv:	rept	maxarg*2
	dw	0
	endm
	
iargv:	rept	maxarg*2
	dw	0
	endm

	INCLUDE "serial.asm"
	INCLUDE "console.asm"
	INCLUDE "hex.asm"
	INCLUDE "strings.asm"
	INCLUDE "c-link.asm"
	INCLUDE "disk_ide.asm"

banner:	db	"UMON-P v0.8 ORG ",0
error:	db	"ERROR",0
	
usage:  db      "h                     print this help", 13, 10
        db      "d <addr> <count>      dump memory", 13, 10
        db      "e <addr> <dd> <dd>... edit up to 16 bytes in memory", 13, 10
        db      "o <addr> <val>        output <val> to port <addr>", 13, 10
        db      "i <addr>              input from <addr> and display", 13, 10
        db      "g <addr>              goto addr", 13, 10
        db      "b <addr>              set breakpoint (currently 3-byte call)", 13, 10
        db      "a <val1> <val2>       hex Arithmetic", 13, 10
	db	"m <ad1> <ad2> <n>     memory compare", 13, 10
	db	"p <ad1> <ad2> <n>     memory copy", 13, 10
        db      "c                     continue from breakpoint", 13, 10
        db      "l                     binary load", 13, 10
	db	"f <n>                 call function", 13, 10
        db      "r [<reg> <val>]       display/edit regs",13,10
	db	"w <addr> <count> <p>  fill memory with wordz",13,10
	db	"x <LH> <LL> <adr> [n] read disk sector(s)",13,10
	db	"y <LH> <LL> <adr> [n] write disk sector",13,10
	db	0

main:	ld	sp,stak
	;; set RC2014 memory map to all RAM
	out	(30h),a		;reset memory page thing (back to ROM)
	out	(38h),a		;increment memory page thing (all RAM)
	call	io_init
	ld	hl,banner
	call	puts
	ld	hl,stak
	call	phex4
	call	space
	ld	hl,umontop
	call	phex4
	call	crlf
	
loop:	ld	a,'>'		;prompt
	call	putc

	ld	hl,buff
	ld	bc,bend-buff	; maximum size
	call	gets

;;; commands here which don't want tokenizer to be run

;;; parse string into tokens at argc / argv
	ld	hl,buff
	ld	de,argv
	ld	b,maxarg
	call	strtok	
	ld	a,c
	ld	(argc),a

	;; convert tokens to integers
	ld	hl,argv
	ld	de,iargv
	ld	b,a
	call	cvint

	ld	hl,buff		;parse command character
	ld	a,(hl)
	ld	(lastc),a	;save for possible repeat

	cp	a,'D'		;dump memory
	jz	dump

	cp	a,'H'
	jz	help

	cp	a,'A'
	jz	arith

	cp	a,'E'
	jz	edit

	cp	a,'B'
	jz	brkpt

	cp	a,'C'
	jz	continu

	cp	a,'G'
	jz	goto

	cp	a,'L'
	jz	binary
	
	cp	a,'O'
	jz	output

	cp	a,'I'
	jz	input

	cp	a,'M'
	jz	memcmp

	cp	a,'P'
	jz	memcpy

	cp	a,'R'
	jz	edit_regs

	cp	a,'F'
	jz	call_func

	cp	a,'X'
	jz	read_sect

	cp	a,'Y'
	jz	writ_sect

	cp	a,'W'
	jz	memzer

errz:	ld	hl,error
	call	puts
	call	crlf
	
	jp	loop

quit:	jp	0

help:	ld	hl,usage
	call	puts
	jp	loop

;;; memory pattern/zero
memzer:
	ld	hl,(iargv+2)	;address
	ld	bc,(iargv+4)	;count
	ld	de,(iargv+6)	;pattern
	;; check for letter 'P' for pattern
	ld	ix,(argv+6)	;pointer to pattern
	ld	a,(ix)
	cp	a,'P'
	jr	z,mempat
	;; just fill with value in DE
memfil:	push	hl		;save start address
	ld	(hl),e		;store 16-bit value in first word
	inc	hl
	ld	(hl),d
	inc	hl
	pop	de		;restore start address
	ex	de,hl		;now hl=start, de=next
	ldir
	jp	loop
	
	;; fill memory with counter value
mempat:	ld	de,0
memp1:	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	inc	de
	dec	bc
	ld	a,b
	or	c
	jr	nz,memp1

	jp	loop
	
	

;;; write sector(s)
writ_sect:
	ld	a,(argc)
	ld	b,1		;default count
	cp	4		;count = 1
	jr	z,wsrun
	cp	5		;count specified
	jp	nz,errz
	ld	a,(iargv+8)	;count
	ld	b,a

	;; write B sectors, incrementing LBA in DEHL
wsrun:
	ld	de,(iargv+2)
	ld	hl,(iargv+4)
	ld	ix,(iargv+6)
	
wsloup:	
	push	hl
	push	bc
	push	de
	
	call	IDE_Write_Sector
	push	de		;after call next locn is in DE
	pop	ix		;copy to IX
	
	pop	de
	pop	bc
	pop	hl

	;; increment lba
	ld	a,h		;check for HL=FFFF
	and	l
	cp	0ffh
	inc	hl
	jr	nz,nolbcw

	inc	de

	;; delay
	push	hl
	ld	hl,0
dilly:	dec	hl
	ld	a,h
	or	l
	jr	nz,dilly
	pop	hl

nolbcw:	djnz	wsloup

	jp	loop

	
;;; read sector(s)
read_sect:
	ld	a,(argc)
	ld	b,1		;default count
	cp	4		;count = 1
	jr	z,rsrun
	cp	5		;count specified
	jp	nz,errz
	ld	a,(iargv+8)	;count
	ld	b,a

	;; read B sectors, incrementing LBA in DEHL
rsrun:
	ld	de,(iargv+2)
	ld	hl,(iargv+4)
	ld	ix,(iargv+6)
	
rsloup:	
	push	hl
	push	bc
	push	de
	
	call	IDE_Read_Sector
	push	de		;after call next locn is in DE
	pop	ix		;copy to IX
	
	pop	de
	pop	bc
	pop	hl

	;; increment lba
	ld	a,h		;check for HL=FFFF
	and	l
	cp	0ffh
	inc	hl
	jr	nz,nolbcy

	inc	de
nolbcy:	djnz	rsloup

	jp	loop

;;; call function from jump table, first restoring regs
call_func:
	ld	a,(argc)	;check for value
	cp	2
	jp	nz,errz
	ld	hl,save_state	;user returns to here
	push	hl
	ld	a,(iargv+2)	;get function code
	ld	e,a		;to DE
	ld	d,0
	ld	hl,jump_table
	add	hl,de		;multiply by 3
	add	hl,de
	add	hl,de
	jp	gother		;go restore state, call (hl)

;;; edit/display registers in memory (at 'saveiy')
;;; no args = display all regs
;;; first arg is register name:  AF, BC, DE, HL, A', B', D', H', IX, IY
;;; second arg is 16-bit value
edit_regs:
	ld	a,(argc)	;get for two args
	cp	3
	jp	nz,view_regs	;nope, just display regs
	;; search for register name as 2nd argument
	ld	hl,(argv+2)	;pointer to register name from command line
	ld	d,(hl)		;get first char
	inc	hl
	ld	e,(hl)	      ;get 2nd char
	ld	hl,reg_names	;list of names for compare
	ld	b,10		;number of register name bytes
	
	;; lookup 16-bit register name from list
regnam:
	ld	a,d		;get first char
	cp	(hl)		;compare it
	inc	hl		;advance ptr (no flags changed)
	jr	nz,regnm	;didn't match

	ld	a,e		;get 2nd char
	cp	(hl)		;compare
	inc	hl
	jr	z,regfound
	
regnxt:	djnz	regnam
	
	jp	badreg

regnm:	inc	hl		;skip 2nd char
	jr	regnxt		;go loop

	;; reg name not found
	;; display it
badreg:	ld	hl,badreg_msg
	call	puts
	ld	hl,(argv+2)
	ld	a,''''
	call	putc
	ld	a,(hl)
	call	putc
	inc	hl
	ld	a,(hl)
	call	putc
	ld	a,''''
	call	putc
	call	crlf
	jp	loop

badreg_msg:	db 'BAD REG',13,10,0

view_regs:
	call	display_regs
	jp	loop

;;; register name at HL-2 matches
regfound:	
	dec	hl
	dec	hl
	or	a		;clear CY
	ld	de,reg_names
	sbc	hl,de		;now we have offset into registers stored at saviy
	ld	de,saviy	;offset by two since HL points past match
	add	hl,de		;point to stored reg value
	ld	de,(iargv+4)	;get new value

	ld	(hl),e		;change the stored value
	inc	hl
	ld	(hl),d
	
	jp	loop

reg_names:
	db	'IY', 'IX', 'H''', 'D''', 'B''', 'A''', 'HL', 'DE', 'BC', 'AF'

;;; output to port
output:	ld	a,(iargv+2)
	ld	c,a
	ld	a,(iargv+4)
	out	(c),a
	jp	loop

;;; input from port
input:	ld	a,(iargv+2)
	ld	c,a
	in	a,(c)
	call	phex2
	call	crlf
	jp	loop

	;; continue after breakpoint
	;; check if there is one first
	;; clears breakpoint as part of the process
continu: ld	hl,(savead)
	ld	a,l
	or	h
	jp	z,nobrk		;go if not set
	ld	de,0
	ld	(savead),de	;mark as cleared

	ex	de,hl		;address to HL
	
	;; first restore the instruction saved
	ld	hl,savein
	ldi
	ldi
	ldi

	;; optionally, set a new breakpoint
	ld	a,(argc)
	cp	2
	jr	nz,restore_state

	;; set new breakpoint
	ld	hl,(iargv+2)
	call	brkat
	
	call	phex4
	ld	hl,msgset
	call	puts

	;; restore the machine state
	;; restore stack from (savesp) and ret
restore_state:
	ld	sp,saviy

	pop	iy
	pop	ix

	pop	hl
	pop	de
	pop	bc
	pop	af
	exx
	ex	af,af'
	
	pop	hl
	pop	de
	pop	bc
	pop	af

	ld	sp,(savesp)	;get back caller's stack
	ret			;should to back to BP locn

	
;;; set breakpoint
brkpt:	ld	a,(argc)
	cp	2		;single numeric argument?
	jr	z,brkset

	;; clear breakpoint if set
brkclr:	ld	hl,(savead)
	ld	a,l
	or	h
	jr	z,nobrk		;go if not set

	call	phex4
	ld	hl,msgclr
	call	puts

	ld	hl,(savead)
	ex	de,hl
	ld	hl,savein
	ldi
	ldi
	ldi

	ld	hl,0
	ld	(savead),hl	;erase saved address

	jp	loop

	;; check for breakpoint already set
brkset:	ld	hl,(savead)
	ld	a,h
	or	l
	jr	nz,brkovr	;attempt to overwrite breakpoint

	ld	hl,(iargv+2)	;breakpoint goes here
	call	brkat
	call	phex4
	ld	hl,msgset
	call	puts

	jp	loop

brkat:	
	push	hl		;save locn
	ld	(savead),hl	;set brkpt locn
	ld	de,savein	;save area for 3-byte instruction
	ldi
	ldi
	ldi			;copy 3 bytes
	pop	hl		;get locn back
	push	hl
	ld	(hl),0cdh	;CALL
	inc	hl
	ld	de,save_state	;target for call
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	hl
	ret

brkovr:	ld	hl,msgovr
	call	puts
	jp	loop

nobrk:	ld	hl,msgno
	call	puts
	jp	loop

msgset:	db	' SET', 13, 10, 0
msgno:	db	'NO BKPT', 13, 10, 0
msgclr:	db	' CLEARED', 13, 10, 0
msgovr:	db	'BKPT ALREADY SET CLEAR FIRST', 13, 10, 0


;;; start binary loader
;;; expect binary words (LSB first):
;;;    0x5791, <addr>, <count>
;;; then <count> data bytes
;;; does not jump after, just returns to prompt
;;; if header not seen after a few bytes, bail out
;;;
;;; echo back all received
;;; 
binary:	ld	b,5		;max bad bytes
	;; read chars until 5 received or 0x91 seen
bin1:	call	getc
	call	putc
	cp	0x91		;first magic byte?
	jr	z,bin1a
	djnz	bin1
	jp	errz
	
	;; read chars, skipping repeat 0x91, wait for 0x57
bin1a:	call	getc
	call	putc
	cp	0x91
	jr	z,bin1a
	cp	0x57
	jp	nz,errz
	
	;; get address to hl
	call	getc
	call	putc
	ld	l,a
	call	getc
	call	putc
	ld	h,a
	ld	(iargv),hl
	;; get count to bc
	call	getc
	call	putc
	ld	c,a
	call	getc
	call	putc
	ld	b,a
	ld	(iargv+2),bc
	;; read and store data
bin2:	call	getc
	call	putc
	ld	(hl),a
	inc	hl
	dec	bc
	ld	a,b
	or	c
	jr	nz,bin2

	;; leave addr, count in iargv+2, iargv+4
	;; display them too
	ld	hl,(iargv)
	call	phex4
	call	crlf
	ld	bc,(iargv+2)
	add	hl,bc
	call	phex4
	call	crlf
	jp	loop

;;; jump to 1st arg
goto:	cp	2
	jp	c,errz
	ld	hl,(iargv+2)
	ld	de,showstate
	;; set up the stack:  first, a return address in case user executes a RET
	push	de
	;; now the user specified address from the command line
gother:	push	hl
	ld	(savesp),sp	;save caller's stack pointer
	jp	restore_state

;;; edit values into memory
edit:	ld	a,(argc)
	cp	a,3		;need at least 3 args
	jp	c,errz

	sub	a,2
	ld	b,a		;count of bytes to store

	ld	hl,(iargv+2)	;get address
	ld	ix,iargv+4	;pointer to first data item

eloop:	ld	a,(ix)
	ld	(hl),a
	inc	hl
	inc	ix
	inc	ix
	djnz	eloop
	jp	loop

;;; dump some memory
dump:	ld	a,(argc)
	ld	b,0		;default count = 0/100
	cp	a,3		;
	jr	c,dump1

	;; else > 1 arg, so count specified
	ld	a,(iargv+4)	;second arg
	ld	b,a

dump1:	ld	hl,(iargv+2)	;first arg
	
dump0:	call	hdump

	ld	(iargv+2),hl	;save addr after

	jp	loop

;;; hex dump B bytes from HL
	;; see if we need to print the address
	;; either on 16-byte boundary, or first address
	;; each time we print the address, copy to IX for ascii
hdump:	call	hex_addr	;always print first address
	push	hl
	pop	ix		;address to IX
	jr	bite		;skip the 16-byte test

hdump2:	ld	a,l
	and	0xf
	jr	nz,bite

	call	hex_ascii

bite:	ld	a,(hl)
	inc	hl
	call	phex2
	call	space

noadr:	djnz	hdump2

	call	crlf
	ret

;;; print 16 bytes ascii from IX
hex_ascii:
	call	space
	push	bc
	ld	b,10h
hexal:	ld	a,(ix)
	inc	ix
	cp	20h		;control char?
	jr	c,hexdot	;yes, print a dot
	cp	80h		;high bit set?
	jr	c,hexput	;no, print the char
	
hexdot:	ld	a,'.'

hexput:	call	putc
	djnz	hexal
	pop	bc

;;; print address in HL
hex_addr:
	push	hl
	call	crlf
	call	phex4
	ld	a,':'
	call	putc
	call	space
	pop	hl
	ret

;;; do hex arithmetic
arith:	ld	hl,(iargv+2)	;first arg
	ld	de,(iargv+4)	;second arg
	
	add	hl,de
	call	phex4
	call	space
	ld	hl,(iargv+2)	;first arg
	ld	de,(iargv+4)	;second arg
	or	a		;clear CY
	sbc	hl,de
	call	phex4
	call	crlf
	jp	loop

altban:	db	"BREAK ",0	

;;; ---------- breakpoint entry ----------
;;; Save machine state and display it
;;; Restore code at breakpoint
;;; --------------------------------------
save_state:	
	;; get the return address and save it
	ex	(sp),hl		;return address to HL
	dec	hl
	dec	hl
	dec	hl		;back up over breakpoint call
	ex	(sp),hl		;put back on caller's stack
showstate:	
	ld	(savesp),sp	;save caller's SP
	;; reset the stack to the save area
	ld	sp,savetop
	;; save primary regs
	push	af
	push	bc
	push	de
	push	hl
	;; save alternate regs
	exx
	ex	af,af'
	push	af
	push	bc
	push	de
	push	hl
	;; save IX, IY
	push	ix
	push	iy
	
;;; cold start with alternate banner, display struct address
	ld	sp,stak		;restore UMON stack
	ld	hl,altban
	call	puts
	;; display breakpoint location
	ld	hl,(savead)
	call	phex4
	call	crlf
	
	call	display_regs		;display regs from state
	jp	loop
	
;;; display machine state from stored values
display_regs:
	ld	hl,(savaf)
	ld	de,'AF'
	call	pregn

	ld	hl,(savbc)
	ld	de,'BC'
	call	pregn

	ld	hl,(savde)
	ld	de,'DE'
	call	pregn

	ld	hl,(savhl)
	ld	de,'HL'
	call	pregn

	call	crlf

	;; alternate regs
	ld	hl,(savafp)
	ld	de,'A'''
	call	pregn

	ld	hl,(savbcp)
	ld	de,'B'''
	call	pregn

	ld	hl,(savdep)
	ld	de,'D'''
	call	pregn

	ld	hl,(savhlp)
	ld	de,'H'''
	call	pregn
	call	crlf

	ld	hl,(savix)
	ld	de,'IX'
	call	pregn

	ld	hl,(saviy)
	ld	de,'IY'
	call	pregn

	ld	hl,(savesp)
	ld	de,'SP'
	call	pregn
	
	call	crlf

	ex	af,af'		;back to primary regs
	exx

	ret
	
;;; copy memory
memcpy:	call	load3w
	ldir
	jp	loop

;;; compare memory
;;; up to 16 errors then stop
memcmp:	call	load3w
memcp1:	ld	a,(de)
	cp	a,(hl)
	jr	nz,nocmp
memnxt:	inc	hl
	inc	de
	dec	bc
	ld	a,b
	or	c
	jr	nz,memcp1
	jp	loop

	;; display memory mismatch
nocmp:	call	phex4		;display hl
	call	space
	ld	a,(hl)
	call	phex2
	call	space
	ex	de,hl
	call	phex4		;display hl
	call	space
	ld	a,(hl)
	call	phex2
	ex	de,hl
	call	crlf
	jr	memnxt
	
;;; load hl, de, bc from 3 arguments for compare/copy
load3w:	ld	hl,(iargv+2)	;source
	ld	de,(iargv+4)	;dest
	ld	bc,(iargv+6)	;count
	ret

;;; display reg name from de, value from hl
pregn:	
	call	space
	ld	a,e
	call	putc
	ld	a,d
	call	putc
	ld	a,':'
	call	putc
	call	phex4
	call	space
	ret

;;; input buffer (tokens zero-terminated after parsing)
buff:	ds	80
bend:	equ	$		;mark the end

dskbuf:	ds	200H

umontop:	equ	$
	
	.end
