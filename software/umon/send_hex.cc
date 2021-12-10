//
// send_hex.cc -- send hex file to CP/M system
//
// usage:
// send_hex [options] <hex_file>             load to stand-alone hex loader
// send_hex [options] <hex_file> <CPM_file>  load to CP/M
//
// Options:
//   -s        send "G C000" to start in-memory loader
//   -v        verbose output (echo each hex line)
//   -c        send rest of command line as-is to CP/M slowly
//
// the second option sends "A:HEXLOAD CPM_file" before the file
//

#define TOUT 5000

#include <stdint.h>
#include <ctype.h>
#include "serial_command.hh"

using namespace LibSerial;
using namespace std;


// grab a hex value from a string
//   str points to start of hex
//   len is length in digits (max 4)
uint16_t get_hex_val( char *str, int len) {
  uint16_t val;
  char tmp[16];
  strncpy( tmp, str, len);
  tmp[len] = '\0';
  return (uint16_t)strtoul( tmp, NULL, 16);
}
  

int main( int argc, char *argv[]) {

  FILE *fp;
  char buff[256];

  int lines = 0;
  int verbose = 0;
  int send_cmd = 0;

  uint16_t addr, count, amin, amax, type;

  char *hex_file = NULL;
  char *cpm_file = NULL;
  char *cpm_cmd = NULL;
  const char *init_cmd = NULL;
  
  string stuff;

  const char* port = "/dev/ttyUSB1";

  SerialPort sp( port); // connect to the port
  sp.SetBaudRate( LibSerial::BaudRate::BAUD_115200); // set baud rate

  if( argc == 1) {
    printf("Usage: send_hex [-s] <hex_file> [<cpm_file>]\n");
    exit(1);
  }

  for( int i=1; i<argc; i++) {
    if( *argv[i] == '-') {
      switch( toupper( argv[i][1])) {
      case 'C':
	send_cmd = 1;
	break;
      case 'S':
	init_cmd = "G C000";
	break;
      case 'V':
	verbose = 1;
	break;
      default:
	printf("Unknown option %s\n", argv[i]);
	exit(1);
      }
    } else {
      if( hex_file == NULL)
	hex_file = argv[i];
      else if( cpm_file == NULL)
	cpm_file = argv[i];
    }
  }

  if( send_cmd) {
    // special case, build CP/M command line from args
    if( argc < 3) {
      printf("Need command after -C\n");
      exit(1);
    }
    buff[0] = '\0';
    for( int i=2; i<argc; i++) {
      if( i > 2)
	strcat( buff, " ");
      strcat( buff, argv[i]);
    }
    // flush input
    printf("Flush input...\n");
    recv_string_until( sp, NULL, TOUT, stuff);
    printf("Got: %s\n", stuff.c_str() );
    printf("Command: %s\n", buff);
    cpm_cmd = buff;
    if( verbose) printf("Send: %s\n", buff);
    send_string_slow( sp, buff);
    recv_string_until( sp, ">", 60000, stuff);
    cout << "Got: " << stuff << endl;
    exit(0);
  }
    
  if( hex_file == NULL) {
    printf("Missing hex file name\n");
    exit(1);
  } else {
    if( (fp = fopen( hex_file, "r")) == NULL) {
      printf("Error opening %s for input\n", argv[1]);
      exit(1);
    }
  }

  if( init_cmd != NULL) {
    if( verbose) printf("Send: %s\n", init_cmd);
    send_string_slow( sp, init_cmd);
  }

  if( cpm_file != NULL) {
    sprintf( buff, "B:HEXLOAD %s", cpm_file);
    if( verbose) printf("Send: %s\n", buff);
    send_string_slow( sp, buff);
  }

  printf("Loading %s", hex_file);
  if( cpm_file)
    printf(" to %s\n", cpm_file);
  else
    printf("\n");

  if( verbose) printf("Wait for +\n");
  recv_string_until( sp, "+", TOUT, stuff);
  if( verbose) cout << "Start: '" << stuff << "'" << endl;

  // setup stats
  amin = 0xffff;
  amax = 0;

  // read the file
  while( fgets( buff, sizeof(buff), fp) != NULL) {

    if( verbose) printf("Read: '%s'\n", buff);

    if( buff[0] == ':' && strlen(buff) > 8) {
      // grab count
      count = get_hex_val( buff+1, 2);
      addr = get_hex_val( buff+3, 4);
      type = get_hex_val( buff+7, 2);
      
      if( type == 0) {
	if( verbose) printf("Data: len=0x%x addr=0x%x\n", count, addr);
	if( addr < amin)
	  amin = addr;
	if( addr+count > amax)
	  amax = addr + count;
      } else if( type == 1) {
	printf("EOF record\n");
      } else {
	printf("Unknown record type %d\n", type);
      }
      
    } else {
      printf("Unknown record: '%s'\n", buff);
    }

    // clean up end of string
    buff[ strlen(buff)] = '\0';

    if( verbose) printf("Send: %s\n", buff);
    send_string_cmd( sp, buff);
    recv_string_until( sp, "+>", TOUT, stuff);
    if( verbose) printf("Get: %s\n", stuff.c_str() );

    ++lines;
    if( lines % 100 == 0)
      printf("Line %d\n", lines);
    
  }

  printf("%s loaded from 0x%04x to 0x%04x\n", hex_file, amin, amax);

}
  
