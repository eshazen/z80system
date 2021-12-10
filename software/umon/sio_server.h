#include <termios.h>

int sio_open( char *dev, speed_t baud);
char* sio_gets( int fd);
void sio_puts( int fd, char *s);

#define SIO_BUF_MAX 1024
