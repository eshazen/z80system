	;;
	;; format_hd.asm - format 8 MiB hard drive
	;;
	;; Expects UMON resident at 8100H !!
	;; write E5 over all sectors on track 0 only

	org	1000h

MEM	EQU	63		;63K to match cbios_ide
	
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
	;; fill bufr with e5
	ld	hl,bufr
	ld	b,80
	ld	a,0e5h
	
fbuf:	ld	(hl),a
	inc	hl
	djnz	fbuf

	ld	hl,msg_writing
	call	puts
	
	ld	de,1		;disk 1
	
	ld	hl,0		;start with track 0 sector 0

	ld	ix,bufr

rsec:	ld	a,'.'
	call	putc
	
	push	de
	push	hl
	push	ix
	
	call	IDE_Setup_LBA
	call	IDE_Write_Sector

	pop	ix
	pop	hl
	pop	de

	inc	l		;increment sector
	ld	a,l

	or	a		;zero = wrapped, done 256 sectors

	jr	nz,rsec		;no, continue on this track

	jp	main


msg_bad_status:	db 'Bad status: ',0
msg_writing:	db 'Writing: ',0
	
bufr:	ds	200h

	end
	
