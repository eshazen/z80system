#
# create an empty CP/M disk file
#

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

tracks = 77
sectors = 26
bytes = 128


disk = Array{UInt8}(undef, tracks, sectors, bytes)
fill!( disk, 0xe5)
write( fname, disk)
