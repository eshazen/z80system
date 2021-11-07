;;;
;;; simple intel hex loader for CP/M
;;; initialize SIO/2
;;; expect intel hex records
;;;
;;; invoke as A> HEXL FILE.NAM
;;;    (old file deleted first)
;;; 

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
SETUSR	.EQU	32

CR	.EQU	0DH
LF	.EQU	0AH

FCB	.EQU	05CH
BUFF	.EQU	080H

	.ORG TPA

	jp	main

bdos:	equ	5
	

	
errsun:	ld	a,'S'
	jr	prom

errnul:	ld	a,'N'
	jr	prom

err:	ld	a,'#'
	jr	prom

main:	call	io_init		;null function

	;; not sure we need all this
	LD	A,0
	LD	(buffPos),A
	LD	(checkSum),A
	LD	(byteCount),A
	LD	(printCount),A

	ld	hl,buff
	ld	(buffptr),hl

	;; delete old file
	LD	C,DELF
	LD	DE,FCB
	CALL	BDOS

	;; create new file
	LD	C,MAKEF
	LD	DE,FCB
	CALL	BDOS

line:	ld	a,'+'
prom:	call	putc

	;; read input line to hbuff
	ld	hl,hbuff
	ld	bc,bend-hbuff
	call	gets

	ld	ix,hbuff
	ld	a,(ix)
	cp	a,':'
	jr	z,lode
	cp	a,'/'
	jp	z,doon
	jr	err

lode:	inc	ix		; skip past ':'
	call	ghex2		; get record size to A
	jp	c,errnul
	
	ld	(checksum),a	;init checksum

	ld	(byteCount),a	;save count
	
	;; size is correct, echo it
	;; DEBUG
	ld	a,'s'
	call	putc
	ld	a,b
	call	phex2
	;; /DEBUG

	call	ghex4		; get load address to DE
	jp	c,errnul

	;; add to checksum
	ld	a,(checksum)
	add	a,d
	add	a,e
	ld	(checksum),a

	;; echo address
	;; DEBUG
	ld	a,'a'
	call	putc
	push	ix
	pop	hl
	call	phex4
	;; /DEBUG

noja:	call	ghex2		; get record type to A
	jp	c,errnul

	;; echo type
	;; DEBUG
	push	af
	ld	a,'t'
	call	putc
	pop	af
	call	phex2
	;; /DEBUG

	ld	c,a		;type to C
	;; add to checksum
	ld	a,(checksum)
	add	a,c
	ld	(checksum),a
	ld	a,c
	
	or	a
	jr	z,datt		; zero, get data
	dec	a
	jr	nz,line		; ignore all others

	;; DEBUG
	ld	a,'d'
	call	putc
	;; /DEBUG

	;; type = 01, we're done
doon:	
	LD	A,(buffPos)
	CP	0
	JR	Z,NOWRITE2

	LD	C,WRITES
	LD	DE,FCB
	CALL	BDOS

NOWRITE2:
	LD	C,CLOSEF
	LD	DE,FCB
	CALL	BDOS

	jp	0

	;; parse and store data
datt:	call	ghex2		;get data byte
	jp	c,errnul	;

	push	ix
	ld	hl,(buffptr)
	ld	(hl),a
	inc	hl
	ld	(buffptr),hl

	ld	b,a
	ld	a,(checksum)
	add	a,b
	ld	(checksum),a
	pop	ix

	LD	A,(buffPos)
	INC	A
	LD	(buffPos),A
	CP	80H

	JR	NZ,NOWRITE

	push	ix
	LD	C,WRITES	;write to disk
	LD	DE,FCB
	CALL	BDOS

	ld	hl,buff
	ld	(buffptr),hl	;reset pointer
	pop	ix

	ld	a,0
	ld	(buffpos),a	;and count
	
nowrite:
	ld	a,(byteCount)
	dec	a
	ld	(byteCount),a
	jr	nz,datt

	call	ghex2		;get checksum
	jp	c,errsun

	ld	b,a		;file checksum to b

	ld	a,(checksum)	;calc checksum
	ld	c,a		;to c
	xor	a
	sub	c

	cp	b
	jr	nz,cserr

checksumOK:
	call	crlf

	LD	HL,OKMess
	call	puts
	jp	line

	;; display checksum error
cserr:	ld	a,'='
	call	putc
	push	bc
	pop	hl
	call	phex4

	jp	line
	
;;; ------------------------------------------------------------
;;; Console I/O utilities
;;;
;;; assumes putc, getc
;;; ------------------------------------------------------------

;;; CP/M versions of console I/O
;;; 
;;; initialize console I/O
io_init: ret			;not needed in CP/M
	
;;; send a character from A
putc:	push	af
	push	bc
	push	hl
	push	de

	ld	c,6
	ld	e,a
	call	bdos

pbak:	pop	de
	pop	hl
	pop	bc
	pop	af

	ret

;;; receive a character to a
;;; wait if needed
getc:	push	bc
	push	hl
	push	de

getc1:	ld	c,6
	ld	e,0ffh
	
	call	bdos
	or	a		;check for zero
	
	jr	z,getc1		;wait for char

	pop	de
	pop	hl
	pop	bc
	ret

;;; ------------------------------------------------------------

;;; convert A to uppercase
toupper: cp	'a'
	ret	c
	cp	'z'+1
	ret	nc
	and	5FH
	ret
	
;;; read string from console to HL
;;; stop on CR/LF/ESC
;;; null-terminate the string without the terminating control char
;;; return the control character in A
;;; only accept up to BC bytes
;;; used:  A + 3 stack levels

gets:	push	de
	push	hl
	push	bc
	
	ld	d,h		;buffer pointer to DE for reference
	ld	e,l
	
	add	hl,bc		;hl now points to buffer limit

	ld	b,h
	ld	c,l		;limit to BC
	
	dec	bc		;adjust limit to leave room for null terminator
	ld	h,d
	ld	l,e		;now: HL=buff BC=limit DE=buff

gets0:	
	call	getc
	call	toupper		;force all input to uppercase for now
	cp	0dh		;check for CR
	jr	z,gets1
	cp	0ah		;check for LF
	jr	z,gets1
	cp	1bh		;check for ESC
	jr	z,gets1
	cp	08h		;check for BS
	jr	z,gets3
	cp	20h		;check for printable
	jr	nc,gets2	;store only printable
	;; handle backspace
gets3:
	or	a		;clear CY
	push	HL
	sbc	HL,DE		;are we at the beginning?
	pop	HL
	jr	z,gets0		;yes, no backspace
	;; perform the backspace
	ld	a,8
	call	putc		;echo the backspace
	ld	(hl),0		;null-terminate here
	dec	hl
	jr	gets0

	;; try to store a printable char
gets2:	
	;; check if at end of buffer
	push	hl
	or	a		;clear CY
	sbc	hl,bc
	pop	hl
	jr	z,gets0

	call	putc		;echo the char
	ld	(hl),a		;store it
	inc	hl		;increment
	jr	gets0
	
	;; finish up
gets1:	ld	(hl),0
	push	af
	call	crlf
	pop	af

	pop	hl
	pop	de
	pop	bc
	
	ret
	
;;; output CR/LF
crlf:	ld	a,13
	call 	putc
	ld	a,10
	jp	putc
	

;;; output null-terminated string from (HL)
puts:	ld	a,(hl)
	or	a
	ret	z
	call	putc
	jr	puts

;;; 
;;; hex input/output
;;;
;;; phex1  - print hex digit from A
;;; phex2  - print hex byte from A
;;; phex4  - print hex word from HL
;;; ihex1  - hex to binary in A, NC if valid
;;; ghex1  - get hex from (hl) and return in A (NC if valid), inc hl
;;; ghex2  - get 2-digit hex from (hl), return in A
;;; ghex4  - get 4-digit hex from (hl), return in DE
;;; vhex   - get 1-4 digit hex from (hl), return in DE, inc HL past
;;; cvint  - convert up to B tokens from ptr list at HL to int list at DE

;;; convert ASCII hex in A to binary
;;; NC if valid hex
;;; if invalid, A is modified but not valid
ihex1:	or	a		;check for null
	jr	z,ihexe		;null: go return with Cy set
	sub	'0'		;A-'0'
	ret	c		;A < '0', not valid
	cp	10
	ccf
	ret	nc		;all done if result < 10
	sub	'A'-'9'-1	;should give value 10..15
	cp	10
	ret	c
	cp	16
ihexe:	ccf
	ret

;;; get hex from (ix) and return in A (NC if valid)
;;; increment HL past char
ghex1:	ld	a,(ix)
	inc	ix
	jp	ihex1

;;; get 2-digit hex from IX
;;; return in A, other regs preserved
;;; NC if valid, C if not valid or NULL seen
ghex2:	push	bc
	call	ghex1
	jr	c,ghex2a
	rlca
	rlca
	rlca
	rlca
	and	0f0h
	ld	b,a
	call	ghex1
	jr	c,ghex2a
	or	b
ghex2a:	pop	bc
	ret

;;; get 4-digit hex value from IX and return in DE
ghex4:	call	ghex2
	ret	c
	ld	d,a
	call	ghex2
	ld	e,a
	ret




;;; print hex nibble from a
phex1:	push 	af
	and 	a, 0fh
	add	a,'0'
	cp	'9'+1
	jr	c,phex1a
	add	a,'A'-'0'-10
phex1a:	call	putc
	pop	af
	ret

;;; print hex byte from a
phex2:	push	af
	push	bc
	ld	b,a		;save value
	rrca
	rrca
	rrca
	rrca			;get high nibble
	call	phex1
	ld	a,b		;get low nibble
	call	phex1
	pop	bc
	pop	af
	ret

;;; print hex word from HL
phex4:	push	hl
	push	af
	ld	a,h
	call	phex2
	ld	a,l
	call	phex2
	pop	af
	pop	hl
	ret
	




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

	.end
