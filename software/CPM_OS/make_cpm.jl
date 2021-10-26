#
# read cp/m hex file, write a cp/m disk
#
# FIXME:  start writing track 0, sector 2
#
    
using SerialPorts
using Printf

dump = false

# set to size for CP/M
# offset down 1 sector

# 3400 for 20K
# E400 for 64K
offset = 0xE400

tracks = 77
sectors = 26
bytes = 128

track_size = sectors * bytes

secbuf = Array{UInt8}(undef, bytes)

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

#---- main ----

if length(ARGS) < 2
    println("usage:  ./make_cpm cpm.hex disk.bin")
    exit(1)
end

fcpm = ARGS[1]
fdsk = ARGS[2]

if isfile(fcpm) == false
    println( "CP/M file ", fcpm, " not found")
    exit(1)
end

f = open( fcpm, "r")

# create an empty disk
disk = Array{UInt8}(undef, bytes, sectors, tracks)

# read from file
filedata = read(fdsk)
println("Read from file, size=", length(filedata))

if length(filedata) != bytes*sectors*tracks
    println("Wrong size!  expecting ", bytes*sectors*tracks)
    exit(1)
end

# copy data
indx = 1
for trk=1:tracks, sec=1:sectors, byt=1:bytes
    disk[ byt, sec, trk] = filedata[indx]
    global indx += 1
end

# create an empty memory image 64K
mem = Array{UInt8}(undef, 0x10000)
fill!( mem, 0)

firstaddr = 0
lastaddr = 0

while ! eof(f)
    s = readline( f)
    if s[1] == ':'
        ilen = parse( Int, s[2:3], base=16)
        iaddr = parse( Int, s[4:7], base=16)
        ityp = parse( Int, s[8:9], base=16)
#        print( "Type=", ityp, " addr=", string(iaddr, base=16), " len=", ilen, "\n")
        if firstaddr == 0
            global firstaddr = iaddr
            if firstaddr != offset
                println("Expected first addr of ", string(offset, base=16), " but saw ", string(firstaddr, base=16))
            end
        end
        if ityp == 0
            for i=1:ilen
                n = 8+2*i
                idat = parse( UInt8, s[n:n+1], base=16)
                eaddr = iaddr+i-1
                mem[eaddr] = idat
                if eaddr > lastaddr
                    global lastaddr = eaddr
                end
            end
        end
    end
end

println( "Memory filled from ", string(firstaddr, base=16), " to ", string(lastaddr, base=16))

if dump == true
    for i=firstaddr:16:lastaddr
        print( string(i,base=16), ": ")
        for j=0:15
            @printf " %02x" mem[i+j]
        end
        print(" \"")
        for j=0:15
            c = mem[i+j]
            if c > 0x20 && c <= 0x7e
                print( Char(c))
            else
                print(".")
            end
        end
        print("\"\n")
    end
end


    
# copy data to disk
addr = offset - bytes           # skip sector 1 on track 0
for trk=1:tracks, sec=1:sectors, byt=1:bytes
    if addr >= firstaddr && addr <= lastaddr
        disk[ byt, sec, trk] = mem[addr]
    end
    global addr += 1
    if addr > lastaddr
        break
    end
end

println("writing to ",fdsk)
write( fdsk, disk)
