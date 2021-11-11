	;;
	;; getsys.asm - read CP/M from IDE to memory
	;;
	;; IDE mapping:	  LBA 0-7 is sector
	;; 		  LBA 8-15 is track
	;;                LBA 16-17 is disk
	;;
	;; Expects UMON resident at 8100H !!

	org	100h

MEM	EQU	63		;63K to match cbios_hd
	
ccp:	equ	(MEM-7)*1024
bdos:	equ	ccp+0806h
bios:	equ	ccp+1600h

;;; Useful UMON entry points

main		  equ  8100h        ;00   0000	cold start
save_state	  equ  8103h        ;01   0003	save state (breakpoint)
getc		  equ  8106h        ;02   0006	read serial input to A
putc		  equ  8109h        ;03   0009	output serial from A
crlf		  equ  810Ch        ;04   000c	output CR/LF
puts		  equ  810Fh        ;05   000f	output string from HL
phex2		  equ  8112h        ;06   0012	output hex byte from A
phex4		  equ  8115h        ;07   0015	output hex word from HL

IDE_Initialize    equ  8118h        ;08   0018	setup PPI, reset drive
IDE_Byte_Read     equ  811Bh        ;09   001b	read byte from reg C to A
IDE_Word_Read     equ  811Eh        ;0a   001e	read word from reg C to HL
IDE_Byte_Write    equ  8121h        ;0b   0021	write data in A to reg C (uses B)
IDE_Word_Write    equ  8124h        ;0c   0024	write data in HL to reg C (uses B)
IDE_Get_Status    equ  8127h        ;0d   0027	read status register to A
IDE_Wait_Ready    equ  812Ah        ;0e   002a	wait for busy=0, ready=1
IDE_Wait_DRQ      equ  812Dh        ;0f   002d	wait for DRQ=1
IDE_Do_Cmd	  equ  8130h        ;10   0030	issue a command from A (use b, c)
IDE_Setup_LBA     equ  8133h        ;11   0033	set LBA from DEHL
IDE_Read_ID	  equ  8136h        ;12   0036	Read 512 byte ID to (DE)
IDE_Read_Sector	  equ  8139h        ;13   0039	Read sector from LBA=DEHL to IX
IDE_Write_Sector  equ  813Ch        ;14   003c      Write sector from IX to LBA=DEHL

nsects:	equ	26*2		;two tracks to read

	call	IDE_Initialize
	call	IDE_Get_Status
	cp	50h
	jr	z,stat_ok
	push	af
	ld	hl,msg_bad_status
	call	puts
	pop	af
	call	phex2
	call	crlf
	jp	main

	;; setup registers to start
stat_ok:	
	ld	hl,msg_reading
	call	puts
	
	ld	de,0
	ld	hl,2		;start with track 0, sector 2
	ld	b,nsects
	ld	iy,ccp
	

rsec:	push	bc
	ld	a,'.'
	call	putc
	
	push	de
	push	hl
	push	iy
	
	call	IDE_Setup_LBA
	ld	ix,dbuff
	call	IDE_Read_Sector

	;; copy 128 bytes to iy
	ld	b,80h
copb:	ld	a,(ix)
	ld	(iy),a
	inc	ix
	inc	iy
	djnz	copb

	pop	iy
	ld	de,80h
	add	iy,de

	pop	hl
	pop	de

	inc	l		;increment sector
	ld	a,l
	cp	27		;overflow?
	jr	nz,nsec		;no, continue on this track

	ld	l,1		;else set sector 1
	inc	h		;increment track

nsec:
	pop	bc
	djnz	rsec

	jp	main

msg_bad_status:	db 'Bad status: ',0
msg_reading:	db 'Reading: ',0

dbuff:	equ	$		;host sector buffer above code

	end
	
