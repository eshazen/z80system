//
// program EEPROM (e.g. AT28C256) using shield design
// as https://danceswithferrets.org/geekblog/?page_id=903
// but with additions:
//    pull-up and switch on nWE
//    switch on VCC for device
//
// Serial interface intended to be compatible with our fast_prog
// Note: ALL VALUES ASSUMED HEX, NO PREFIX NEEDED
//
// b <addr> <value> <value> ...  write many bytes to buffer at <addr> = 00..3f
// f <value>                     fill buffer with value
// d                             dump 40h byte buffer
// p <addr>                      program buffer to device at <addr>
//                               low 6 bits must be low in <addr>
// r <addr>                      read one byte from device
// r <addr> <count>              read many bytes from device
// t                             test fast write in loop
// s                             disable data protection on AT28C256 (untested!)
//
// Programming in bulk, in PAGSIZ (64) pages:
//
// loop over page addresses (addr % PAGSIZ == 0)
// r <addr> 40                   fill page buffer with current contents (optional)
// b <offset> dd dd dd....       fill in up to 64 bytes data at <offset> 0..63
// p <addr>                      program 64 bytes to EEPROM
//


// simulate reading by return address in byte pairs
// #define FAKE_READ

// address pins from A0 up
// Note:  these are also hard-wired in ee_fast()
static const int Pin_Addr[] = { 42, 40, 38, 36, 34, 32, 30, 28, 
  31, 33, 39, 35, 26 , 29, 24 };

// data pins from D0 up
// Note:  these are also hard-wired in ee_fast()
static const int Pin_Data[] = { 44, 46, 48, 51, 49, 47, 45, 43 };

static const int Pin_nWE = 27;
static const int Pin_nOE = 37;
static const int Pin_nCS = 41;

#define MAXBUF 128
#define PAGSIZ 64
#define MAXTRIES 10000

static char buff[MAXBUF];
static uint16_t adr;
static uint8_t dat, rdat;
static char *p;
static uint8_t nc;
static uint16_t num;
static uint8_t errz;
static uint16_t rtry;
static uint8_t echo = 0;

#define MAXTOK 40
static uint8_t toks[MAXTOK];
static uint16_t itok[MAXTOK];

static uint8_t page[PAGSIZ];

#define asize(a) (sizeof(a)/sizeof(a[0]))

// set data pins as input for reading
void data_in() {
  for( uint8_t i=0; i<asize( Pin_Data); i++)
    pinMode( Pin_Data[i], INPUT_PULLUP);
}

// set data pins as output for writing
void data_out() {
  for( uint8_t i=0; i<asize( Pin_Data); i++)
    pinMode( Pin_Data[i], OUTPUT);
}


void setup() {
  // set fixed direction pins
  for( uint8_t i=0; i<asize(Pin_Addr); i++)
    pinMode( Pin_Addr[i], OUTPUT);
  pinMode( Pin_nWE, OUTPUT);
  pinMode( Pin_nOE, OUTPUT);
  pinMode( Pin_nCS, OUTPUT);
  data_in();			// set data as input

  // all control signals inactive
  digitalWrite( Pin_nWE, HIGH);
  digitalWrite( Pin_nOE, HIGH);
  digitalWrite( Pin_nCS, HIGH);

  Serial.begin( 4800);
  Serial.setTimeout( 100000);

  delay(1000);
  Serial.println("programmer ready");
}

//
// parse buffer into space-separated tokens
//   buff  - buffer to parse
//   toks  - array to store offsets to start of tokens
//   tmax  - size of toks array
// returns token count
// overwrites buffer to insert \0 at end of each token
uint8_t parse( char *buff, uint8_t *toks, uint8_t tmax) {
  char *p = buff;
  uint8_t nt = 0;
  do {
    // skip leading space
    while( isspace(*p) && *p)
      ++p;
    if( !*p) return nt;  // EOS with no token
    toks[nt] = p-buff;   // index of token start
    ++nt;
    if( nt == tmax)  return nt;
    // skip to trailing space
    while( !isspace(*p) && *p)
      ++p;
    if( !*p) return nt;
    *p = '\0';
    ++p;
  } while( 1);
}


// set address
void set_addr( uint16_t a) {
  for( uint8_t i=0; i<asize(Pin_Addr); i++) {
    if( a & (1<<i))
      digitalWrite( Pin_Addr[i], HIGH);
    else
      digitalWrite( Pin_Addr[i], LOW);
  }
}

// read data
uint8_t read_data() {
  uint8_t rv = 0;
  for( uint8_t i=0; i<asize( Pin_Data); i++)
    if( digitalRead( Pin_Data[i]))
      rv |= (1<<i);
  return rv;
}

// set data
void set_data( uint8_t d) {
  for( uint8_t i=0; i<8; i++) {
    if( d & (1<<i))
      digitalWrite( Pin_Data[i], HIGH);
    else
      digitalWrite( Pin_Data[i], LOW);
  }
}

// fast write within PAGSIZ page (fixed at 64!)
// use set_addr first to set the page
// use data_out() first to set the direction
//
// This takes around 25 us between writes
//
void ee_fast( uint8_t addr, uint8_t dat) {
  
  // set low 6 bits addr
  if( addr & 1)			// A0 - PL7
    PORTL |= _BV(7);
  else
    PORTL &= ~_BV(7);
  if( addr & 2)			// A1 - PG1
    PORTG |= _BV(1);
  else
    PORTG &= ~_BV(1);
  if( addr & 4)			// A2 - PD7
    PORTD |= _BV(7);
  else
    PORTD &= ~_BV(7);
  if( addr & 8)			// A3 - PC1
    PORTC |= _BV(1);
  else
    PORTC &= ~_BV(1);
  if( addr & 0x10)		// A4 - PC3
    PORTC |= _BV(3);
  else
    PORTC &= ~_BV(3);
  if( addr & 0x20)		// A5 - PC5
    PORTC |= _BV(5);
  else
    PORTC &= ~_BV(5);

  // set 8 bits data
  if( dat & 1)			// D0 - PL5
    PORTL |= _BV(5);
  else
    PORTL &= ~_BV(5);
  if( dat & 2)			// D1 - PL3
    PORTL |= _BV(3);
  else
    PORTL &= ~_BV(3);
  if( dat & 4)			// D2 - PL1
    PORTL |= _BV(1);
  else
    PORTL &= ~_BV(1);
  if( dat & 8)			// D3 - PB2
    PORTB |= _BV(2);
  else
    PORTB &= ~_BV(2);
  if( dat & 0x10)		// D4 - PL0
    PORTL |= _BV(0);
  else
    PORTL &= ~_BV(0);
  if( dat & 0x20)		// D5 - PL2
    PORTL |= _BV(2);
  else
    PORTL &= ~_BV(2);
  if( dat & 0x40)		// D6 - PL4
    PORTL |= _BV(4);
  else
    PORTL &= ~_BV(4);
  if( dat & 0x80)		// D7 - PL6
    PORTL |= _BV(6);
  else
    PORTL &= ~_BV(6);

  // strobe nCS and nWE low
  digitalWrite( Pin_nCS, LOW);
  digitalWrite( Pin_nWE, LOW);
  digitalWrite( Pin_nWE, HIGH);
  digitalWrite( Pin_nCS, HIGH);
}

// slow-ish write to any address
// (takes 100's of uS)
void ee_write( uint16_t addr, uint8_t dat) {
  digitalWrite( Pin_nOE, HIGH);
  data_out();
  set_addr( addr);
  set_data( dat);
  digitalWrite( Pin_nCS, LOW);
  digitalWrite( Pin_nWE, LOW);
  _delay_us(1);
  digitalWrite( Pin_nWE, HIGH);
  digitalWrite( Pin_nCS, HIGH);
  data_in();
}

// poll till D7 match
// (currently not used!)
int ee_poll( uint16_t addr, uint8_t dat) {
  static int tries = 0;

  while( ++tries < MAXTRIES) {
    if( (ee_read( addr) & 0x80) == (dat & 0x80))
      return tries;
  }

  return -1;
}


uint8_t ee_read( uint16_t addr) {
  uint8_t dat;

#ifdef FAKE_READ
  if( addr % 2)
    return addr & 0xff;
  else
    return (addr >> 8) & 0xff;
#endif  

  data_in();
  set_addr( addr);
  digitalWrite( Pin_nOE, LOW);
  digitalWrite( Pin_nCS, LOW);
  dat = read_data();
  digitalWrite( Pin_nCS, HIGH);
  digitalWrite( Pin_nOE, HIGH);
  return dat;
}

void printHex2( uint8_t v) {
  if( v < 16)
    Serial.print('0');
  Serial.print( v, HEX);
}

void printHex4( uint16_t v) {
  printHex2( (v >> 8) & 0xff);
  printHex2( v & 0xff);
  Serial.print(' ');
}



void loop() {

  Serial.print("> ");
  nc = Serial.readBytesUntil( '\r', buff, MAXBUF);
  buff[nc] = '\0';
  if( echo) Serial.println( buff);
  
  nc = parse( buff, toks, MAXTOK);
  if( nc) {
    for( uint8_t i=0; i<nc; i++)
      itok[i] = strtoul( buff+toks[i], NULL, 16);
  }

  // use address if supplied, else assume 0
  if( nc >= 2)
    adr = itok[1];
  else
    adr = 0;

  switch( toupper( buff[toks[0]])) {

  case 'R':			// read from any place
    num = 1;
    if( nc > 2) num = itok[2];
    Serial.println();
    printHex4( adr);
    for( uint16_t i=0; i<num; i++) {
      dat = ee_read( adr);
      // save in page buffer
      page[adr % PAGSIZ] = dat;
      printHex2( dat);
      Serial.print(' ');
      ++adr;
      if( !(adr & 15)) {
	Serial.println();
	printHex4( adr);
      }
    }
    break;

  case 'D':			// dump page buffer
    Serial.println();
    for( uint8_t i=0; i<PAGSIZ; i++) {
      printHex2( page[i]);
      if( (i % 0x10) == 0xf)
	Serial.println();
      else
	Serial.print(" ");
    }
    break;

  case 'F':			// fill page buffer with constant
    dat = itok[1];
    for( uint8_t i=0; i<PAGSIZ; i++)
      page[i] = dat;
    break;

  case 'B':			// write to page buffer up to ~40 bytes
    if( nc > 2) {
      for( uint8_t i=0; i<nc-2; i++)
	page[(i+adr) % PAGSIZ] = itok[i+2];
    }
    break;

  case 'T':			// write over and over, disabled for now
    Serial.println("Disabled...");
    break;

//    Serial.println("Testing...");
//    while( !Serial.available() ) {
//      set_addr( adr & 0xffc0);	// better be page boundary
//      data_out();
//      for( uint8_t i=0; i<PAGSIZ; i++) {
//	ee_fast( i, page[i]);
//      }
//    }
    break;
    
  case 'S':			// disable software data protection
    ee_write( 0x5555, 0xaa);
    ee_write( 0x2aaa, 0x55);
    ee_write( 0x5555, 0x80);
    ee_write( 0x5555, 0xaa);
    ee_write( 0x2aaa, 0x55);
    ee_write( 0x5555, 0x20);
    Serial.println("protection deactivated");

  case 'P':			// write 40h bytes to device page
    set_addr( adr & 0xffc0);	// better be page boundary
    data_out();
    for( uint8_t i=0; i<PAGSIZ; i++) {
      ee_fast( i, page[i]);
    }
    delay(10);			// fixed 10ms delay to complete
    break;

  default:
    Serial.println("Error");
    break;
  }
}
