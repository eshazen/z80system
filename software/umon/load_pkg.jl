#
# load Grant Searle's package file slowly
#
# format:
# A:DOWNLOAD FILE.TYP
# U0
# :hex......>xxxx
#
using SerialPorts

dilly = 0.05                    # character delay
dally = 1.0                     # line delay

# initialize the port
sp = SerialPort( "/dev/ttyUSB1", 115200)

f = open( ARGS[1], "r")

function send_slow(s)
    println( "Send: ", s)
    for (ci, c) in enumerate(s)
        write( sp, c)
        sleep( dilly)
    end
    return
end


while ! eof(f)
    # get header
    s = readline( f);
    if( s[1] == 'A' && s[2] == ':')
        println("Start file")
        send_slow( s * '\r')
        sleep(dally)
        # get user no
        s = readline( f)
        if( s[1] != 'U')
            println( "Expecting user no, saw ", s)
        else
            println("User no: ", s)
            send_slow( s * '\r')
            print( readavailable(sp))
            # get and send hex
            while true
                h::UInt8 = read(f, UInt8)
                ch = convert( Char,h);
#                println("Got: ", ch)
                if( ch == '>')
                    println("Ending")
                    write( sp, ch)
                    print( ch)
                    sleep( dilly)
                    # get 4 final chars
                    s = readline( f)
                    send_slow( s * '\r')
                    sleep( dally)
                    break
                else
                    write( sp, ch)
                    print( ch)
                    sleep( dilly)
                end
            end
        end
    else
        println( "Unknown: ", s)
    end
    
end    
