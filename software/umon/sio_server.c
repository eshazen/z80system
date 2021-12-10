//
// connect to a serial port
// expect remote commands, send responses
//

#include <sys/types.h>
#include <sys/stat.h>
#include <ctype.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#include <ctype.h>
#include <unistd.h>
#include <strings.h>
#include <string.h>
#include <stdlib.h>
        
#include "sio_server.h"


/*
 * open <dev>     (/dev/ttySxx port) for serial I/O
 * return fd or -1 on error
 */
int sio_open( char *dev, speed_t baud) {

  struct termios oldtio,newtio;
  int fd;
        
  /* open device for non-blocking I/O */
  fd = open(dev, O_RDWR | O_NOCTTY);
  //  fd = open(MODEMDEVICE, O_RDWR | O_NOCTTY | O_NONBLOCK); 
  if (fd <0) {
    perror(dev);
    return( -1);
  }
        
  tcgetattr(fd,&oldtio); /* save current port settings */
        
  bzero(&newtio, sizeof(newtio));

  /* set baud rate, 8 bits, no modem control, enable reading */
  newtio.c_cflag = baud | CS8 | CLOCAL | CREAD;
  newtio.c_iflag = 0;   /* raw input */
  newtio.c_oflag = 0;   /* raw output */
        
  /* set input mode (non-canonical, no echo,...) */
  newtio.c_lflag = 0;
         
  /* flush the line and activate new settings */
  tcflush(fd, TCIFLUSH);
  tcsetattr(fd,TCSANOW,&newtio);

  return fd;
}

//
// wait for a single-line command from client
// return command as a string in a static buffer
//
char* sio_gets( int fd) {
  static char buf[SIO_BUF_MAX];
  char rch;
  int res;
  int nc;
  
  nc = 0;

  /* read characters until CR seen */
  while(1) {
    res = read( fd, &rch, 1);
    if( res == 1) {
      if( iscntrl(rch)) {
	break;
      } else {
	buf[nc++] = rch;
	if( nc == SIO_BUF_MAX) {
	  printf("BUffer overflow!\n");
	  exit( 1);
	}
      }
    }
  }
  buf[nc++] = '\0';
  return( buf);
}

//
// Send a string to the remote port
// Any terminating control characters required are the caller's responsibility
void sio_puts( int fd, char*s) {
  char cmd;
  int i, res, nc;
  char rch, *p;

  if( strlen(s) == 0) return;
  write( fd, s, strlen(s));
}

