#define TOUT 5000

#include <stdint.h>
#include <ctype.h>
#include "serial_command.hh"

using namespace LibSerial;
using namespace std;

#define NLINES 40
#define NCOLS 80


int main( int argc, char *argv[]) {

  FILE *fp;
  char buff[256];
  int n;
  
  const char* port = "/dev/ttyUSB3";

  SerialPort sp( port); // connect to the port
  sp.SetBaudRate( LibSerial::BaudRate::BAUD_9600); // set baud rate

  sp.Write( "j 500\r");

  for( int i=0; i<NLINES; i++) {
    sp.Write( "0123456789");
    sprintf( buff, " Line %2d ", i);
    n = 10 + strlen( buff);
    sp.Write( buff);
    for( int c=0; c<NCOLS-n-1; c++)
      sp.Write("-");
    sp.Write("*");
    //    if( i != NLINES-1)
    //      sp.Write( "\r\n");
  }
}
  
