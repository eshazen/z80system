//
// new programmer for 32K
//
// w <addr> <value>              write one byte
// w <addr> <value> <count>      write same value many bytes
// b <addr> <value> <value> ...  write many bytes, HEX ONLY VALUES, up to 16 bytes
// r <addr>                      read one byte
// r <addr> <count>              read many bytes
// t <start> <end>               test a range with random values

// #define DEBUG

// EEPROM address bits (low 7 direct set)
static uint8_t eep_a[] = { A0, A1, A2, A3, A4, A5, 2};
// (upper address bits same pins as eep_d, latched using D3)

// EEPROM data bits
static uint8_t eep_d[] = { 4, 5, 6, 7, 8, 9, 10, 11 };
// EEPROM control
#define EEP_nWE 13
#define EEP_nOE 12
#define EEP_nLE 3

#define MAXBUF 128

static char buff[MAXBUF];
static uint16_t adr;
static uint8_t dat, rdat;
static char *p;
static uint8_t nc;
static uint16_t num;
static uint8_t errz;
static uint8_t rtry;
static uint8_t echo = 0;

#define MAXTOK 40
static uint8_t toks[MAXTOK];
static uint16_t itok[MAXTOK];


// set EEPROM 15 address bits
void set_a( uint16_t a) {
  uint8_t b;
  // low 7 bits
  for( uint8_t i=0, b=1;
       i<7;
       i++, b<<=1)
       digitalWrite( eep_a[i], a & b);
  // upper 8 bits (14 downto 8)
    set_d( ((a>>8) & 0x7f) | (a & 0x80));
  data_out();
  digitalWrite( EEP_nLE, LOW);
  digitalWrite( EEP_nLE, HIGH);
}

uint8_t read_d() {
  uint8_t b;
  uint8_t d = 0;
  for( uint8_t i=0, b=1; i<8; i++, b<<=1) {
    if( digitalRead( eep_d[i]))
      d |= b;
  }
  return d;
}

void set_d( uint8_t a) {
  uint8_t b;
  for( uint8_t i=0, b=1;
       i<8;
       i++, b<<=1)
       digitalWrite( eep_d[i], a & b);
}

void data_out() {
  for( uint8_t i=0; i<8; i++) {
    pinMode( eep_d[i], OUTPUT);
  }
}

void data_in() {
  for( uint8_t i=0; i<8; i++) {
    pinMode( eep_d[i], INPUT);
  }
}

void ee_write( uint16_t a, uint8_t d) {
#ifdef DEBUG
  printHex4( a);
  printHex2( d);
#endif
  digitalWrite( EEP_nWE, 1);
  digitalWrite( EEP_nOE, 1);
  data_out();
  set_a( a);
  set_d( d);
  digitalWrite( EEP_nWE, 0);
  digitalWrite( EEP_nWE, 1);
  data_in();  
}


uint8_t ee_read( uint16_t a) {
  uint8_t v;
  digitalWrite( EEP_nWE, 1);
  digitalWrite( EEP_nOE, 1);
  set_a( a);
  data_in();
  digitalWrite( EEP_nOE, 0);
  v = read_d();
  digitalWrite( EEP_nOE, 1);
  return v;
}




void setup() {
  for( uint8_t i=0; i<7; i++) {
    pinMode( eep_a[i], OUTPUT);
  }
  digitalWrite( EEP_nWE, 1);
  digitalWrite( EEP_nOE, 1);
  digitalWrite( EEP_nLE, 1);
  pinMode( EEP_nWE, OUTPUT);
  pinMode( EEP_nOE, OUTPUT);
  pinMode( EEP_nLE, OUTPUT);
  data_in();
  Serial.begin( 4800);
  Serial.setTimeout( 100000);
  randomSeed(1);
  Serial.println("programmer ready");
}

//
// parse buffer into space-separated tokens
//   buff  - buffer to parse
//   toks  - array to store offsets to start of tokens
//   tmax  - size of toks array
// returns token count
// overwrites buffer to insert \0 at end of each token
//
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



// the loop function runs over and over again forever


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
      itok[i] = strtoul( buff+toks[i], NULL, 0);
  }
  
  if( nc >= 2) {
    adr = itok[1];
    
    switch( toupper( buff[toks[0]])) {
      case 'A':  // just set address and leave in read mode for probing
        dat = ee_read(adr);
        digitalWrite( EEP_nOE, 0);
        printHex4( adr);
        printHex2( dat);
        Serial.println(" (left nOE active)");
        break;
        
      case 'R':
        num = 1;
        if( nc > 2) num = itok[2];
        Serial.println();
        printHex4( adr);
        for( uint16_t i=0; i<num; i++) {
          dat = ee_read( adr);
          printHex2( dat);
          Serial.print(' ');
          ++adr;
          if( !(adr & 15)) {
            Serial.println();
            printHex4( adr);
          }
        }
        Serial.println();
        break;
        
      case 'B':
        errz = 0;
        adr = strtoul( buff+toks[1], NULL, 16);
        for( uint16_t i=2; i<nc; i++) {
          dat = strtoul( buff+toks[i], NULL, 16);
#ifdef DEBUG
          Serial.print("->");
          printHex4( adr);
          printHex2( dat);
          Serial.println("<-");
#endif          
          rdat = ee_read( adr);
          if( rdat != dat) {
            rtry = 0;
#ifdef DEBUG
            Serial.print('[');
            printHex4( adr);
            printHex2( dat);
            Serial.println(']');
#endif            
            ee_write( adr, dat);
            
            do {
              rdat = ee_read( adr);
              if( rdat != dat) {
                ++rtry;
                delay(1);
              }
            } while( rdat != dat && rtry < 100);
            if( rdat != dat)
              ++errz;
          }
          adr++;
        }
        if( errz)
          Serial.println("error");
        else
          Serial.println("OK");  
        break;
        
      case 'W':
        if( nc < 3)
          Serial.println("error");
        else {
          num = 1;
          dat = itok[2];
          if( nc > 3)  num = itok[3];
          for( uint16_t i=0; i<num; i++) {
            ee_write( adr, dat);
            ++adr;
          }
        }
        break;
      case 'E':
        echo = itok[1];
        break;
      case 'T':
        if( nc < 3)
          Serial.println("error");
        else {
          uint16_t errs = 0;
          uint16_t start = itok[1];
          uint16_t end = itok[2];
          randomSeed(1);  
          Serial.print("Test from ");
          Serial.print( start);
          Serial.print(" to ");
          Serial.println( end);
          for( uint16_t i=start; i<=end; i++)
            ee_write( i, random(255));
          randomSeed(1);
          for( uint16_t i=start; i<=end; i++) {
            uint8_t ev = random(255);
            uint8_t rv = ee_read( i);
            if( ev != rv) {
              Serial.print("Err at ");
              Serial.print( i);
              Serial.print(" expected ");
              Serial.print( ev);
              Serial.print(" got ");
              Serial.println( rv);
              ++errs;
            }
            
          }
          Serial.print( errs);
          Serial.println(" errors");
        }
      default:
        break;
    }
  }
 
}
