;;;
;;; simple intel hex loader for CP/M
;;; initialize SIO/2
;;; expect intel hex records
;;;
;;; invoke as A> HEXL FILE.NAM
;;;    (old file deleted first)
;;; 
;;; Bugs:
;;; only works on drive a

;;; MODIFIED FOR SIO PORT B

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

putc_L:	jp	putc		;or putc_B
gets_L:	jp	gets		;or gets_B

	INCLUDE "serial.asm"
	INCLUDE "console.asm"
	INCLUDE "hex.asm"

;;; debug:  print registers on BDOS call
hexdos:	push	bc
	push	hl
	push	de
	push	af

	ld	a,'='
	call	putc_L
	ld	a,c
	call	phex2
	ld	a,'['
	call	putc_L
	ld	h,d
	ld	l,e
	call	phex4
	ld	a,']'
	call	putc_L
	call	crlf

	pop	af
	pop	de
	pop	hl
	pop	bc
	ret

err:	ld	a,'#'
	jr	prom

main:	ld	sp,stak

	call	io_init		; initialize SIO

	;; not sure we need all this
	LD	A,0
	LD	(buffPos),A
	LD	(checkSum),A
	LD	(byteCount),A
	LD	(printCount),A

	ld	hl,DBUFF	; initialize disk buffer
	ld	(buffptr),hl

	ex	de,hl		;buffer address to de
	ld	c,setdma	;set DMA address to be sure
	call	hexdos
	call	bdos

	;; delete old file
	LD	C,DELF
	LD	DE,FCB
	call	hexdos
	CALL	BDOS

	;; create new file
	LD	C,MAKEF
	LD	DE,FCB
	call	hexdos
	CALL	BDOS

line:	ld	a,'+'		; send prompt for a new line
prom:	call	putc_L

	;; read input line to hbuff
	ld	hl,hbuff
	ld	bc,bend-hbuff
	call	gets_L		; read and echo a line to HBUFF

	ld	hl,hbuff
	
	ld	a,(hl)		; get first char
	cp	a,':'		; ":" starts a new hex record
	jr	z,lode
	cp	a,'/'		; "/" terminates
	jp	z,doon
	jr	err		; otherwise, an error

lode:	inc	hl		; skip past ':'
	call	ghex2		; get record size to A
	
	ld	(checksum),a	;init checksum
	ld	(byteCount),a	;save count
	
	call	ghex4		; get load address to DE

	;; add to checksum
	ld	a,(checksum)
	add	a,d
	add	a,e
	ld	(checksum),a

noja:	call	ghex2		; get record type to A

	ld	c,a		; type to C
	;; add to checksum
	ld	a,(checksum)
	add	a,c
	ld	(checksum),a
	ld	a,c		; type back to a
	
	or	a		; test type == 0?
	jr	z,datt		; zero, get data
	dec	a		; test type == 1?
	jr	nz,line		; ignore all others
	
	;; type = 01, we're done
	;; finish up, close file
doon:	
	LD	A,(buffPos)	; get disk buffer offset
	or	a
	JR	Z,NOWRITE2	; if empty, don't write disk

	LD	C,WRITES	; write a record to disk
	LD	DE,FCB
	call	hexdos
	CALL	BDOS

NOWRITE2:
	LD	C,CLOSEF	; close the file
	LD	DE,FCB
	call	hexdos
	CALL	BDOS

	jp	0		; we're done!

	;; parse and store data
	;; 
datt:	call	ghex2		; get data byte

	push	hl		; save input buffer pointer
	
	ld	hl,(buffptr)	; get disk buffer pointer
	ld	(hl),a		; save data
	inc	hl		; increment disk buffer pointer
	ld	(buffptr),hl	; store disk buffer pointer

	ld	b,a		; data to b
	ld	a,(checksum)	; add to checksum
	add	a,b
	ld	(checksum),a
	
	pop	hl		; restore input buffer pointer

	LD	A,(buffPos)	; get disk buffer position
	INC	A		; increment it
	LD	(buffPos),A	; save it
	CP	80H		; full 128-byte buffer?

	JR	NZ,NOWRITE	; nope, skip write

	push	hl		; save input buffer pointer

	LD	C,WRITES	; write to disk
	LD	DE,FCB
	call	hexdos
	CALL	BDOS

	ld	hl,DBUFF	; reset disk buffer pointer
	ld	(buffptr),hl

	pop	hl		; restore input buffer pointer

	ld	a,0		; reset buffer position
	ld	(buffpos),a
	
nowrite:
	ld	a,(byteCount)	; get hex record count
	dec	a		; decrement
	ld	(byteCount),a	; save new count
	jr	nz,datt		; if not zero, loop for next data item

	;; end of hex record
	call	ghex2		; get checksum

	ld	b,a		; file checksum to b

	ld	a,(checksum)	; calculated checksum
	add	b		; result should be zero

	jr	nz,cserr

checksumOK:
	call	crlf

	LD	HL,OKMess
	call	puts
	jp	line

	;; display checksum error
	;; abort for now
cserr:	push	af
	ld	a,'='
	call	putc_L
	pop	af
	call	phex2
	ld	hl,chkErrMess
	call	puts

	jp	0
	
sadd:	dw	0		; store start address here
ladd:	dw	0		; last address here

buffPos	.DB	0H
buffPtr	.DW	0000H
printCount .DB	0H
checkSum .DB	0H
byteCount .DB	0H
OKMess	.BYTE	"OK",0
chkErrMess .BYTE	"======Checksum Error======$",0
countErrMess .BYTE	"======File Length Error======$",0

hbuff:	ds	100h		;buffer for hex data
bend:	equ	$

	ds	100h		;stack
stak:	equ	$
	
	.end
