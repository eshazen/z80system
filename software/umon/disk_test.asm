
	include "DISKDEF.LIB"

	org	100h

	disks	2
	;; system disk is standard one, with no skew
	diskdef	0,1,26,0,1024,243,64,64,2
	;; hard disk
	diskdef 1,1,26,0,8192,1024,1024,0,0

;		dsk	set	0
;		rept	3
;	dsk	set	dsk+1
;		diskdef	%dsk,0
;		endm
		endef



	end
	
