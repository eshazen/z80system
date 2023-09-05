//
// iCOM floppy test code
//
// Expects an 82C55 wired as below

const int PPI_nRD = 13;
const int PPI_nWR = 12;
const int PPI_A0 = 10;
const int PPI_A1 = 11;

const int PPI_D0 = 2;
const int PPI_D1 = 3;
const int PPI_D2 = 4;
const int PPI_D3 = 5;

const int PPI_D4 = 6;
const int PPI_D5 = 7;
const int PPI_D6 = 8;
const int PPI_D7 = 9;

// PPI control word for A, B as output, C as input (mode 0)
const int PPI_CTRL = 0b10001001;

//
// simple-minded string input with editing
//
int my_gets( char *buff, uint8_t maxbuf)
{
  char cin;
  char *p = buff;
  uint8_t nc = 0;
  
  while(1) {
    while( (cin = Serial.read()) == -1)  ;
    if( iscntrl( cin)) {
      switch( cin) {
        case '\r':
        case '\n':
          Serial.write( '\r');
          Serial.write( '\n');
          *p++ = '\0';
//          Serial.print("\"");
//          Serial.print( buff);
//          Serial.println("\"");
          return( p - buff);
        case  8:
          if( p > buff) {
            Serial.write( cin);
            --p;
          }
          break;
        default:
          break;
      }
    } else {  // printable character
      if( (p-buff) < maxbuf-1) {
        Serial.write( cin);
        *p++ = cin;
      }
    }
  }
}




void set_PPI_data( byte d) {
  digitalWrite( PPI_D0, d & 1);
  digitalWrite( PPI_D1, d & 2);
  digitalWrite( PPI_D2, d & 4);
  digitalWrite( PPI_D3, d & 8);

  digitalWrite( PPI_D4, d & 0x10);
  digitalWrite( PPI_D5, d & 0x20);
  digitalWrite( PPI_D6, d & 0x40);
  digitalWrite( PPI_D7, d & 0x80);
}

byte get_PPI_data() {
  byte val = 0;
  if( digitalRead( PPI_D0)) val |= 1;
  if( digitalRead( PPI_D1)) val |= 2;
  if( digitalRead( PPI_D2)) val |= 4;
  if( digitalRead( PPI_D3)) val |= 8;
  if( digitalRead( PPI_D4)) val |= 0x10;
  if( digitalRead( PPI_D5)) val |= 0x20;
  if( digitalRead( PPI_D6)) val |= 0x40;
  if( digitalRead( PPI_D7)) val |= 0x80;
  return val;
}

void set_PPI_output() {
  pinMode( PPI_D0, OUTPUT);
  pinMode( PPI_D1, OUTPUT);
  pinMode( PPI_D2, OUTPUT);
  pinMode( PPI_D3, OUTPUT);
  pinMode( PPI_D4, OUTPUT);
  pinMode( PPI_D5, OUTPUT);
  pinMode( PPI_D6, OUTPUT);
  pinMode( PPI_D7, OUTPUT);
}

void set_PPI_input() {
  pinMode( PPI_D0, INPUT);
  pinMode( PPI_D1, INPUT);
  pinMode( PPI_D2, INPUT);
  pinMode( PPI_D3, INPUT);
  pinMode( PPI_D4, INPUT);
  pinMode( PPI_D5, INPUT);
  pinMode( PPI_D6, INPUT);
  pinMode( PPI_D7, INPUT);
}

void write_PPI( int addr, byte data) {
  Serial.print("Wr ");
  Serial.print( addr);
  Serial.print("=");
  Serial.println(data);
  digitalWrite( PPI_A0, addr & 1);
  digitalWrite( PPI_A1, addr & 2);
  set_PPI_output();
  set_PPI_data( data);
  digitalWrite( PPI_nWR, LOW);
  digitalWrite( PPI_nWR, HIGH);
}

byte read_PPI( int addr) {
  byte val;
  digitalWrite( PPI_A0, addr & 1);
  digitalWrite( PPI_A1, addr & 2);
  set_PPI_input();
  digitalWrite( PPI_nRD, LOW);
  val = get_PPI_data();
  digitalWrite( PPI_nRD, HIGH);
  set_PPI_output();
  Serial.print("Rd ");
  Serial.print(addr);
  Serial.print("=");
  Serial.println( val);
  return val;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin( 9600);
  Serial.setTimeout(100000);
  pinMode( PPI_nRD, OUTPUT);
  pinMode( PPI_nWR, OUTPUT);
  pinMode( PPI_A0, OUTPUT);
  pinMode( PPI_A1, OUTPUT);
  digitalWrite( PPI_nRD, HIGH);
  digitalWrite( PPI_nWR, HIGH);
  write_PPI( 3, PPI_CTRL);
}

char buff[80];
int addr;
byte dat;
bool err;

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(">");
  my_gets( buff, sizeof(buff));
  err = false;
  switch( toupper( *buff)) {
    case 'H':
      Serial.println("H          - Help");
      Serial.println("R a        - read from a=0/1/2/3");
      Serial.println("W a dddd   - write to a dddd");
      Serial.println("T          - loop writing CR");
      break;
    case 'R':
      if( strlen(buff) > 2) {
        addr = atoi( buff+2);
        dat = read_PPI( addr);
        Serial.println( dat);
      } else {
        err = true;
      }
      break;
    case 'W':
      if( strlen(buff) > 4) {
        addr = atoi( buff+2);
        dat = strtoul( buff+4, NULL, 0);
        write_PPI( addr, dat);
      } else {
        err = true;
      }
      break;
    case 'T':
      while( !Serial.available()) {
        dat = read_PPI( 3);
        Serial.println( dat);
        delay(100);
      }
      break;
        
    default:
      err = true;
      break;
  }
  if( err)
    Serial.println("Error");
}
