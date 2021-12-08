/*
 * main.c - serial keyboard
 *
 * rows row0..row7 have pull-ups enabled
 * columns col0..col7 are normally high, driven low
 *   one at a time and rows sampled
 *
 * ASCII (eventually) output at 2400 baud
 */

#include <avr/io.h>
#include <util/delay.h>
#include <stdlib.h>




void outchr( unsigned char v) {
  while (! (UCSRA & (1 << UDRE)) );
  UDR = v;
}

void outhex( unsigned char v) {
  char buff[3];

  itoa( v, buff, 16);

  outchr(buff[0]);
  outchr(buff[1]);
}

void crlf() {
  outchr( 0xd);
  outchr( 0xa);
}

unsigned char col;
unsigned char rowB, rowD;

int main(void)
{
  /* ubrr = F_OSC/(baud*16)-1 */
  int ubrr = 25;		/* should be 25 for 2400 baud */

  // set col0..col7 and LED as output
  DDRC = 0x3f;			/* bits 0-5 output */
  DDRD = 0x8c;			/* bits 7, 3, 2 output */

  // set initial data state
  PORTB = 0xc7;			/* pull-up row 7,6,2,1,0 */
  PORTD = 0x7c;			/* pull-up row 5,4,3 and columns 6,7 high */
  PORTC = 0x3f;			/* columns 5..0 high */

  UCSRB = (1 << TXEN);		/* enable USART Tx */

  UBRRL = (unsigned char)(ubrr); /* set baud rate */
  UBRRH = (unsigned char)(ubrr >> 8);
  // set one stop bit, 8 bit characters, no parity, 
  UCSRC = (1 << UCSZ0) | (1 << UCSZ1) | (1 << URSEL);
  
  while(1) {

    _delay_ms( 1000);

    // output be ef to start
    outhex( 0xbe);
    outhex( 0xef);

    // scan 8 columns, output both row values for now
    PORTC = 0x3e;		/* column 0 */
    PORTD = 0x7c;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();

    PORTC = 0x3d;		/* column 1 */
    PORTD = 0x7c;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();

    PORTC = 0x3b;		/* column 2 */
    PORTD = 0x7c;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();

    PORTC = 0x37;		/* column 3 */
    PORTD = 0x7c;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();

    PORTC = 0x2f;		/* column 4 */
    PORTD = 0x7c;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();

    PORTC = 0x1f;		/* column 5 */
    PORTD = 0x7c;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();

    PORTC = 0x3f;		/* column 6 */
    PORTD = 0x78;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();

    PORTC = 0x3f;		/* column 7 */
    PORTD = 0x74;
    rowD = PIND;
    outhex( rowD);
    rowB = PINB;
    outhex( rowB);
    crlf();
    crlf();
    PORTD ^= 0x80;		/* toggle the LED */

  }

}
