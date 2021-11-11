;;;
;;; simple intel hex loader
;;; initialize SIO/2
;;; expect intel hex records
;;; display page count and exit to CP/M at end
;;;
	org	0D000H

stak:	equ	$
	jp	main
	
	INCLUDE "serial.asm"
	INCLUDE "console.asm"
	INCLUDE "hex.asm"
	
err:	ld	a,'#'
	jr	prom

main:	ld	sp,stak
	call	io_init

line:	ld	a,'+'
prom:	call	putc

	ld	hl,buff
	ld	bc,bend-buff
	call	gets

	ld	hl,buff
	ld	a,(hl)
	cp	a,':'
	jr	z,lode
	cp	a,'/'
	jp	z,exxit
	jr	err

lode:	inc	hl
	call	ghex2		; get record size to A
	ld	b,a		; size to b
	call	ghex4		; get load address to DE
	
	;; if we don't have a load address, store it now at (sadd)
	ld	a,(sadd)
	or	a
	jr	nz,noja
	ld	a,(sadd+1)
	or	a
	jr	nz,noja

	ld	(sadd),de

noja:	call	ghex2		; get record type to A
	or	a
	jr	z,datt		; zero, get data
	dec	a
	jr	nz,line
	;; type = 01, we're done
	ld	hl,(sadd)

	jp	exxit

	;; parse and store data
datt:	call	ghex2
	ld	(de),a

	;; if de > eadd, store eadd
	push	hl
	ld	hl,(eadd)
	or	a		;clear cy
	sbc	hl,de
	jr	nc,nobig
	;; store de
	ex	de,hl
	ld	(eadd),hl
	ex	de,hl

nobig:	pop	hl

	inc	de
	djnz	datt
	jr	line

;;; print address range and exit
exxit:	ld	hl,(sadd)
	call	phex4
	ld	a,'-'
	call	putc
	ld	hl,(eadd)
	call	phex4
	call	crlf

	jp	0
	
;	jp	8100h		;FIXME:  jump to CP/M

sadd:	dw	0		; store start address here
eadd:	dw	0		; store last address here

buff:	ds	100h
bend:	equ	$
	
	.end
