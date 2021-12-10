//
// simple_server.c -- serial "network" server for CP/M
// commands (case insensitive):
//
// CD <dir>     change host directory
// PWD          display current directory
// LS, DIR      list host directory
// NEXT         get next line in directory list or EOF
// GET <file>   open file for reading
//    returns:  "OPEN FILE.NAM SIZE nnn" or "ERROR FILE.NAM"
// READ         read hex record or EOF
//    returns:  ":xxxx..." Intel hex or "EOF"
//
// Not yet implemented:
// PUT <file>   Open a file for writing
// WRITE <xxx>  Write one intel hex record
// EOF          close the file
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>
#include <unistd.h>
#include <errno.h>

#include "sio_server.h"

#define PORT "/dev/ttyUSB1"

#define MAXFILEZ 256
#define MAXPATH 256
#define SERIAL_BUFF 512

// maximum number of hex bytes/record
#define MAXHEX 64

typedef struct  {
  char *hname;			/* host name */
  char *cname;			/* cp/m name */
  long size;			/* size in bytes */
  int bits;			/* selection bits (future) */
} a_file;

int getlistoffiles( char *path, a_file* dlist[], int maxf);
void freedirlist( a_file **dlist, int nf);
char* cpmify( char *str);
void respond( int sp, int local, char* str);

// array of pointers to files (for sorting ease)
static a_file* filez[MAXFILEZ];
static int nfilez;		/* number of active filez */
static int nextfile;

static char path[MAXPATH];
static char buff[SERIAL_BUFF];
static char hexd[2*MAXHEX+1];

static char local_buf[SIO_BUF_MAX];

static int debug = 0;

int main( int argc, char* argv[]) {

  int sp;
  char *p;
  FILE *fp;
  uint16_t addr;
  uint16_t count;
  uint8_t sum;
  int rc;
  char *cpm;

  int local = 0;		/* flag: local test */

  if( argc > 1)  local = 1;

  if( !local) {
    sp = sio_open( PORT, 115200);
    printf("Server listening on %s\n", PORT);
  } else {
    printf("Local test mode\n");
  }

  while(1) {
    if( local) {
      printf("SIO> ");
      gets( local_buf);
      p = local_buf;
    } else
      p = sio_gets( sp);

    printf("GOT: %s (len=%ld)\n", p, strlen(p) );

    if( strlen(p) > 1) {
      printf("Non-empty command\n");

      //---------- start directory list
      if( !strcasecmp( p, "ls") || !strcasecmp( p, "dir")) {
	if( nfilez)
	  freedirlist( filez, nfilez);
	int nf = getlistoffiles( ".", filez, MAXFILEZ);
	nfilez = nf;
	printf("Get dir list of %d files\n", nf);
	nextfile = 0;

      } else if( !strcasecmp( p, "next")) {
	//---------- send next file from list
	if( nextfile < nfilez) {

	  sprintf( buff, "%-13s %8ld %s\r\n",
		   filez[nextfile]->cname, 
		   filez[nextfile]->size, 
		   filez[nextfile]->hname);
	    respond( sp, local, buff);
	    nextfile++;
	} else {
	  freedirlist( filez, nfilez);
	  nfilez = 0;
	  respond( sp, local, "EOF\r\n");
	}

      } else if( !strncasecmp( p, "cd", 2)) {
	//---------- change directory

	printf("Change dir to %s\n", p+3);
	if( (rc = chdir( p+3)))
	  perror("Changing directory");

      } else if( !strcasecmp( p, "pwd")) {

	getcwd( path, MAXPATH);

	sprintf( buff, "%s\r\n", path);
	respond( sp, local, buff);
      } else if( !strncasecmp( p, "get", 3)) {
	//---------- get a file

	// first echo back the filename, uppercased
	cpm = cpmify( p+4);

	if( (fp = fopen( p+4, "r")) == NULL) {
	  sprintf( buff, "ERROR %s\r\n", cpm);
	  respond( sp, local, buff);
	} else {
	  // file is open, echo uppercase name and size
	  fseek( fp, 0L, SEEK_END);
	  long sz = ftell(fp);
	  fseek( fp, 0L, SEEK_SET);
	  sprintf( buff, "OPEN %s SIZE %ld\r\n", cpm, sz);
	  respond( sp, local, buff);
	  addr = 0;
	}

      } else if( !strcasecmp( p, "read")) {
	//---------- read next hex record

	if( feof( fp)) {
	  sprintf( buff, "EOF\r\n");
	  respond( sp, local, buff);
	} else {
	  // read up to MAXHEX bytes in hex and send as intel hex (more or less)
	  // first the header
	  count = 0;
	  sum = 0;
	  for( int i=0; i<MAXHEX; i++) {
	    unsigned char ch;
	    fread( &ch, 1, 1, fp);
	    if( feof(fp))
	      break;
	    sprintf( hexd+2*i, "%02x", ch);
	    ++count;
	    //	  printf("Read: 0x%02x, count=%d\n", ch, count);
	    sum += ch;
	  }
	  sprintf( buff, ":%02x%04x00", count, addr);
	  strcat( buff, hexd);
	  sum += count;
	  sum += ((addr >> 8) & 0xff) + (addr & 0xff);
	  addr += count;
	  sum ^= 0xff;
	  sprintf( hexd, "%02x", sum);
	  strcat( buff, hexd);
	  strcat( buff, "\r\n");
	  respond( sp, local, buff);
	  puts( buff);
	}

      } else {
	//---------- Error
	sprintf( buff, "ERROR\r\n");
	respond( sp, local, buff);
      }

    } else {
      sprintf( buff, "NULL\r\n");
      respond( sp, local, buff);
    }
    
    respond( sp, local, ">");
  }
}

// compare function for sorting
// my C is rusty, thus all the temporary vars :)
int cmpnam( const void *a, const void *b) {
  a_file** af = (a_file **)a;
  a_file** bf = (a_file **)b;
  char *n1 = (*af)->hname;
  char *n2 = (*bf)->hname;
  return strcmp( n1, n2);
}

//
// list files in directory <path> to <dlist> up to <maxf> files
// allocate mem for names
//
int getlistoffiles( char *path, a_file* dlist[], int maxf) {
  DIR *d;
  struct dirent *dir;
  int nf = 0;
  char *hname;
  char *cname;
  
  d = opendir( path);
  if( debug) printf("DEBUG: Directory open\n");
  if( d) {
    while( ((dir = readdir(d)) != NULL) &&
	   ((dir->d_type == DT_REG) ||
	    (dir->d_type == DT_DIR)) ) {
      dlist[nf] = calloc( 1, sizeof(a_file));
      hname = dir->d_name;
      if( dir->d_type == DT_REG)
	cname = cpmify( hname);
      else
	cname = "(DIR)";
      if( debug)
	printf("DEBUG: names %s and %s, setting number %d\n", hname, cname, nf);
      dlist[nf]->hname = malloc( strlen( hname) + 1);
      dlist[nf]->cname = malloc( strlen( cname) + 1);
      if( debug) printf("DEBUG: pointers set\n");
      strcpy( dlist[nf]->hname, hname);
      strcpy( dlist[nf]->cname, cname);
      // get size
      dlist[nf]->size = 0L;	/* zero size if not known */
      if( dir->d_type == DT_REG) {
	FILE* fp = fopen( hname, "r");
	if( fp != NULL) {
	  fseek( fp, 0L, SEEK_END);
	  long sz = ftell(fp);
	  fseek( fp, 0L, SEEK_SET);
	  dlist[nf]->size = sz;
	}
      }
      ++nf;
      if( nf == maxf)
	break;
    }
    closedir( d);
  }
  printf("SORTING %d items at %p with size %ld\n", nf, dlist,
	 sizeof( a_file *));

  // sort by host name
  qsort( dlist, nf, sizeof( a_file*), cmpnam);

  return nf;
}

//
// free file names
//
void freedirlist( a_file** dlist, int nf) {
  for( int i=0; i<nf; i++) {
    if( dlist[i]) {
      if( dlist[i]->hname)  free( dlist[i]->hname);
      if( dlist[i]->cname)  free( dlist[i]->cname);
      free( dlist[i]);
    }
  }
}


// convert one character to CPM-compatible
char cpmchar( char c) {
  char forbid[] = "<>.,;:=?*[]%|()/\\";   // characters not allowed in CP/M filenames
  
  if( strchr( forbid, c) != NULL)  /* forbidden character */
    return '_';
  else
    return toupper(c);
}  

//
// convert filename to CPM-compatible version
// return ptr to static buffer
//
char* cpmify( char *str) {
  static char cpm_name[16];
  char *c = cpm_name;
  char *p;
  char ch;
  int i;

  // copy first 8 characters before any "."
  for( i=0, p = str;  i<8 && *p && *p != '.';  i++, p++) {
    *c++ = cpmchar( *p);
  }

  // look for last . if any
  if( (p = strrchr( str, '.')) != NULL) {
    // copy . plus up to 3 chars
    *c++ = *p++;
    for( int i=0; i<3 && *p; i++, p++) {
      *c++ = cpmchar( *p);
    }
  }

  *c++ = '\0';
  
  return cpm_name;
}



//
// send a response to either serial port or stdout
//
void respond( int sp, int local, char* str) {
  if( !local)
    sio_puts( sp, str);
  else
    printf("SIO> %s", str);
}

