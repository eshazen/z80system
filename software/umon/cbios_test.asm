;;;
;;; test CBIOS

bios:	equ	04A00h		;base of bios to test

btest:	equ	4000h

	org	btest
	jp	test_main

bjump:	equ	$
;
;	jump vector for individual subroutines (in BIOS)
;
boot:	JP	bios+$-bjump    	;cold start
wboot:	JP	bios+$-bjump    	;warm start
const:	JP	bios+$-bjump    	;console status
conin:	JP	bios+$-bjump    	;console character in
conout:	JP	bios+$-bjump    	;console character out
list:	JP	bios+$-bjump    	;list character out
punch:	JP	bios+$-bjump    	;punch character out
reader:	JP	bios+$-bjump    	;reader character out
home:	JP	bios+$-bjump    	;move head to home position
seldsk:	JP	bios+$-bjump    	;select disk
settrk:	JP	bios+$-bjump    	;set track number
setsec:	JP	bios+$-bjump    	;set sector number
setdma:	JP	bios+$-bjump    	;set dma address
read:	JP	bios+$-bjump    	;read disk
write:	JP	bios+$-bjump    	;write disk
listst:	JP	bios+$-bjump    	;return list status
sectran: JP	bios+$-bjump    	;sector translate

bufptr:	ds	2
buff:	ds	80h

diskbuf: equ	4800h

test_main:
	ld	hl,buff
	ld	(bufptr),hl
	;; send a '>'
	ld	c,'>'
	call	conout
	;; read and echo up to control char
grab:	call	const
	or	a
	jr	z,grab
	call	conin
	push	af
	ld	c,a
	call	conout
	pop	af
	ld	hl,(bufptr)
	ld	(hl),a
	inc	hl
	ld	(bufptr),hl
	cp	a,20h
	jr	nc,grab
	;; end of line, decide what to do
	ld	a,(buff)
	cp	a,'R'
	jr	z,do_read
	cp	a,'W'
	jr	z,do_write
	cp	a,'Q'
	jp	z,8100h
	
	jr	test_main

do_read:
	ld	c,0
	call	seldsk
	ld	c,0
	call	settrk
	ld	c,1
	call	setsec
	ld	bc,diskbuf
	call	setdma

	call	read
	add	a,'0'
	ld	c,a
	call	conout
	
	jp	test_main

do_write:	
	ld	c,0
	call	seldsk
	ld	c,0
	call	settrk
	ld	c,1
	call	setsec
	ld	bc,diskbuf
	call	setdma

	call	write
	add	a,'0'
	ld	c,a
	call	conout
	
	jp	test_main

	
	


	end

	
