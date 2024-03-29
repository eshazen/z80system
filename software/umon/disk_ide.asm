;;; IDE read/write routines
;;;
;;; IDE_Initialize			setup PPI, reset drive
;;; IDE_Byte_Read			read byte from reg C to A
;;; IDE_Word_Read			read word from reg C to HL
;;; IDE_Byte_Write			write data in A to reg C (uses B)
;;; IDE_Word_Write			write data in HL to reg C (uses B)
;;; IDE_Get_Status     			read status register to A
;;; IDE_Wait_Ready			wait for busy=0, ready=1
;;; IDE_Wait_DRQ			wait for DRQ=1
;;; IDE_Do_Cmd				issue a command from A (use b, c)
;;; IDE_Setup_LBA			set LBA from DEHL
;;; IDE_Read_ID				Read 512 byte ID to (DE)
;;; IDE_Read_Sector			Read sector with LBA=DEHL to IX
;;; IDE_Write_Sector			Write 512 byte sector to DEHL from (IX)

;;; Initial version re-writes C register with new values
;;; could use "direct bit" operations on 8255 to save a few instructions
;;;
;;; Basic IDE port signalling:
;;;   
;;;   assert A0-A2, /CSn		port C bits 0-3
;;;   for READ:
;;;     assert /RD                      port C bit 6
;;;     capture data                    read port A (B)
;;;     deassert /RD, /CSn              port C bit 3, 6
;;;   for WRITE:
;;;     set PPI direction to OUTPUT     CTRL = 80h
;;;     set output data (8 or 16 bits)  write port A (B)
;;;     assert /WR                      port C bit 5
;;;     deassert /WR, /CSn              port C bits 3,5
;;;     set PPI direction to INPUT      CTRL = 92h
;;; 

;;; Mods:
;;; 2021-12-18:  modify sector read/write to (optionally)
;;; do only 128 bytes for CP/M

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
;;; IDE registers (only 0-7 used for now using /CS0)
IDE_DATA: equ	0		;data R/W
IDE_ERR: equ	1		;R: error code
IDE_NSEC: equ	2		;number of sectors to transfer
IDE_LBA0: equ	3		;LBA 0 (0:7)
IDE_LBA1: equ	4		;LBA 1 (8:15)
IDE_LBA2: equ	5		;LBA 2 (16:23)
IDE_LBA3: equ	6		;LBA 3 (24:27) upper bits "1110"
IDE_CMD: equ	7		;IDE command / status
;;; IDE commands
IDE_ID:	equ	0ech		;identify drive
IDE_RS:	equ	20h		;read sectors w/ retry
IDE_WS:	equ	30h		;write sectors /w retry
;;; IDE status bits in register 7
IDE_BSY: equ	80h		;busy = 1
IDE_RDY: equ	40h		;ready = 1
IDE_DRQ: equ	08h		;DRQ = 1

IDE_REG6: equ	0e0h		;1110 0000 = LBA, select master

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
	push	af
	xor	a		;turn off all control signals
	out	(PPIC),a
	call	IDE_Wait_Ready
	pop	af
	ret

;;; ----------------------------------------
	ifdef disk_spindown

;;; set IDE timeout to A * 5s
IDE_SetTimeout:
	push	af
	call	IDE_Wait_Ready
	ld	c, IDE_NSEC
	pop	af
	call	IDE_Byte_write
	ld	a,0e2h		;command to set timeout
	call	IDE_Do_Cmd
	ret

	endif
;;; ----------------------------------------

;;; read IDE register C, 8-bit data to A
IDE_Byte_Read:
	push	hl
	call	IDE_Word_Read
	ld	a,h
	pop	hl
	ret
	
;;; read IDE register C, 16-data to HL
IDE_Word_Read:
	ld	a,c		;get address
	or	PPCS0		;set /CS0
	out	(PPIC),a	;enable both
	add	a,PPRD		;set RD=1
	out	(PPIC),a
	push	af
	in	A,(PPIA)	;get LSB
	ld	h,a		;bit endian
	in	a,(PPIB)	;get MSB
	ld	l,a
	pop	af
;;; turning of /RD before /CS0 seems key
	sub	a,PPRD
	out	(PPIC),a
;;; FIXME any reason not to just leave /CS0 on?
	ret

;	jr	IDE_Idle	;turn off all controls

;;; write IDE register C with data in A
IDE_Byte_Write:
	ld	b,a		;data to B
	ld	a,PP_OUT
	out	(PPICTL),a      ;change port A/B direction to out for writing
	
	ld	a,b		;get data
	out	(PPIA),a	;set low data
	
	ld	a,c		;get address
	or	PPCS0		;set /CS0
	out	(PPIC),a	;set address, /CS0
	
	add	a,PPWR		;set WR=1
	out	(PPIC),a
	
	sub	a,PPWR		;set WR=0
	out	(PPIC),a

	ld	a,c
	out	(PPIC),a	;set /CS0=0
	
;;; fixme should turn off write (only) first
	ld	a,PP_IN
	out	(PPICTL),a	;back to input mode
	ret

;;; write IDE register C with 16-bit data in HL
IDE_Word_Write:	
	ld	a,PP_OUT
	out	(PPICTL),a      ;change port A/B direction to out for writing
	ld	a,c		;get address
	or	PPCS0		;set /CS0
	out	(PPIC),a	;set address, /CS0
	
	push	af
	ld	a,h		;get data MSB
	out	(PPIA),a	;set low data
	ld	a,l
	out	(PPIB),a	;set high data
	pop	af

	or	PPWR		;set WR=1
	out	(PPIC),a

	sub	a,PPWR		;set WR=0
	out	(PPIC),a

	ld	a,c
	out	(PPIC),a	;set WR=0
	ld	a,PP_IN
	out	(PPICTL),a	;back to input mode
	ret


;;; 
IDE_Get_Status:	
	ld	c,7		;address 7 for status
	call	IDE_Byte_Read
	ret
	
;;; wait for BUSY=0, READY=0, DRQ=don't care
IDE_Wait_Ready:
	call	IDE_Get_Status
	and	a,IDE_BSY+IDE_RDY
	cp	a,IDE_RDY
	ret	z
	jr	IDE_Wait_Ready

;;; wait for DRQ (uses C, A)
IDE_Wait_DRQ:
	call	IDE_Get_Status
	and	a,IDE_DRQ+IDE_BSY ;expect DRQ=1, BSY=0
	cp	IDE_DRQ
	ret	z
	jr	IDE_Wait_DRQ

;;; Issue IDE command from A
IDE_Do_Cmd:
	ld	b,a		;save data
	call	IDE_Wait_Ready	;wait for ready
	ld	a,b
	ld	c,IDE_CMD	;CMD register
	jr	IDE_Byte_Write	;go write it
	
;;; set LBA from DEHL
IDE_Setup_LBA:	
	ld	c,IDE_LBA0	;register 3
	ld	a,l
	call	IDE_Byte_Write
	inc	c		;register 4
	ld	a,h
	call	IDE_Byte_Write
	inc	c		;register 5
	ld	a,e
	call	IDE_Byte_Write
	inc	c		;register 6
	ld	a,d
	or	IDE_REG6
	call	IDE_Byte_Write
	ret


;;; Read sector (128 or 512 bytes depending on 'sec128') from DEHL to (IX)
;;; return with DE pointing to next location after end of user buffer
IDE_Read_Sector:
	call	IDE_Wait_Ready
	call	IDE_Setup_LBA
	
	ld	c,IDE_NSEC	;sector count register
	ld	a,1
	call	IDE_Byte_Write

	ld	a,IDE_RS	;read sector command
	push	ix		;dest addr to stack

	call	IDE_Do_Cmd
	call	IDE_Wait_DRQ
ifdef sec128
	ld	b,40h		;count 40h words 80h bytes
else
	ld	b,0		;count 0=256 words
endif	
	pop	de		;dest addr to DE
	ld	c,0		;data in IDE register 0
IDE_RSW:
	call	IDE_Word_Read
	ld	a,h
	ld	(de),a
	inc	de
	ld	a,l
	ld	(de),a
	inc	de
	djnz	IDE_RSW		;loop over desired words
ifdef sec128
	;;  read and discard remaining 192 words
	ld	b,0c0h
ide_disw:
	call	IDE_Word_Read
	djnz	ide_disw
endif
	call	IDE_Get_Status
	ret

;;; Write sector (128 or 512 bytes) to DEHL from (IX)
;;; return status register value in A
IDE_Write_Sector:
	call	IDE_Wait_Ready
	call	IDE_Setup_LBA
	
	ld	c,IDE_NSEC	;sector count register
	ld	a,1
	call	IDE_Byte_Write

	ld	a,IDE_WS	;write sector command
	push	ix		;addr to stack

	call	IDE_Do_Cmd
	call	IDE_Wait_DRQ

	ifdef	sec128
;;; ----------------------------------------
	ld	b,40h	  ; 128-byte mode, 40h words
;;; ----------------------------------------
	else
	ld	b,0	  ; 512-byte mode, 100h words
;;; ----------------------------------------
	endif
	
	pop	de		;pointer to de

IDE_WSW:
	ld	a,(de)
	ld	h,a
	inc	de
	ld	a,(de)
	ld	l,a
	inc	de

;	call	IDE_Wait_DRQ	;need each time?

	ld	c,0		;register 0 for data
	call	IDE_Word_Write
	djnz	IDE_WSW

;;; ----------------------------------------
	ifdef	sec128
	;; write zeros on rest of physical sector
	ld	a,0
	ld	b,0c0h		;192 words remaining

IDEFS:	call	IDE_Word_Write
	djnz	IDEFS
	endif
;;; ----------------------------------------

	call	IDE_Wait_Ready
	call	IDE_Get_Status
	ret
	
