/*
 * main.c - serial keyboard
 */

#include <avr/io.h>
#include <util/delay.h>


void outchr( unsigned char v) {
  while (! (UCSRA & (1 << UDRE)) );
  UDR = v;
}

int main(void)
{
  /* ubrr = F_OSC/(baud*16-1 */
  int ubrr = 25;		/* should be 25 for 2400 baud */
  short i;
  
  DDRC = 0x3f;			/* bits 0-5 output */
  DDRD = 0x8e;			/* bits 7, 3, 2, 1 output */

  UBRRH = (unsigned char)(ubrr >> 8);
  UBRRL = (unsigned char)(ubrr);
  UCSRC = (1 << USBS) | (1 << UCSZ0) | (1 << URSEL);

  // for some reason this doesn't work...
  // the loop should take 120/240 = 0.5 sec but it doesn't seem to...
  while(1) {
    for( i=0; i<=120; i++)
      outchr( i);
    PORTD ^= 0x80;
    _delay_ms( 500);
  }

}
