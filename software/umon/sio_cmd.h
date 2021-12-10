#ifndef _SIO_CMD_H

#include <termios.h>

#define SIO_BUF_MAX 10000        

#define _POSIX_SOURCE 1 /* POSIX compliant source */
#define FALSE 0
#define TRUE 1

int sio_open( char *dev, speed_t baud);
char *sio_cmd( int fd, char *s);
void dump_string( char *s);
int sio_open_trace( char *dev, char *tracef, speed_t baud);
void send_break( int fd);

#define _SIO_CMD_H
#endif

