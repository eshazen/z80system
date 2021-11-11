#
# load any data to RC2014 
# 
    
using SerialPorts

dilly = 0.05

slow = false

function send_slow(s)
    println( "Send: ", s)
    if( slow == true)
        for (ci, c) in enumerate(s)
            write( sp, c)
            sleep( dilly)
        end
    else
        write(sp,s)
    end
    
    return
end


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
    send_slow( c)
    sleep( 0.1)
    # FIXME wait for prompt
    return( clean_str(readavailable(s)));
end


# initialize the port
sp = SerialPort( "/dev/ttyUSB1", 115200)

# read an intel hex file into an array
f = open( ARGS[1], "r")

while ! eof(f)
    s = readline( f)
    r = do_cmd( sp, s * '\r')
    println(r)
    if r[lastindex(r)] != '+'
        println( "Missing prompt!")
    end
end

