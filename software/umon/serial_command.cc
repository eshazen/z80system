//
// serial port command/response functions
//
// vector<string> command_vector( SerialPort& sp, string cmd)
//     Send a command and return a (possibly empty) vector
//     with the board's response
//
// (The remainder of the functions are typically only used internally)
//
// std::string command_response( SerialPort& sp, std::string cmd)
//     Send command "cmd" to the board
//     Receive response resp including terminating '>' prompt
//
// void send_string_cmd( SerialPort& sp, std::string str)
//     Send command str to the board, add terminating '\r'
//
// void recv_string_until( SerialPort& sp, char* termi, int toms, std::string& str)
//     Receive characters until timeout or terminating character seen
//
// vector<string> vectorize_response( string str)
//     Convert a reply string to a vector of strings
//     Delete first and last line, assuming they are the echoed command
//     and the prompt '>' on it's own line
//     FIXME:  parse errors here
//


#include "serial_command.hh"
#include <sstream>
#include <string.h>
#include <unistd.h>

// easiest to declare a short function to send a string to the port
void send_string_cmd( SerialPort& sp, std::string str) {
    vector<uint8_t> vec( str.begin(), str.end()); // need a vector to write
    vec.push_back( '\r');			 // add <Enter> at end
    sp.Write( vec);
}  

// send string slowly
void send_string_slow( SerialPort& sp, std::string str) {
  for( int i=0; i<str.size(); i++) {
    sp.WriteByte( str[i]);
    usleep( 10000);
  }
  sp.WriteByte( '\r');
  usleep( 10000);
}


// receive string with timeout and/or terminating character
//   termi is character to end reading (terminator) or '\0' for none
//   toms is timeout in ms
//
void recv_string_until( SerialPort& sp, const char* termi, int toms, std::string& str) {
  bool timeout = false;
  char ch;
  str = "";
  
  do {
    try {
      sp.ReadByte( ch, toms);	// read a character with 100ms timeout
    } catch (LibSerial::ReadTimeout) {
      timeout = true;
    };
    str += ch;
    // loop until timeout or timi
  } while( !timeout && strchr( termi, ch) == NULL);
}


// send a command and wait for a response terminated by '>'
string command_response( SerialPort& sp, string cmd) {
  string resp;
  send_string_cmd( sp, cmd);
  recv_string_until( sp, ">", 100, resp);
  return resp;
}


// clean the response by removing the echoed command and prompt line
// return a vector of strings
vector<string> vectorize_response( string str) {
  stringstream ss( str);
  string tmp;
  vector<string> resp;

  while( getline( ss, tmp))
    resp.push_back( tmp);
  if( resp.size() >= 2) {
    resp.erase( resp.begin());	// delete the echo command
    resp.erase( resp.end());	// delete the prompt
  }

  return resp;
}


//
//  send a command string to the board
//  return the response line(s) as a vector
//  vector is empty for commands with no response (e.g. "W")
//
vector<string> command_vector( SerialPort& sp, string cmd) {
  string str;
  vector<string> rv;
  str = command_response( sp, cmd);
  rv = vectorize_response( str);
  return rv;
}
