#
# simple serial disk server for CP/M
# expect commands like:
# R 0A 11                Read track 10, sector 17
# reply: aa bb cc ... (128 bytes data) then " OK"
# W 0B 12 de ad be ...   Write track 11, sector 18 data de, ad, be... (128 bytes)
# reply:  OK or ERR
#
using LibSerialPort
using Printf

tracks = 77
sectors = 26
bytes = 128

track_size = sectors * bytes

secbuf = Array{UInt8}(undef, bytes)


if length(ARGS) < 2
    println("usage: ./disk_server file device [baud]")
    exit(1)
end

device = ARGS[2]
fname = ARGS[1]

baud = "9600"
if length(ARGS) > 2
    baud = ARGS[3]
end

println( "Using file ", fname, " port ", device, " speed ", baud)

if( isfile(fname) == false)
    println("No such file")
    exit(1)
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
    write(s, c)
    sleep( 0.01)
    return( clean_str(readavailable(s)));
end


# initialize the port
sp = LibSerialPort.open( device, parse( Int, baud))
f = open( fname, "r+")

println("Server listening on ", device)



while( true)
    s = readline(sp)
    print("Got command: ", s, "\n")
    if length(s) > 2
        t = split(s)
        track = parse(Int, s[3:4], base=16)
        sector = parse(Int, s[6:7], base=16)
        seek( f, track*track_size + (sector-1)*bytes)
    end
    
    if( s[1] == 'Q')
        println( "Shutting down")
        write( sp, "OK\n")
        close( f)
        exit(1)
    elseif ( s[1] == 'R')
        println( "Read: track=", track, " sector=", sector)
        if track < 0 || track > tracks || sector < 1 || sector > sectors
            write( sp, "ERR\n")
        else
            read!( f, secbuf)
            for i=1:bytes
                @printf sp "%02x" secbuf[i]
            end
            write( sp, " OK\n")
        end
    elseif( s[1] == 'W')
        println( "Write: track=", track, " sector=", sector)
        write( sp, "OK\n")
    else
        println( "Error")
        write( sp, "ERR\n")
    end
end
