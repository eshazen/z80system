;;;
;;; CP/M 2.2 BIOS for RC2014:
;;;   console on SIO port A
;;;   IDE drive with 128-byte sectors
;;;     For now:  LBA 0-7 is sector
;;; 		  LBA 8-15 is track
;;;               LBA 16-17 is disk
;;;
;;; This version just uses the first 128 bytes of each 512 byte host sector
;;; 4 disks configured:
;;;   A       - 241K IBM standard
;;;   B, C, D - 8M 64K block "hard drives" (256 tracks, 256 sectors)
;;; 
	MACLIB DISKDEF
	
;	skeletal cbios for first level of CP/M 2.0 alteration
;
;;; below set for initial 20K system
	

;ccp:	equ	03400h		;base of ccp
;bdos:	equ	03C06h		;bdos entry
;bios:	equ	04A00h		;base of bios

;;; this CBIOS requires 63k max so enddat < ffff
MEM:	EQU	63		;CP/M system size in K
	
ccp:	equ	(MEM-7)*1024
bdos:	equ	ccp+0806h
bios:	equ	ccp+1600h

cdisk:	equ	0004h		;address of current disk number 0=a,... l5=p
iobyte:	equ	0003h		;intel i/o byte
nodsk:	equ	04h		;number of disks in the system
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
	
	;; (disk tables at end)
	
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
	jp	putc_B		;SIO port B
	ret		  	;null subroutine
;
listst:	;return list status (0 if not ready, 1 if ready)
	xor	a
	call	txrdy_B
	ret	z
	inc	a
	ret
;
punch:	;punch	character from	register C
	LD 	a, c		;character to register a
	jp	putc_B		;SIO port B
	ret			;null subroutine
;
;
reader:	;reader character into register a from reader device
	call	getc_B
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
	CP	nodsk		;must be between 0 and 3
	RET	NC		;no carry if 4, 5,...
	LD	(diskno),A
;	disk number is in the proper range
;	compute proper disk Parameter header address
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
	call	setuprw
	ld	ix,hstbuf
	call	IDE_Read_Sector	;read 512 bytes to hstbuf
	ld	hl,(dmaad)	;copy 128 bytes to user
	ex	de,hl
	ld	hl,hstbuf
	ld	bc,128
	ldir
	jr	rwok
	
write:
;Write one CP/M sector to disk.
;Return a 00h in register a if the operation completes properly, and 01h if an error occurs during the read or write
;Disk number in 'diskno'
;Track number in 'track'
;Sector number in 'sector'
;Dma address in 'dmaad' (0-65535)
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

	INCLUDE "serial.asm"
	INCLUDE "disk_ide.asm"

codend:	equ	$
	
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

diskparm:	equ	$

	;; try defining disks using tables
	disks	4
diskp0:	equ $
	;; system disk is standard one, with no skew
	diskdef	0,1,26,1,1024,243,64,64,2
diskp1:	equ $
	;; 8MB hard disk B:
	;; 256 sectors/track (32kB/track)
	;; 256 tracks so 256*256*128 = 8 MiB
	diskdef 1,0,255,0,8192,1024,256,0,0
diskp2:	equ $
	diskdef 2,0,255,0,8192,1024,256,0,0
diskp3:	equ $
	diskdef 3,0,255,0,8192,1024,256,0,0
diskp4:	equ $
	endef

diskend: equ $
	
hstbuf: ds	512		;buffer for host disk sector
	end
