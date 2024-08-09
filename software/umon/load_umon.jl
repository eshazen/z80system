#
# load hex data to RC2014 via SCM memory edit
# 
    
using SerialPorts

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
    sleep( 0.01)
    return( clean_str(readavailable(s)));
end


# initialize the port
sp = SerialPort( "/dev/ttyUSB1", 115200)

# read an intel hex file into an array
f = open( ARGS[1], "r")

while ! eof(f)
    s = readline( f)
    if s[1] == ':'
        ilen = parse( Int, s[2:3], base=16)
        iaddr = parse( Int, s[4:7], base=16)
        ityp = parse( Int, s[8:9], base=16)
        print( "Type=", ityp, " addr=", iaddr, " len=", ilen, "\n")
        if ityp == 0
            scmd = "e " * string(iaddr, base=16)
            for i=1:ilen
                n = 8+2*i
                scmd = scmd * " " * s[n:n+1]
            end
            scmd = scmd * "\r"
            println(do_cmd( sp, scmd))
        end
    end
end

