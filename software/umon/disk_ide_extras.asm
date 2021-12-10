;;; disk_ide_extras.asm
;;; extra functions not used by CBIOS
;;; in separate file to save CBIOS space
	
;;; Read ID to (DE) - 512 bytes - big-endian
IDE_Read_ID:
	push	de
	call	IDE_Wait_Ready
	ld	hl,0		;probably not needed
	ld	de,0
	call	IDE_Setup_LBA	;mainly for reg 6
	ld	a,IDE_ID

	call	IDE_Do_Cmd
	call	IDE_Wait_DRQ
	ld	b,0		;count
	pop	de
	ld	c,0		;data at address 0
IDE_RIW:
	call	IDE_Word_Read
	ld	a,l
	ld	(de),a
	inc	de
	ld	a,h
	ld	(de),a
	inc	de
	djnz	IDE_RIW
	ret
