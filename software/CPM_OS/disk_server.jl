#
# simple serial disk server for CP/M
#
# expect commands like:
#
# S1                     Select disk 1 (zero-based numbering)
# R 0A 11                Read track 10, sector 17
#     reply: Kaabbcc ... (128 bytes data) or E
# W 0B 12 aabbcc ...   Write track 11, sector 18 data aa, bb, cc... (128 bytes)
#     reply:  K or E
#
using LibSerialPort
using Printf

tracks = 77
sectors = 26
bytes = 128

track_size = sectors * bytes

secbuf = Array{UInt8}(undef, bytes)

disk = 1

quiet = false

if length(ARGS) < 3
    println("usage: ./disk_server device baud disk1 [disk2...]")
    println("       device CON for terminal")
    exit(1)
end

device = ARGS[1]
baud = ARGS[2]

diskf = Array{String}(undef,4)

for i=3:length(ARGS)
    global diskf[i-2] = ARGS[i]
    println("Disk ", i-2, "=", diskf[i-2])
    if isfile(diskf[i-2]) == false
        println("No such file: ",diskf[i-2])
        exit(1)
    end
end

console = false
ndisk = length(ARGS)-2

if device == "CON" || device == "con"
    console = true
end

fp = Array{IOStream}(undef,4)
    
for i=1:ndisk
    println("Opening ", diskf[i])
    global fp[i] = open( diskf[i], "r+")
end

println( "Open with device=", device, " speed=", baud, " disks=", ndisk)

# initialize the port

if console == false
    global sp = LibSerialPort.open( device, parse( Int, baud))
else
    global sp = stdin
end

while( true)
    s = readline(sp)
#    print("Got command: ", s, "\n")
    if length(s) > 6
        t = split(s)
        track = parse(Int, s[3:4], base=16) # zero-based
        sector = parse(Int, s[6:7], base=16) # one-based
        seek( fp[disk], track*track_size + (sector-1)*bytes)
    end
    
    if( s[1] == 'Q')
        println( "Shutting down")
        write( sp, "K\n")
        exit(1)
    elseif ( s[1] == 'S')
        if length(s) != 2
            write( sp, "E\n")
        else
            n = parse(Int, s[2])+1
            println("Select disk ", n)
            if n < 1 || n > ndisk
                write( sp, "E\n")
            else
                global disk = n
                write( sp, "K\n")
            end
        end

    elseif ( s[1] == 'R')        
        if length(s) != 7
            write( sp, "E\n")
        else
            if quiet == false
                println( "R", track, " S", sector)
            end
            if  track < 0 || track > tracks || sector < 1 || sector > sectors
                write( sp, "E\n")
                println("Error")
            else
                write( sp, "K")
                read!( fp[disk], secbuf)
                for i=1:bytes
                    @printf sp "%02X" secbuf[i]
                end
                write( sp, "\n")
                if console == true
                    # dump in "canonical" hex/ascii format
                    for i=1:16:bytes
                        print( string(i,base=16), ": ")
                        for j=0:15
                            @printf " %02X" secbuf[i+j]
                        end
                        print(" \"")
                        for j=0:15
                            c = secbuf[i+j]
                            if c > 0x20 && c <= 0x7e
                                print( Char(c))
                            else
                                print(".")
                            end
                        end
                        print("\"\n")
                    end
                end
            end
        end
    elseif( s[1] == 'W')
        if quiet == false
            println( "W", track, " S", sector)
        end
        if length(s) != 264
            write( sp, "E\n")
            println("Error")
        else
            for i=1:bytes
                j = 7+2*i
                secbuf[i] = parse(Int, s[j:j+1], base=16)
            end
            write( fp[disk], secbuf)
            write( sp, "K\n")
        end
    else
        println( "Error")
        write( sp, "E\n")
    end
end
