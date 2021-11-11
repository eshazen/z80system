;;;
;;; reloc.asm - relocate code presented as data and jump to it
;;;
	org	100H

DEST:	equ	0D000H		;destination for code

	ld	hl,RCODE
	ld	de,DEST
	ld	bc,RSIZE
	ldir

	jp	dest

	;; include code here
	;; created with com2db.c
	
	include "hexrel.dat"
	end
