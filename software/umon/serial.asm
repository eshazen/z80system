;;; simple non-interrupt support for RC2014 SIO/2
;;; primary port is A for UMON console
;;; secondary port is B for other use

;;; io_init - initialize both ports
;;; putc    - send char in A to port A, wait if needed
;;; putc_B  - send char in A to port B, wait if needed
;;; getc    - receive char from port A to A, wait if needed
;;; getc_B  - receive char from port A to A, wait if needed
;;; rxrdy   - return NZ if characters available (uses A)
;;; txrdy   - return NZ if ready to send

ifdef mux_sio	
;;; multiplexed via switch
txrdy_X: call	checksw
	jr	z,txrdy
	jr	txrdy_B

txrdy_Y: call	checksw	
	jr	z,txrdy_B
	jr	txrdy
;;; ----------------------------------------
rxrdy_X: call	checksw
	jr	z,rxrdy
	jp 	rxrdy_B
	
rxrdy_Y: call	checksw
	jr 	z, rxrdy_B
	jr 	rxrdy
;;; ----------------------------------------
putc_X: call	checksw
	jr	z,putc
	jr	putc_B
	
putc_Y: call	checksw
	jr	z, putc_B
	jr	putc
;;; ----------------------------------------
getc_X: call	checksw
	jr	z,getc
	jr	getc_B
	
getc_Y:	call	checksw
	jr	z,getc_B
	jr	getc
;;; ----------------------------------------
endif	
	
	ifdef mux_sio
	
;;; read switch at port 00, check bit 0
checksw: push	bc
	ld	c,0
	in	b,(c)
	bit	0,b
	pop	bc
	ret

	endif

;;; initialize console I/O (both ports)
io_init: jp RC2014_SerialSIO2_Initialise_T2
	

;;; send a character from A (SIO port A)
;;; wait if needed
	ifndef mux_sio
putc_Y:
	endif
putc:	push af
putc1:	call RC2014_SerialSIO2A_OutputChar_T2
	jr z,putc1
	pop af
	ret

;;; send a character from A (SIO port B)
;;; wait if needed
	ifndef mux_sio
putc_X:
	endif
putc_B:	push af
putc1B:	call RC2014_SerialSIO2B_OutputChar_T2
	jr z,putc1B
	pop af
	ret


;;; receive a character to a (SIO port A)
;;; wait if needed
	ifndef mux_sio
getc_Y:
	endif
getc:	call RC2014_SerialSIO2A_InputChar_T2
	ret nz
	jr getc


;;; receive a character to a (SIO port B)
;;; wait if needed
	ifndef mux_sio
getc_X:
	endif
getc_B:	call RC2014_SerialSIO2B_InputChar_T2
	ret nz
	jr getc_B

	

;;; return Z if no characters available, NZ if characters available
	ifndef mux_sio
rxrdy_Y:
	endif
rxrdy:	PUSH BC
	LD C, kSIOAConT2	;Address of status register
	IN B,(C)
        BIT  kSIORxRdy,B	;Receive byte available
	POP BC
        RET			;Return Z if no character

;;; return Z if no characters available, NZ if characters available
	ifndef mux_sio
rxrdy_X:
	endif
rxrdy_B: PUSH BC
	LD C, kSIOBConT2	;Address of status register
	IN B,(C)
        BIT  kSIORxRdy,B	;Receive byte available
	POP BC
        RET			;Return Z if no character

flush_B:
	call rxrdy_B
	ret z
	jr flush_B

;;; return z if output is busy/full, NZ if ready to send
	ifndef mux_sio
txrdy_Y:
	endif
txrdy:	
        PUSH BC
        LD   C,kSIOAConT2   ;SIO control register
        IN   B,(C)          ;Read SIO control register
        BIT  kSIOTxRdy,B    ;Transmit register full?
        POP  BC
        RET                ;Return Z as character not output
	
;;; return z if output is busy/full, NZ if ready to send
	ifndef mux_sio
txrdy_X:	
	endif
txrdy_B:	
        PUSH BC
        LD   C,kSIOBConT2   ;SIO control register
        IN   B,(C)          ;Read SIO control register
        BIT  kSIOTxRdy,B    ;Transmit register full?
        POP  BC
        RET                ;Return Z as character not output
	

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

	
