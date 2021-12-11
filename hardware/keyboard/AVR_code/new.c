/*
 * new.c - serial keyboard
 *
 * columns are input
 * rows are output
 *
 * ASCII output at 4800 baud
 * CTRL, SHIFT work as expected
 *
 */

#include <avr/io.h>
#include <util/delay.h>
#include <stdlib.h>
#include <stdint.h>

// provides: normal[] and shifted[] lookup tables
#include "ascii.h"

// output queue.  Needed because scan() may find multiple
// hits in one pass and queue them up
// (N.B. size must be a power of two)
#define MAXQUE 16
static uint16_t queue[MAXQUE];
static uint8_t qh, qt;

// provide standard queue services
#define full() (((qt+1)&(MAXQUE-1))==qh)
#define empty() (qt==qh)

void putq( uint16_t ch) {
  if( !full()) {
    queue[qh] = ch;
    qh = (qh + 1) & (MAXQUE-1);
  }
}

uint16_t getq() {
  uint16_t ch = 0;
  if( !empty()) {
    ch = queue[qt];
    qt = (qt+1) & (MAXQUE-1);
  }
  return ch;
}

// output character to serial port
void outchr( uint8_t v) {
  while (! (UCSRA & (1 << UDRE)) );
  UDR = v;
}

// output a string (for debug)
void outs( char* s) {
  while( *s) {
    outchr( *s);
    ++s;
  }
}

// output two-digit hex value (for debug)
void outhex( uint16_t v) {
  char buff[] = "        ";

  itoa( v, buff, 16);
  outs( buff);
}

// output CRLF (for debug)
void crlf() {
  outchr( 0xd);
  outchr( 0xa);
}

// masks based on wiring
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
#define CTRL 0
#define SHIFT 1
#define ALT 2
#define HIT 3


// read column values as one byte
#define COL_IN ((PINC & C_COL_MASK) | ((PIND & D_COL_MASK) << 4));

// determined experimentally that some delay is needed
// to avoid missed keys
#define dly() (_delay_us(5))

//------------------------------------------------------------
// low-level scan
// loop over 8 rows, set bit for each low one at a time
// read and store column value at supplied memory
//------------------------------------------------------------
void onescan( uint8_t* cp) {
  // this is a bit irregular due to the wiring
  PORTB = B_ROW_MASK - (1 << 0); dly();    *cp++ = COL_IN;  dly();
  PORTB = B_ROW_MASK - (1 << 1); dly();     *cp++ = COL_IN; dly();
  PORTB = B_ROW_MASK - (1 << 2); dly();     *cp++ = COL_IN; dly();
  PORTB = B_ROW_MASK;

  PORTD = D_COL_MASK + D_ROW_MASK - (1 << 4); dly(); *cp++ = COL_IN; dly();
  PORTD = D_COL_MASK + D_ROW_MASK - (1 << 5); dly(); *cp++ = COL_IN; dly();
  PORTD = D_COL_MASK + D_ROW_MASK - (1 << 6); dly(); *cp++ = COL_IN; dly();
  PORTD = D_COL_MASK + D_ROW_MASK;

  PORTB = B_ROW_MASK - (1 << 6); dly();  *cp++ = COL_IN; dly();
  PORTB = B_ROW_MASK - (1 << 7); dly();  *cp++ = COL_IN; dly();
  PORTB = B_ROW_MASK;
}


static uint8_t scan_cur[8], scan_last[8], scan_diff[8];
static uint8_t shifty, code;
static uint16_t token;

//
// scan the keyboard, call putq() for each hit seen
// check ctrl+shift state for each hit and return in upper byte
//
void scan() {
  register uint8_t row, col, bit;

  onescan( scan_cur);
  shifty = 0;			/* upper byte for CTRL+SHIFT */

  // get diffs, set hit flag if any seen
  for( row=0; row<8; row++) {
    if( (scan_diff[row] = (scan_cur[row] ^ scan_last[row])))
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
  for( row=0; row<8; row++) {		/* loop over rows */
    if( scan_diff[row]) {		/* any change in scan? */
      // process 1's in difference
      for( col=0, bit=1; col<8; col++, bit<<=1) { /* loop over columns */
	if( (scan_diff[row] & bit)		  /* difference? */
	    && !(scan_cur[row] & bit)) { /* key press (not release) */
	  code = 1+((row << 3) | col);	 /* form arbitrary code 1... */
	  token = (shifty << 8) | code;	 /* merge shift flags */
	  putq( token);			 /* put in output queue */
	}
      }
      scan_last[row] = scan_cur[row]; /* remember current scan state */
    }
  }
}


//------------------------------------------------------------
// main program... just scan repeatedly and output
//------------------------------------------------------------

int main() {
  uint16_t ch;
  uint8_t code;
  uint8_t asc;

  /* ubrr = F_OSC/(baud*16)-1 */
  int ubrr = 12;                /* 4800 baud */

  // set rows (and LED) as output
  DDRD = D_ROW_MASK | D_LED_MASK;
  DDRB = B_ROW_MASK;

  // set pull-ups for columns
  PORTC = C_COL_MASK;
  PORTD = D_COL_MASK;

  UCSRB = (1 << TXEN);          /* enable USART Tx */

  UBRRL = (uint8_t)(ubrr); /* set baud rate */
  UBRRH = (uint8_t)(ubrr >> 8);
  // set one stop bit, 8 bit characters, no parity, 
  UCSRC = (1 << UCSZ0) | (1 << UCSZ1) | (1 << URSEL);
  
  // just loop forever scanning
  while(1) {

    scan();			/* scan and push to queue any hits */

    if( (ch = getq())) {	/* get raw scan code with shift flags */
      code = ch & 0xff;		/* extract scan code */
      asc = normal[code];	/* default: normal non-shifted ascii */
      if( asc) {		/* if it was valid */
	if( ch & (1<<(SHIFT+8))) /* check for shift */
	  asc = shifted[code];	 /* use shifted table if so */
	else if( ch & (1<<(CTRL+8))) /* check for control */
	  asc &= 0x1f;		     /* adjust for control */
	outchr( asc);		     /* and output to USART */
      }
    }

    PORTB ^= D_LED_MASK;
  }
  
}
