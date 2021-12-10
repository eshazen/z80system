	;;
	;; writfil.asm - write a large file
	;;
	
TPA	.EQU	100H
REBOOT	.EQU	0H
BDOS	.EQU	5H
CONIO	.EQU	6
CONINP	.EQU	1
CONOUT	.EQU	2
PSTRING	.EQU	9
MAKEF	.EQU	22
CLOSEF	.EQU	16
WRITES	.EQU	21
DELF	.EQU	19
SETDMA	.EQU	26

CR	.EQU	0DH
LF	.EQU	0AH

FCB	.EQU	05CH
DBUFF	.EQU	080H

	.ORG TPA

	jp	main

	include "hex.asm"

;;; output space
space:	ld	a,' '
	jp	putc

;;; output CR/LF
crlf:	ld	a,13
	call 	putc
	ld	a,10
	jp	putc

;;; output null-terminated string from HL
;;; return with HL pointing past null
puts:	ld	a,(hl)
	inc	hl
	or	a
	ret	z
	call	putc
	jr	puts
	

;;; define putc for CP/M
putc:	push	af
	push	bc
	push	de
	push	hl
	ld	c,2
	ld	e,a
	call	bdos
	pop	hl
	pop	de
	pop	bc
	pop	af
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
	ret

;;; print address in HL
hex_addr:
	push	hl
	call	phex4
	ld	a,':'
	call	putc
	call	space
	pop	hl
	ret

;;; ------------------------------------------------------------

main:	
	ld	sp,stak
	;; 
	;; for debug, dump all of page zero in hex
	;;
	ld	hl, 0
dum0:	call	hex_addr
	ld	b, 10h
	push	hl		;address to IX
	pop	ix
	
	;; dump b bytes in hex from HL
dumb:
	ld	a,(hl)		;
	call	phex2
	call	space
	inc	hl
	dec	b
	jp	nz,dumb

	call	hex_ascii

	call	crlf

	ld	a,h
	cp	1
	jr	nz, dum0

;;; ------------------------------------------------------------
	ld	hl,DBUFF	; initialize disk buffer
	;; fill with printable stuff
	ld	b,80h

bfill:	ld	a,l
	and	1fh
	or	40h
	ld	(hl),a
	inc	hl
	djnz	bfill
	
	ld	de,dbuff
	ld	c,setdma	;set DMA address
	call	bdos

	;; delete old file
	LD	C,DELF
	LD	DE,FCB
	CALL	BDOS

	;; create new file
	LD	C,MAKEF
	LD	DE,FCB
	CALL	BDOS
	
	;; write 10 records
	ld	b,10

WRIT1:	push	bc
	LD	C,WRITES	; write a record to disk
	LD	DE,FCB
	CALL	BDOS
	pop	bc
	djnz	WRIT1

	LD	C,CLOSEF	; close the file
	LD	DE,FCB
	CALL	BDOS

	jp	0		; we're done!

	
;;; ----------------------------------------
;;; data area
;;; ----------------------------------------
	ds	100H		;stack area

stak:	


	end
	
