/*
 * main.c - serial keyboard
 *
 * columns are input
 * rows are output
 *
 * ASCII (eventually) output at 2400 baud
 * works fine for now but no shift or ctrl action
 */

#include <avr/io.h>
#include <util/delay.h>
#include <stdlib.h>

// provides: normal[] and shifted[]
#include "ascii.h"

#define MAXQUE 16
static unsigned char queue[MAXQUE];
static unsigned char qh, qt;

#define full() (((qt+1)&(MAXQUE-1))==qh)
#define empty() (qt==qh)

void putq( unsigned char ch) {
  if( !full()) {
    queue[qh] = ch;
    qh = (qh + 1) & (MAXQUE-1);
  }
}

unsigned char getq() {
  unsigned char ch = 0;
  if( !empty()) {
    ch = queue[qt];
    qt = (qt+1) & (MAXQUE-1);
  }
  return ch;
}

// output character to serial port
void outchr( unsigned char v) {
  while (! (UCSRA & (1 << UDRE)) );
  UDR = v;
}

// output two-digit hex value
void outhex( unsigned char v) {
  char buff[3];

  itoa( v, buff, 16);

  outchr(buff[0]);
  outchr(buff[1]);
}

// output CRLF
void crlf() {
  outchr( 0xd);
  outchr( 0xa);
}


#define B_ROW_MASK 0xc7
#define D_ROW_MASK 0x70
#define C_COL_MASK 0x3f
#define D_COL_MASK 0x0c
#define D_LED_MASK 0x80

static unsigned char last_col[8];

// read column and process
unsigned char read_col( unsigned char row) {
  static unsigned char code, dcol, i, b;
  code = 0;
  unsigned char col = (PINC & C_COL_MASK) | ((PIND & D_COL_MASK) << 4);
  if( (dcol = (col ^ last_col[row]))) {	/* change in data? */
    if( !(dcol & col)) {
      // process 1's in difference
      for( i=0, b=1; i<8; i++, b<<=1) {
	if( !(col & b)) {  	/* key press */
	  code = 1+((row << 3) | i);
	}
      }
    }
    last_col[row] = col;
  }
  if( code)
    putq( code);
}


unsigned char col;
unsigned char rowB, rowD;
int main(void)
{
  unsigned char code;

  /* ubrr = F_OSC/(baud*16)-1 */
  int ubrr = 25;		/* should be 25 for 2400 baud */

  // set rows (and LED) as output
  DDRD = D_ROW_MASK | D_LED_MASK;
  DDRB = B_ROW_MASK;

  // set pull-ups for columns
  PORTC = C_COL_MASK;
  PORTD = D_COL_MASK;

  UCSRB = (1 << TXEN);		/* enable USART Tx */

  UBRRL = (unsigned char)(ubrr); /* set baud rate */
  UBRRH = (unsigned char)(ubrr >> 8);
  // set one stop bit, 8 bit characters, no parity, 
  UCSRC = (1 << UCSZ0) | (1 << UCSZ1) | (1 << URSEL);
  
  while(1) {

    // loop over rows, set outputs low one at a time
    // read columns
    PORTB = B_ROW_MASK - (1 << 0);      read_col(0);
    PORTB = B_ROW_MASK - (1 << 1);      read_col(1);
    PORTB = B_ROW_MASK - (1 << 2);      read_col(2);
    PORTB = B_ROW_MASK;

    PORTD = D_COL_MASK + D_ROW_MASK - (1 << 4);      read_col(3);
    PORTD = D_COL_MASK + D_ROW_MASK - (1 << 5);      read_col(4);
    PORTD = D_COL_MASK + D_ROW_MASK - (1 << 6);      read_col(5);
    PORTD = D_COL_MASK + D_ROW_MASK;

    PORTB = B_ROW_MASK - (1 << 6);      read_col(6);
    PORTB = B_ROW_MASK - (1 << 7);      read_col(7);

    if( (code = getq())) {
      outhex( code);
      outchr( ' ');
      outhex( normal[code]);
      crlf();
    }
  }
}
