#
# perform a start-up sequence
# 1.  Open port A at 115200 baud
# 2.  Send "console 2\r"
    
using SerialPorts

port_A = "/dev/ttyUSB1"
port_A_speed = 115200

# function to replace \r with \n in a string
function clean_str(t)
    r = "";
    for i = firstindex(t):lastindex(t)
        try
            c = t[i]
            if c == '\r'
                r *= "\n"
            else
                r *= c
            end
        catch
            # ignore the index error
        end
    end
    return r
end

# send a command to serial port and return echoed string
function do_cmd(s,c)
    write(s, c)
    sleep( 0.1)
    return( clean_str(readavailable(s)));
end


# initialize the port
spA = SerialPort( port_A, port_A_speed)

println( do_cmd( spA, "\rconsole 2\r"))



