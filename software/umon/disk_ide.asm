
;;; IDE read/write routines

;;; 8255 ports
PPIA:	equ	20h
PPIB:	equ	21h
PPIC:	equ	22h
PPICTL:	equ	23h
;;; 8255 control modes
PP_IN:	equ	92h		;8255 input mode on ports A, B
PP_OUT:	equ	80h		;8255 output mode on ports A, B
;;; 8255 port C bits (IDE signals)
PPA0:	equ	01h		;IDE address 0
PPA1:	equ	02h		;IDE address 1
PPA2:	equ	04h		;IDE address 2
PPCS0:	equ	08h		;IDE /CS0 (inverted so active high here)
PPCS1:	equ	10h		;IDE /CS1 (not used)
PPWR:	equ	20h		;IDE /WR
PPRD:	equ	40h		;IDE /RD
PPRST:	equ	80h		;IDE /RST
;;; IDE commands
IDE_ID:	equ	0ech		;identify drive
IDE_RS:	equ	20h		;read sectors w/ retry
IDE_WS:	equ	30h		;write sectors /w retry
;;; IDE status bits in register 7
IDE_BSY: equ	80h		;busy = 1
IDE_RDY: equ	40h		;ready = 1
IDE_DRQ: equ	08h		;DRQ = 1

;;;
;;; Initialize interface
;;;
IDE_Initialize:
	ld	a,PP_IN		;PORT C = out, A, B = IN
	out	(PPICTL),a
	;; fall thru to reset
IDE_Reset:
	ld	a,PPRST		;only IDE reset active
	out	(PPIC),a
IDE_Idle:
	xor	a		;turn off all control signals
	out	(PPIC),a
	ret

;;; read IDE register C, data to HL
IDE_Reg_Read:
	ld	a,c
	out	(PPIC),a	;set address
	add	a,PPRD		;set RD=1
	out	(PPIC),a
	in	A,(PPIA)	;get LSB
	ld	l,a
	in	a,(PPIB)	;get MSB
	ld	h,a
	jr	IDE_Idle	;turn off all controls

;;; wait for BUSY=0, READY=0, DRQ=don't care
IDE_Wait_Ready:
	ld	c,7		;address 7 for status
	call	IDE_Reg_Read
	and	a,0c0h
	cp	a,40h
	jr	nz,IDE_Wait_Ready
	ret

