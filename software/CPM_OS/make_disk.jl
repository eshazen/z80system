#
# create an empty CP/M disk file
#
# optionally, label the tracks/sectors in ascii
#
using Printf

tracks = 77
sectors = 26
bytes = 128

label = false

if length(ARGS) < 1
    println( "usage: ./make_disk.jl file_name")
    exit(1);
end

fname = ARGS[1]
println( "Writing blank disk to: ", fname)
if( isfile(fname) == true)
    println("Warning!  File exists.  Please remove/rename")
    exit(1)
end


# disk = Array{UInt8}(undef, tracks, sectors, bytes)
disk = Array{UInt8}(undef, bytes, sectors, tracks)
fill!( disk, 0xe5)


if label == true
    seclab = Array{UInt8}(undef, bytes)
    fill!( seclab, 0xe5)
    for trk = 1:tracks
        for sec = 1:sectors
            labl = @sprintf "Track %d Sector %d" trk sec
#            println( "Track ", trk, " sec ", sec, " label: ", labl)
            for i = 1 : lastindex(labl)
                seclab[i+8] = labl[i]
            end
            seclab[bytes] = 0
            disk[ 1:bytes, sec, trk] = seclab
        end
    end
end

write( fname, disk)
