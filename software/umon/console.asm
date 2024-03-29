;;; Console I/O
;;;
;;; assumes putc, getc
;;; 

;;; convert A to uppercase
toupper: cp	'a'
	ret	c
	cp	'z'+1
	ret	nc
	and	5FH
	ret
	
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

puts_B:	ld	a,(hl)
	inc	hl
	or	a
	ret	z
	call	putc_B
	jr	puts_B

;;; read string from port B to HL
;;; no editing, etc.  No echo.  Stop on first control char
;;; no timeout

gets_B:	push	hl
	push	bc
	
getsB0:	ld	bc,0		;timeout counter

getsBW:	call	rxrdy_B		;check for char ready, NZ if so
	
	jr	z,getsBW	;just wait forever for char

;	jr	nz,getsBC	;go read the character
;	dec	bc		;no char, dec timeout
;	ld	a,b		;check for zero
;	or	c
;	jr	nz,getsBW	;still waiting
;	jr	getsB1		;timeout, just return what we've got

getsBC:	call	getc_B		;read the character
	cp	20h		;is control?
	jr	c,getsB1	;yes, ignore it and end
	ld	(hl),a		;no, store non-control
	inc	hl		;increment pointer
	;; FIXME:  check for buffer overrun here
	jr	getsB0

getsB1:	;control char
	ld	(hl),0		;null-terminate
	pop	bc
	pop	hl
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
	or	a
	sbc	hl,bc
	pop	hl
	jr	z,gets0

	call	putc		;echo the char
	ld	(hl),a		;store it
	inc	hl		;increment
	;; should really check for buffer overflow here
	jr	gets0
	
gets1:	ld	(hl),0
	push	af
	call	crlf
	pop	af

	pop	hl
	pop	de
	pop	bc
	
	ret
	
