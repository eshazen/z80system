#
# load intel hex slowly
# 
    
using SerialPorts

# initialize the port
sp = SerialPort( "/dev/ttyUSB1", 115200)

f = open( ARGS[1], "r")

count = 0
hexstart = false
ending = false

while ! eof(f)
    c::UInt8 = read(f, UInt8)
    sleep( 0.05)
    if c < 0x20
        if c == 0x0a
            println("line break: 0x", string(c, base=16))
            write( sp, c)
            sleep(1)
            s = readavailable(sp)
            println("Got: ", s)
        end
    elseif( c == Int('>'))
        println("Ending...")
        global ending = true
        sleep(1)
        write( sp, c)
    elseif( c == Int(':'))
        global hexstart = true
        println("Starting hex")
        write( sp, c)
        sleep(1)
    else
        write( sp, c)
        if ending == true
            println("Ending: 0x", string(c, base=16))
        end
        if hexstart == true
            global count += 1
            if count % 256 == 0
                println("Sent ",count," bytes")
                while true
                    s = readavailable(sp)
                    println("Got: ", s)
                    s == '.' || break
                end
            end
        end
    end
end

println("EOF")
s = readavailable(sp)
println("Got: ", s)
