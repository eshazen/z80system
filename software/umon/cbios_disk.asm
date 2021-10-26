;;;
;;; CP/M 2.2 BIOS for RC2014:
;;;   console on SIO port A
;;;   remote disk on SIO port B
;;; 
	
;	skeletal cbios for first level of CP/M 2.0 alteration
;
;;; below set for initial 20K system
	

;ccp:	equ	03400h		;base of ccp
;bdos:	equ	03C06h		;bdos entry
;bios:	equ	04A00h		;base of bios

ccp:	equ	0E400h		;base of ccp
bdos:	equ	0EC06h		;bdos entry
bios:	equ	0FA00h		;base of bios
	
cdisk:	equ	0004h		;address of current disk number 0=a,... l5=p
iobyte:	equ	0003h		;intel i/o byte
disks:	equ	04h		;number of disks in the system
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
;	fixed data tables for four-drive standard
;	ibm-compatible 8" disks
;	ESH:  restored sector translation
;
;	disk Parameter header for disk 00
;;; IBM standard, 2 system tracks but skew=1
dpbase:	defw	xlat0, 0000h
	defw	0000h, 0000h
	defw	dirbf, dpb00
	defw	chk00, all00
;	disk parameter header for disk 01
;;; IBM standard, 2 system tracks skew=6
	defw	xlat1, 0000h
	defw	0000h, 0000h
	defw	dirbf, dpb00
	defw	chk01, all01
;	disk parameter header for disk 02
;;; IBM standard, 2 system tracks skew=6
	defw	xlat1, 0000h
	defw	0000h, 0000h
	defw	dirbf, dpb00
	defw	chk02, all02
;	disk parameter header for disk 03
;;; IBM standard, 0 system tracks skew=6
	defw	xlat1, 0000h
	defw	0000h, 0000h
	defw	dirbf, dpb01
	defw	chk03, all03
;
;	sector translate vector
;	(standard one
xlat1:	defm	 1,  7, 13, 19	;sectors  1,  2,  3,  4
	defm	25,  5, 11, 17	;sectors  5,  6,  7,  6
	defm	23,  3,  9, 15	;sectors  9, 10, 11, 12
	defm	21,  2,  8, 14	;sectors 13, 14, 15, 16
	defm	20, 26,  6, 12	;sectors 17, 18, 19, 20
	defm	18, 24,  4, 10	;sectors 21, 22, 23, 24
	defm	16, 22		;sectors 25, 26

;;; sector translate 1:1 for now
xlat0:  defm   1,  2,  3,  4    ;sectors  1,  2,  3,  4
        defm   5,  6,  7,  6    ;sectors  5,  6,  7,  6
        defm   9, 10, 11, 12    ;sectors  9, 10, 11, 12
        defm  13, 14, 15, 16    ;sectors 13, 14, 15, 16
        defm  17, 18, 19, 20    ;sectors 17, 18, 19, 20
        defm  21, 22, 23, 24    ;sectors 21, 22, 23, 24
        defm  25, 26            ;sectors 25, 26         
	
;
dpb00:	;disk parameter block: system disks
	defw	26		;sectors per track
	defm	3		;block shift factor
	defm	7		;block mask
	defm	0		;null mask
	defw	242		;disk size-1
	defw	63		;directory max
	defm	192		;alloc 0
	defm	0		;alloc 1
	defw	16		;check size     ESH: was zero
	defw	2		;track offset
;
dpb01:	;disk parameter block: data disks
	defw	26		;SPT sectors per track
	defm	3		;BSH block shift factor
	defm	7		;BLM block mask
	defm	0		;EXM null mask
	defw	249		;DSM disk size-1
	defw	63		;DRM directory max
	defm	192		;AL0 alloc 0
	defm	0		;AL1 alloc 1
	defw	16		;CKS check size     ESH: was zero
	defw	0		;OFS track offset
;
;	end of fixed tables
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
	cp	disks		;see if valid disk number
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
	CP	disks		;must be between 0 and 3
	RET	NC		;no carry if 4, 5,...
;	disk number is in the proper range
;;; ESH:  send disk change command

	ld	a,'S'		;select disk command
	call	putc_B
	ld	a,c
	add	a,'0'
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

;;; /ESHback to original code
;	compute proper disk Parameter header address
	LD	A,(diskno)
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
	EX	DE,HL		;hl=.trans   so HL=0 if DE=0
	ADD	HL,BC		;hl=.trans (sector)
	LD 	l, (hl)		;l=trans (sector)
	LD 	h, 0		;hl=trans (sector)
	ret			;with value in hl
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
	ld	a, 'R'
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
	ld	a,'W'
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
;	scratch ram area for bdos use
begdat:	equ	$	 	;beginning of data area
dirbf:	defs	128	 	;scratch directory area
all00:	defs	31	 	;allocation vector 0
all01:	defs	31	 	;allocation vector 1
all02:	defs	31	 	;allocation vector 2
all03:	defs	31	 	;allocation vector 3
chk00:	defs	16		;check vector 0
chk01:	defs	16		;check vector 1
chk02:	defs	16	 	;check vector 2
chk03:	defs	16	 	;check vector 3
;
enddat:	equ	$	 	;end of data area
datsiz:	equ	$-begdat;	;size of data area
;hstbuf: ds	256		;buffer for host disk sector (not needed)
	end
