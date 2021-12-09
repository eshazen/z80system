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
#include <stdint.h>

// provides: normal[] and shifted[]
#include "ascii.h"

#define MAXQUE 16
static uint16_t queue[MAXQUE];
static uint8_t qh, qt;

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

void outs( char* s) {
  while( *s) {
    outchr( *s);
    ++s;
  }
}

// output two-digit hex value
void outhex( uint16_t v) {
  char buff[] = "        ";

  itoa( v, buff, 16);
  outs( buff);
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
#define TEST 11

static uint8_t last_col[8];

// read column and process
void read_col( uint8_t row) {
  static uint8_t dcol, i, b;
  uint16_t code = 0;

  uint8_t col = (PINC & C_COL_MASK) | ((PIND & D_COL_MASK) << 4);
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
  if( code) {
  // check shift/ctrl/alt state
    if( (last_col[SHIFT_L_ROW] & (1<<SHIFT_L_BIT)) ||
	(last_col[SHIFT_R_ROW] & (1<<SHIFT_R_BIT)))
      code |= (1 << SHIFT);
    if( (last_col[CTRL_ROW] & (1<<CTRL_BIT)))
      code |= (1 << CTRL);
    putq( code);
  }

}


uint8_t col;
uint8_t rowB, rowD;
int main(void)
{
  uint16_t code;
  uint8_t asc;

  /* ubrr = F_OSC/(baud*16)-1 */
  //  int ubrr = 25;		/* should be 25 for 2400 baud */
  int ubrr = 12;		/* 4800 baud */

  // set rows (and LED) as output
  DDRD = D_ROW_MASK | D_LED_MASK;
  DDRB = B_ROW_MASK;

  // set pull-ups for columns
  PORTC = C_COL_MASK;
  PORTD = D_COL_MASK;

  UCSRB = (1 << TXEN);		/* enable USART Tx */

  UBRRL = (uint8_t)(ubrr); /* set baud rate */
  UBRRH = (uint8_t)(ubrr >> 8);
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

    if( (code = getq()), (asc = code & 0xff)) {

      if( code & (1<<SHIFT))
	asc = shifted[code & 0xff];
      else
	asc = normal[code & 0xff];
      
      if( code & (1<<CTRL))
	asc &= 223;
      outhex( code);
      outchr('=');
      outhex( asc);
      outchr('"');
      outchr( asc);
      outchr('"');
      crlf();
    }
  }
}
