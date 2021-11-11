;;
;;; CP/M 2.2 BIOS for RC2014:
;;;   Disks:
;;;   A: (IDE) - 243K standard system disk with no skew
;;;              2 system tracks with CP/M
;;;   B: (IDE) - 8MB (64K records) IDE partition, no sys
;;;   C: (IDE) - 8MB (64K records) IDE partition, no sys
;;;   D: (IDE) - 8MB (64K records) IDE partition, no sys
;;;   E: (rem) - 243K remote serial disk with standard skew=6
;;;   F: (rem) - 243K remote serial disk with standard skew=6
;;;   G: (rem) - 243K remote serial disk with standard skew=6
;;;   H: (rem) - 243K remote serial disk with standard skew=6
;;;
;;; Starts up OK but crashes after a bit
;;; 
;	skeletal cbios for first level of CP/M 2.0 alteration
;
;;; below set for initial 20K system
	
	MACLIB DISKDEF

;ccp:	equ	03400h		;base of ccp
;bdos:	equ	03C06h		;bdos entry
;bios:	equ	04A00h		;base of bios

;;; probably need 62K CP/M to fit everything
MEM:	EQU	62		;CP/M system size in K
	
ccp:	equ	(MEM-7)*1024
bdos:	equ	ccp+0806h
bios:	equ	ccp+1600h
	
cdisk:	equ	0004h		;address of current disk number 0=a,... 15=p
iobyte:	equ	0003h		;intel i/o byte
nodsk:	equ	08h		;number of disks in the system (total)
rdisk:	equ	04h		;start of remote disk
;
secsiz:	equ	128		;sector size for no

	org	bios		;origin of this program
nsects:	equ	($-ccp)/128	;warm start sector count
;
;	jump vector for individual subroutines
;
	JP	boot	;cold start
wboote:	JP	wboot	;warm start
	JP	const	;console status
	JP	conin	;console character in
	JP	conout	;console character out
	JP	list	;list character out
	JP	punch	;punch character out
	JP	reader	;reader character out
	JP	home	;move head to home position
	JP	seldsk	;select disk
	JP	settrk	;set track number
	JP	setsec	;set sector number
	JP	setdma	;set dma address
	JP	read	;read disk
	JP	write	;write disk
	JP	listst	;return list status
	JP	sectran	;sector translate


;
;	individual subroutines to perform each function
boot:	;simplest case is to just perform parameter initialization
	LD	sp, 80h		;use space below buffer for stack <ESH add>
	XOR	a		;zero in the accum
	LD	(iobyte),A	;clear the iobyte
	LD	(cdisk),A	;select disk zero
	;; set RC2014 memory map to all RAM
	out	(30h),a		;reset memory page thing (back to ROM)
	out	(38h),a		;increment memory page thing (all RAM)
	call	io_init		;set up the SIO
	call	IDE_Initialize	;initialize the IDE
	JP	gocpm		;initialize and go to cp/m
;
wboot:	;simplest case is to read the disk until all sectors loaded
	LD	sp, 80h		;use space below buffer for stack
	LD 	c, 0		;select disk 0
	call	seldsk
	call	home		;go to track 00
;
	LD 	b, nsects	;b counts * of sectors to load
	LD 	c, 0		;c has the current track number
	LD 	d, 2		;d has the next sector to read
;	note that we begin by reading track 0, sector 2 since sector 1
;	contains the cold start loader, which is skipped in a warm start
	LD	HL, ccp		;base of cp/m (initial load point)
load1:	;load	one more sector
	PUSH	BC		;save sector count, current track
	PUSH	DE		;save next sector to read
	PUSH	HL		;save dma address
	LD 	c, d		;get sector address to register C
	call	setsec		;set sector address from register C
	pop	BC		;recall dma address to b, C
	PUSH	BC		;replace on stack for later recall
	call	setdma		;set dma address from b, C
;
;	drive set to 0, track set, sector set, dma address set
	call	read
	CP	00h		;any errors?
	JP	NZ,wboot	;retry the entire boot if an error occurs
;
;	no error, move to next sector
	pop	HL		;recall dma address
	LD	DE, 128		;dma=dma+128
	ADD	HL,DE		;new dma address is in h, l
	pop	DE		;recall sector address
	pop	BC		;recall number of sectors remaining, and current trk
	DEC	b		;sectors=sectors-1
	JP	Z,gocpm		;transfer to cp/m if all have been loaded
;
;	more	sectors remain to load, check for track change
	INC	d
	LD 	a,d		;sector=27?, if so, change tracks
	CP	27
	JP	C,load1		;carry generated if sector<27
;
;	end of	current track,	go to next track
	LD 	d, 1		;begin with first sector of next track
	INC	c		;track=track+1
;
;	save	register state, and change tracks
	PUSH	BC
	PUSH	DE
	PUSH	HL
	call	settrk		;track address set from register c
	pop	HL
	pop	DE
	pop	BC
	JP	load1		;for another sector
;
;	end of	load operation, set parameters and go to cp/m
gocpm:
	LD 	a, 0c3h		;c3 is a jmp instruction
	LD	(0),A		;for jmp to wboot
	LD	HL, wboote	;wboot entry point
	LD	(1),HL		;set address field for jmp at 0
;
	LD	(5),A		;for jmp to bdos
	LD	HL, bdos	;bdos entry point
	LD	(6),HL		;address field of Jump at 5 to bdos
;
	LD	BC, 80h		;default dma address is 80h
	call	setdma
;
;	ei			;enable the interrupt system <ESH: nope!>
	LD	A,(cdisk)	;get current disk number
	cp	nodsk		;see if valid disk number
	jp	c,diskok	;disk valid, go to ccp
	ld	a,0		;invalid disk, change to disk 0
diskok:	LD 	c, a		;send to the ccp
	JP	ccp		;go to cp/m for further processing
;
;
;	simple i/o handlers (must be filled in by user)
;	in each case, the entry point is provided, with space reserved
;	to insert your own code
;
const:	;console status, return 0ffh if character ready, 00h if not
	xor	a
	call	rxrdy
	ret	z
	dec	a
	ret

conin:	;console character into register a
	jp	getc

conout:	;console character output from register c
	ld	a,c
	jp	putc

list:	;list character from register c
	LD 	a, c	  	;character to register a
	ret		  	;null subroutine
;
listst:	;return list status (0 if not ready, 1 if ready)
	XOR	a	 	;0 is always ok to return
	ret
;
punch:	;punch	character from	register C
	LD 	a, c		;character to register a
	ret			;null subroutine
;
;
reader:	;reader character into register a from reader device
	LD     a, 1ah		;enter end of file for now (replace later)
	AND    7fh		;remember to strip parity bit
	ret

;
;
;	i/o drivers for the disk follow
;	for now, we will simply store the parameters away for use
;	in the read and write	subroutines
;
home:	;move to the track 00	position of current drive
;	translate this call into a settrk call with Parameter 00
	LD     c, 0		;select track 0
	call   settrk
	ret			;we will move to 00 on first read/write
;
seldsk:	;select disk given by register c
	;; return HL=0 or disk parameter header address
	LD	HL, 0000h	;error return code
	LD 	a, c
	LD	(diskno),A
	CP	nodsk		;must be between 0 and nodsk-1
	RET	NC		;no carry if >= nodsk
	
;	disk number is in the proper range
	cp	rdisk		;check for remote disk
	jr	c,ldisk

	;; send command to change remote disk
	ld	a,'S'		;select disk command
	call	putc_B
	ld	a,c
	add	a,'0'-rdisk
	call	putc_B
	ld	a,0ah		;send \n
	call	putc_B
;;
	call	getc_B		;should be 'K' or 'E'

	push	af
;;; look for control char to terminate
selfin:	call	getc_B
	cp	20h		;wait for control char to terminate
	jr	nc,selfin
	pop	af

	cp	a,'K'
	ret	nz

;	compute proper disk Parameter header address
ldisk:	LD	A,(diskno)
	LD 	l, a		;l=disk number 0, 1, 2, 3
	LD 	h, 0		;high order zero
	ADD	HL,HL		;*2
	ADD	HL,HL		;*4
	ADD	HL,HL		;*8
	ADD	HL,HL		;*16 (size of each header)
	LD	DE, dpbase
	ADD	HL,DE		;hl=,dpbase (diskno*16) Note typo here in original source.
seldr:	ret
;
settrk:	;set track given by register c
	LD 	a, c
	LD	(track),A
	ret
;
setsec:	;set sector given by register c
	LD 	a, c
	LD	(sector),A
	ret
;
;
sectran:
;;; translate the sector given by bc using the
;;; translate table given by de
	ld	a,e		;check for table = 0
	or	d
	jr	z,notran
	;; continue translating
	EX	DE,HL		;hl=.trans   so HL=0 if DE=0
	ADD	HL,BC		;hl=.trans (sector)
	LD 	l, (hl)		;l=trans (sector)
	LD 	h, 0		;hl=trans (sector)
	ret			;with value in hl
	;; no translation, just copy HL <= BC
notran:	ld	l,c
	ld	h,b
	ret
;
setdma:	;set	dma address given by registers b and c
	LD 	l, c		;low order address
	LD 	h, b		;high order address
	LD	(dmaad),HL	;save the address
	ret
;
read:
;Read one CP/M sector from disk.
;Return a 00h in register a if the operation completes properly, and 0lh if an error occurs during the read.
;Disk number in 'diskno'
;Track number in 'track'
;Sector number in 'sector'
;Dma address in 'dmaad' (0-65535)
;
	ld	a,(diskno)
	cp	rdisk		;check for remote disk
	jr	nc,rrdsk	;go if so
	;;  else do IDE read
	call	setuprw
	ld	ix,hstbuf
	call	IDE_Read_Sector	;read 512 bytes to hstbuf
	ld	hl,(dmaad)	;copy 128 bytes to user
	ex	de,hl
	ld	hl,hstbuf
	ld	bc,128
	ldir
	jr	rwok

rrdsk:	ld	a, 'R'
	call	send_rw_cmd
	ld	a,0ah		;send \n
	call	putc_B
	
;;; check response code
	call	getc_B		;should be 'K' or 'E'
	cp	a,'K'
	jr	z,rddat
	
rderr:	ld	a,1		;error
	jr	rdfin

;;; read 128*2 bytes, convert to binary, store
rddat:	ld	hl,(dmaad)
	ld	e,secsiz
rdnxt:	call	getc_B
	ld	b,a
	call	getc_B
	ld	c,a
	call	ihex2
	ld	(hl),a
	inc	hl
	dec	e
	jr	nz,rdnxt
	ld	a,0		;return OK

;;; finish up with return code in A
rdfin:	push	af
rdf1:	call	getc_B
	cp	20h		;wait for control char to terminate
	jr	nc,rdf1
	pop	af
	
	ret			;return code
	
;;; send command R/W in A
;;; send track and sector no as hex
send_rw_cmd:	
	call	putc_B		;send command
	ld	a,' '
	call	putc_B
	ld	a,(track)
	call	sendhex2
	ld	a,' '
	call	putc_B
	ld	a,(sector)

;;; send 2 bytes hex from A to SIO (uses B, C)
sendhex2:	
	call tohex2		;convert value in A to hex in B, C
	ld	a,b
	call	putc_B
	ld	a,c
	jp	putc_B

write:
;Write one CP/M sector to disk.
;Return a 00h in register a if the operation completes properly, and 01h if an error occurs during the read or write
;Disk number in 'diskno'
;Track number in 'track'
;Sector number in 'sector'
;Dma address in 'dmaad' (0-65535)
	ld	a,(diskno)	;0-3 is local (IDE) disk
	cp	rdisk		;check for remote disk
	jr	nc,wrdsk	;go if so
	;; else do IDE action
	ld	hl,(dmaad)	;copy 128 bytes to hstbuf
	ld	de,hstbuf
	ld	bc,128
	ldir
	call 	setuprw
	ld	ix,hstbuf
	call	IDE_Write_Sector

rwok:	sub	a,50h
	ret	z
	
badrw:	ld	a,1
	ret

	;; remote write
wrdsk:	ld	a,'W'
	call	send_rw_cmd
	ld	a,' '
	call	putc_B
;;; send 128 bytes of data
	ld	hl,(dmaad)
	ld	e,secsiz
wrdat:	ld	a,(hl)
	call	sendhex2
	inc	hl
	dec	e
	jr	nz,wrdat
	;; send \n
	ld	a,0ah
	call	putc_B
	
;;; look for response 'K' or other
	call	getc_B
	sub	a,'K'		;if 'K', a is zero
	jr	z,wrok
	inc	a		;else set a to 1
wrok:	push	af		;save return code

	;;; look for control char to terminate
wrfin:	call	getc_B
	cp	20h		;wait for control char to terminate
	jr	nc,wrfin

	pop	af
	ret

;;; setup LBA regs for read/write
;;;   LBA is in D, E, H, L
setuprw:
	call	IDE_Get_Status
	cp	50h
	jr	nz,badrw
	
	ld	d,0
	ld	a,(diskno)
	ld	e,a
	ld	a,(track)
	ld	h,a
	ld	a,(sector)
	ld	l,a
	ret

;;; ------------------------------------------------------------
;;; hex utility and console routines
;;;
;;; tohex1      convert A to hex in A
;;; tohex2      convert A to hex in B, C
;;; ihex1       convert A hex to binary in A (NC if valid)
;;; ihex2       convert B, C hex to binary in A
;;; ------------------------------------------------------------

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

;;; convert ASCII hex in B, C to binary in A
;;; NC if valid hex
ihex2:	push	de
	ld	a,b		;get MSB hex
	call	ihex1		;convert it
	jr	c,ihex2a	;error- bail out
	rlca			;shift over
	rlca
	rlca
	rlca
	and	0f0h		;scrape unwanted bits
	ld	d,a		;save MSB
	ld	a,c		;get LSB hex
	call	ihex1
	jr	c,ihex2a	;bail on errir
	or	d		;merge partial

ihex2a:	pop	de
	ret

;;; convert binary value 0-15 in A to hex character
tohex1:	and	a,0fh
	add	a,'0'
	cp	'9'+1
	ret	c
	add	a,'A'-'0'-10
	ret

;;; convert binary value 0-255 in A to hex characters in B, C
tohex2:	push	af
	call	tohex1
	ld	c,a
	pop	af
	rrca
	rrca
	rrca
	rrca
	call	tohex1
	ld	b,a
	ret

	INCLUDE "serial.asm"
	INCLUDE "disk_ide.asm"
	
;
;	the remainder of the cbios is reserved uninitialized
;	data area, and does not need to be a Part of the
;	system	memory image (the space must be available,
;	however, between"begdat" and"enddat").
;
track:	defs	2		;two bytes for expansion
sector:	defs	2		;two bytes for expansion
dmaad:	defs	2		;direct memory address
diskno:	defs	1		;disk number 0-15
;
;;- ;	scratch ram area for bdos use
;;- begdat:	equ	$	 	;beginning of data area
;;- dirbf:	defs	128	 	;scratch directory area
;;- all00:	defs	31	 	;allocation vector 0
;;- all01:	defs	31	 	;allocation vector 1
;;- all02:	defs	31	 	;allocation vector 2
;;- all03:	defs	31	 	;allocation vector 3
;;- chk00:	defs	16		;check vector 0
;;- chk01:	defs	16		;check vector 1
;;- chk02:	defs	16	 	;check vector 2
;;- chk03:	defs	16	 	;check vector 3
;;- ;
;;- enddat:	equ	$	 	;end of data area
;;- datsiz:	equ	$-begdat;	;size of data area
	
hstbuf: ds	512		;buffer for host disk sector
	
;	each parameter-list-i takes the form
;		dn,fsc,lsc,[skf],bls,dks,dir,cks,ofs,[0]
;	where
;	dn	is the disk number 0,1,...,n-1
;	fsc	is the first sector number (usually 0 or 1)
;	lsc	is the last sector number on a track
;	skf	is optional "skew factor" for sector translate
;	bls	is the data block size (1024,2048,...,16384)
;	dks	is the disk size in bls increments (word)
;	dir	is the number of directory elements (word)
;	cks	is the number of dir elements to checksum
;	ofs	is the number of tracks to skip (word)
;	[0]	is an optional 0 which forces 16K/directory entry
;


	;; try defining disks using tables
	disks	8

	;; IDE disks
	diskdef	0,1,26,1,1024,243,64,64,2     ;A
	diskdef 1,0,255,0,8192,1024,1024,0,0  ;B
	diskdef 2,0,255,0,8192,1024,1024,0,0  ;C
	diskdef 3,0,255,0,8192,1024,1024,0,0  ;D

	;; remote disks
	;; system disk is standard one, with no skew
	diskdef	4,1,26,1,1024,243,64,64,2 ;E
	;; next disks have skew=6
	diskdef	5,1,26,6,1024,243,64,64,2 ;F
	diskdef	6,1,26,6,1024,243,64,64,2 ;G
	diskdef	7,1,26,6,1024,243,64,64,2 ;H

	endef
	
;
;	end of fixed tables
	end
