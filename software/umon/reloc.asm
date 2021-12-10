;;;
;;; reloc.asm - relocate code presented as data and jump to it
;;;
	org	0H

DEST:	equ	08100H		;destination for code

	ld	hl,RCODE
	ld	de,DEST
	ld	bc,RSIZE
	ldir

	jp	dest

	;; include code here
	;; created with com2db.c
	
	include "umon_db.asm"
	end
