//
// read a pure binary file (.COM) and convert
// to assembly "DB" statements for relocation
//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int main( int argc, char *argv[])
{
  FILE *fp;
  uint8_t b;
  int nl;
  int nb;
  
  if( argc < 2) {
    printf("Usage: %s <com_file>\n", argv[0]);
    exit(1);
  }

  if( (fp = fopen( argv[1], "rb")) == NULL) {
    printf("Error opening %s for input\n", argv[1]);
    exit(1);
  }

  nl = 0;
  nb = 0;

  printf("RCODE:\n");

  while( !feof(fp)) {
    int rc = fread( &b, 1, 1, fp);
    if( nl == 0)
      printf( "\tDB\t");
    printf("%03XH", b);
    if( nl == 15) {
      printf( "\n");
      nl = 0;
    } else {
      if( !feof(fp))
	  printf(",");
      ++nl;
    }
    ++nb;
  }
  printf("\n");

  printf("RSIZE:\tEQU\t%04XH\n", nb);

}

  
