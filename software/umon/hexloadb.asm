;;;
;;; simple intel hex loader
;;; initialize SIO/2
;;; expect intel hex records
;;; jump to first address seen on EOF
;;; 
;;; Uses SIO port B
;;; 
	org	0C000H

stak:	equ	$
	jp	main
	
;	INCLUDE "serial.asm"

;;; initialize console I/O
io_init: jp RC2014_SerialSIO2_Initialise_T2
	
;;; send a character from A
;;; wait if needed
putc:	push af
putc1:	call RC2014_SerialSIO2B_OutputChar_T2
	jr z,putc1
	pop af
	ret

;;; receive a character to a
;;; wait if needed
getc:	call RC2014_SerialSIO2B_InputChar_T2
	ret nz
	jr getc

; Base address for SIO
kSIO2:     .EQU 0x80           ;Base address of SIO/2 chip

; SIO/2 type 2 registers derived from base address (above)
kSIOAConT2: .EQU kSIO2+0        ;I/O address of control register A
kSIOADatT2: .EQU kSIO2+1        ;I/O address of data register A
kSIOBConT2: .EQU kSIO2+2        ;I/O address of control register B
kSIOBDatT2: .EQU kSIO2+3        ;I/O address of data register B

; Status (control) register bit numbers
kSIORxRdy:  .EQU 0              ;Receive data available bit number
kSIOTxRdy:  .EQU 2              ;Transmit data empty bit number


; Device detection, test 1
; This test just reads from the devices' status (control) register
; and looks for register bits in known states:
; CTS input bit = high
; DCD input bit = high
; Transmit data register empty bit = high
kSIOMask1:  .EQU  00101100b    ;Mask for known bits in control reg
kSIOTest1:  .EQU  00101100b    ;Test value following masking


; **********************************************************************
; **  Type 2 (Spencer's original addressing scheme)                   **
; **********************************************************************

; RC2014 type 2 serial SIO/2 initialise
;   On entry: No parameters required
;   On exit:  Z flagged if device is found and initialised
;             AF BC DE HL not specified
;             IX IY I AF' BC' DE' HL' preserved
; If the device is found it is initialised
RC2014_SerialSIO2_Initialise_T2:
; First look to see if the device is present
            IN   A,(kSIOAConT2) ;Read status (control) register A
            AND  kSIOMask1      ;Mask for known bits in control reg
            CP   kSIOTest1      ;Test value following masking
            RET  NZ             ;Return not found NZ flagged
            IN   A,(kSIOBConT2) ;Read status (control) register B
            AND  kSIOMask1      ;Mask for known bits in control reg
            CP   kSIOTest1      ;Test value following masking
            RET  NZ             ;Return not found NZ flagged
; Device present, so initialise 
            LD   C,kSIOAConT2   ;SIO/2 channel A control port
            CALL RC2014_SerialSIO2_IniSend
            LD   C,kSIOBConT2   ;SIO/2 channel B control port
            JP   RC2014_SerialSIO2_IniSend


; RC2014 type 2 serial SIO/2 channel A & B input character
;   On entry: No parameters required
;   On exit:  A = Character input from the device
;             NZ flagged if character input
;             BC DE HL IX IY I AF' BC' DE' HL' preserved
RC2014_SerialSIO2A_InputChar_T2:
            IN   A,(kSIOAConT2) ;Address of status register
            BIT  kSIORxRdy,A    ;Receive byte available
            RET  Z              ;Return Z if no character
            IN   A,(kSIOADatT2) ;Read data byte
            RET
RC2014_SerialSIO2B_InputChar_T2:
            IN   A,(kSIOBConT2) ;Address of status register
            BIT  kSIORxRdy,A    ;Receive byte available
            RET  Z              ;Return Z if no character
            IN   A,(kSIOBDatT2) ;Read data byte
            RET


; RC2014 type 2 serial SIO/2 channel A & B output character
;   On entry: A = Character to be output to the device
;   On exit:  If character output successful (eg. device was ready)
;               NZ flagged and A != 0
;             If character output failed (eg. device busy)
;               Z flagged and A = Character to output
;             BC DE HL IX IY I AF' BC' DE' HL' preserved
RC2014_SerialSIO2A_OutputChar_T2:
            PUSH BC
            LD   C,kSIOAConT2   ;SIO control register
            IN   B,(C)          ;Read SIO control register
            BIT  kSIOTxRdy,B    ;Transmit register full?
            POP  BC
            RET  Z              ;Return Z as character not output
            OUT  (kSIOADatT2),A ;Write data byte
            OR   0xFF           ;Return success A=0xFF and NZ flagged
            RET
RC2014_SerialSIO2B_OutputChar_T2:
            PUSH BC
            LD   C,kSIOBConT2   ;SIO control register
            IN   B,(C)          ;Read SIO control register
            BIT  kSIOTxRdy,B    ;Transmit register full?
            POP  BC
            RET  Z              ;Return Z as character not output
            OUT  (kSIOBDatT2),A ;Write data byte
            OR   0xFF           ;Return success A=0xFF and NZ flagged
            RET


; **********************************************************************
; **  Private functions                                               **
; **********************************************************************


; RC2014 serial SIO/2 write initialisation data 
;   On entry: C = Address of SIO control register
;   On exit:  DE IX IY I AF' BC' DE' HL' preserved
; Send initialisation data to specied control register
RC2014_SerialSIO2_IniSend:
            LD   HL,SIOIni     ;Point to initialisation data
            LD   B,SIOIniEnd-SIOIni ;Length of ini data
            OTIR                ;Write data to output port C
            XOR  A              ;Return Z flag as device found
            RET
; SIO channel initialisation data
SIOIni:     .DB  00011000b     ; Wr0 Channel reset
;           .DB  00000010b     ; Wr0 Pointer R2
;           .DB  0x00           ; Wr2 Int vector
            .DB  00010100b     ; Wr0 Pointer R4 + reset ex st int
            .DB  11000100b     ; Wr4 /64, async mode, no parity
            .DB  00000011b     ; Wr0 Pointer R3
            .DB  11000001b     ; Wr3 Receive enable, 8 bit 
            .DB  00000101b     ; Wr0 Pointer R5
            .DB  01101000b     ; Wr5 Transmit enable, 8 bit 
;           .DB  11101010b     ; Wr5 Transmit enable, 8 bit, flow ctrl
            .DB  00010001b     ; Wr0 Pointer R1 + reset ex st int
            .DB  00000000b     ; Wr1 No Tx interrupts
SIOIniEnd:

;	INCLUDE "console.asm"

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
	
;;; output CR/LF
crlf:	ld	a,13
	call 	putc
	ld	a,10
	jp	putc
	
;	INCLUDE "hex.asm"

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
ihex1:	sub	'0'		;A-'0'
	ret	c		;A < '0', not valid
	cp	10
	ccf
	ret	nc		;all done if result < 10
	sub	'A'-'9'-1	;should give value 10..15
	cp	10
	ret	c
	cp	16
	ccf
	ret

;;; get hex from (hl) and return in A (NC if valid)
;;; increment HL past char
ghex1:	ld	a,(hl)
	inc	hl
	jp	ihex1

;;; get 2-digit hex from HL
;;; return in A, other regs preserved
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

;;; get 4-digit hex value from HL and return in DE
ghex4:	call	ghex2
	ret	c
	ld	d,a
	call	ghex2
	ld	e,a
	ret
	
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
	jp	z,0
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

;	jp	0

	jp	8100h

	;; parse and store data
datt:	call	ghex2
	ld	(de),a
	inc	de
	djnz	datt
	jr	line

sadd:	dw	0		; store start address here

buff:	ds	100h
bend:	equ	$
	
	.end
