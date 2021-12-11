static unsigned int normal[] = {
   0x00,  // [00] 
   0x1b,  // [01] 01 ESC
   0x31,  // [02] 02 1    !
   0x33,  // [03] 03 3	#
   0x35,  // [04] 04 5	%
   0x37,  // [05] 05 7	&
   0x39,  // [06] 06 9	(
   0x2f,  // [07] 07 /	?
   0x3d,  // [08] 08 =	+
   0x09,  // [09] 09 TAB
   0x71,  // [0a] 0a q    Q
   0x65,  // [0b] 0b e	E
   0x74,  // [0c] 0c t	T
   0x75,  // [0d] 0d u	U
   0x6f,  // [0e] 0e o	O
   0x00,  // [0f] 
   0x5d,  // [10] 10 ]	}
   0x00,  // [11] 11 CTRL
   0x61,  // [12] 12 a	A
   0x64,  // [13] 13 d	D
   0x67,  // [14] 14 g	G
   0x6a,  // [15] 15 j	J
   0x6c,  // [16] 16 l	L
   0x2d,  // [17] 17 -	_
   0x0d,  // [18] 18 CR
   0x00,  // [19] 19 SHFT
   0x32,  // [1a] 1a 2	@
   0x63,  // [1b] 1b c	C
   0x62,  // [1c] 1c b	B
   0x6d,  // [1d] 1d m	M
   0x2e,  // [1e] 1e .	>
   0x5b,  // [1f] 1f [	{
   0x08,  // [20] 20 BS	DEL
   0x00,  // [21] 21 CAPS
   0x77,  // [22] 22 w	W
   0x34,  // [23] 23 4	$
   0x20,  // [24] 24 SPC
   0x38,  // [25] 25 8	*
   0x00,  // [26] 
   0x27,  // [27] 27 '	"
   0x5c,  // [28] 28 \	|
   0x60,  // [29] 29 `	~
   0x73,  // [2a] 2a s	S
   0x72,  // [2b] 2b r	R
   0x36,  // [2c] 2c 6	^
   0x69,  // [2d] 2d i	I
   0x30,  // [2e] 2e 0	)
   0x00,  // [2f] 2f SHFT
   0x00,  // [30] 
   0x7a,  // [31] 31 z	Z
   0x78,  // [32] 32 x	X
   0x66,  // [33] 33 f	F
   0x79,  // [34] 34 y	Y
   0x6b,  // [35] 35 k	K
   0x70,  // [36] 36 p	P
   0x00,  // [37] 
   0x00,  // [38] 
   0x00,  // [39] 39 ALT
   0x6e,  // [3a] 3a n	N
   0x76,  // [3b] 3b v	V
   0x68,  // [3c] 3c h	H
   0x2c,  // [3d] 3d ,	<
   0x3b,  // [3e] 3e ;	:
   0x00,  // [3f] 
};
static unsigned int shifted[] = {
   0x00,  // [00] 
   0x00,  // [01] 01 ESC
   0x21,  // [02] 02 1    !
   0x23,  // [03] 03 3	#
   0x25,  // [04] 04 5	%
   0x26,  // [05] 05 7	&
   0x28,  // [06] 06 9	(
   0x3f,  // [07] 07 /	?
   0x2b,  // [08] 08 =	+
   0x00,  // [09] 09 TAB
   0x51,  // [0a] 0a q    Q
   0x45,  // [0b] 0b e	E
   0x54,  // [0c] 0c t	T
   0x55,  // [0d] 0d u	U
   0x4f,  // [0e] 0e o	O
   0x00,  // [0f] 
   0x7d,  // [10] 10 ]	}
   0x00,  // [11] 11 CTRL
   0x41,  // [12] 12 a	A
   0x44,  // [13] 13 d	D
   0x47,  // [14] 14 g	G
   0x4a,  // [15] 15 j	J
   0x4c,  // [16] 16 l	L
   0x5f,  // [17] 17 -	_
   0x00,  // [18] 18 CR
   0x00,  // [19] 19 SHFT
   0x40,  // [1a] 1a 2	@
   0x43,  // [1b] 1b c	C
   0x42,  // [1c] 1c b	B
   0x4d,  // [1d] 1d m	M
   0x3e,  // [1e] 1e .	>
   0x7b,  // [1f] 1f [	{
   0x7f,  // [20] 20 BS	DEL
   0x00,  // [21] 21 CAPS
   0x57,  // [22] 22 w	W
   0x24,  // [23] 23 4	$
   0x00,  // [24] 24 SPC
   0x2a,  // [25] 25 8	*
   0x00,  // [26] 
   0x22,  // [27] 27 '	"
   0x7c,  // [28] 28 \	|
   0x7e,  // [29] 29 `	~
   0x53,  // [2a] 2a s	S
   0x52,  // [2b] 2b r	R
   0x5e,  // [2c] 2c 6	^
   0x49,  // [2d] 2d i	I
   0x29,  // [2e] 2e 0	)
   0x00,  // [2f] 2f SHFT
   0x00,  // [30] 
   0x5a,  // [31] 31 z	Z
   0x58,  // [32] 32 x	X
   0x46,  // [33] 33 f	F
   0x59,  // [34] 34 y	Y
   0x4b,  // [35] 35 k	K
   0x50,  // [36] 36 p	P
   0x00,  // [37] 
   0x00,  // [38] 
   0x00,  // [39] 39 ALT
   0x4e,  // [3a] 3a n	N
   0x56,  // [3b] 3b v	V
   0x48,  // [3c] 3c h	H
   0x3c,  // [3d] 3d ,	<
   0x3a,  // [3e] 3e ;	:
   0x00,  // [3f] 
};
