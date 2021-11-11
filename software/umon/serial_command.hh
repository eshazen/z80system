// serial_command.hh
//
// Declare functions to send a command to the serial port and receive a response
//


#include <iostream>
#include <cstring>
#include <vector>
#include <cstdint>
#include <libserial/SerialPort.h>
#include <libserial/SerialStream.h>

using namespace LibSerial;
using namespace std;

void send_string_cmd( SerialPort& sp, std::string str);
void send_string_slow( SerialPort& sp, std::string str);
void recv_string_until( SerialPort& sp, const char* termi, int toms, std::string& str);
string command_response( SerialPort& sp, string cmd);
vector<string> vectorize_response( string str);
vector<string> command_vector( SerialPort& sp, string cmd);
