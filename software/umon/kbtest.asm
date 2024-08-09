
	putc	.equ	8109h
	phex2	.equ	8112h
	crlf	.equ	810ch

	org	100h

key:	in	a,(82h)
	and	1
	jr	z,key
	in	a,(83h)
	call	phex2
	call	crlf
	jr	key
	
