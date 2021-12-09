
#define B_ROW_MASK 0xc7
#define D_ROW_MASK 0x70
#define C_COL_MASK 0x3f
#define D_COL_MASK 0x0c
#define D_LED_MASK 0x80

// location of shift/ctrl/alt
#define SHIFT_L_ROW 3
#define SHIFT_L_BIT 0
#define SHIFT_R_ROW 5
#define SHIFT_R_BIT 6
#define CTRL_ROW 2
#define CTRL_BIT 0
#define ALT_ROW 7
#define ALT_BIT 0

// bits for shift functions
#define CTRL 8
#define SHIFT 9
#define ALT 10
#define HIT 11


// read column values as one byte
#define COL_IN ((PINC & C_COL_MASK) | ((PIND & D_COL_MASK) << 4));

//
// low-level scan
// loop over 8 rows, set bit for each low one at a time
// read and store column value at supplied memory
//
void onescan( uint8_t* cp) {
  PORTB = B_ROW_MASK - (1 << 0);      *cp++ = COL_IN;
  PORTB = B_ROW_MASK - (1 << 1);      *cp++ = COL_IN;
  PORTB = B_ROW_MASK - (1 << 2);      *cp++ = COL_IN;
  PORTB = B_ROW_MASK;

  PORTD = D_COL_MASK + D_ROW_MASK - (1 << 4);      *cp++ = COL_IN;
  PORTD = D_COL_MASK + D_ROW_MASK - (1 << 5);      *cp++ = COL_IN;
  PORTD = D_COL_MASK + D_ROW_MASK - (1 << 6);      *cp++ = COL_IN;
  PORTD = D_COL_MASK + D_ROW_MASK;

  PORTB = B_ROW_MASK - (1 << 6);      *cp++ = COL_IN;
  PORTB = B_ROW_MASK - (1 << 7);      *cp++ = COL_IN;
}


static uint8_t scan_cur[8], scan_last[8], scan_diff[8];
static uint8_t shifty, code;

//
// scan the keyboard, call putq() for each hit seen
// check ctrl+shift state for each hit and return in upper byte
//
void scan() {
  register uint8_t i, j, b;
  onescan( scan_cur);
  shifty = 0;

  // get diffs, set hit flag if any seen
  for( i=0; i<8; i++) {
    if( scan_diff[i] = (scan_cur[i] ^ scan_last[i]))
      shifty |= (1<<HIT);
  }

  // if any hits seen, capture ctrl+shift state
  if( shifty & (1<<HIT)) {
    if( !(scan_cur[SHIFT_L_ROW] & (1<<SHIFT_L_BIT)))
      shifty |= (1 << SHIFT);
    if( !(scan_cur[SHIFT_R_ROW] & (1<<SHIFT_R_BIT)))
      shifty |= (1 << SHIFT);
    if( !(scan_cur[CTRL_ROW] & (1<<CTRL_BIT)))
      shifty |= (1 << CTRL);
  }

  // now decode the hits and copy the current scan
  for( i=0; i<8; i++) {		/* loop over rows */
    if( scan_diff[i]) {		/* any change in scan? */
      // process 1's in difference
      for( j=0, b=1; j<8; j++, b<<=1) { /* loop over columns */
	if( !(scan_cur[i] & b)) {  	/* key press */
	  code = 1+((i << 3) | j);
	  putq( (shifty << 8) | code);
	}
      }
    }
    scan_last[i] = scan_cur[i];
  }
}

