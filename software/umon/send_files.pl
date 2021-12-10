#!/usr/bin/perl
#
# send files listed on command line to CP/M
# (assumes CP/M is running)
# drive A must have HEXLOAD and PIP
#
# download each file to A, copy to B
#
# usage: ./send_files [-dX] [-t] files...
#
use strict;

my $test = 0;

my $srec_cat = "/usr/bin/srec_cat";
my $send_hex = "/home/hazen/work/z80system/software/umon/send_hex";

sub dosys {
    my $cmd = shift @_;
    print "$cmd\n";
    system($cmd) if( $test == 0);
}

my $disk = "A";

foreach my $f ( @ARGV) {
    print "Processing $f\n";

    if( $f =~ /^-/) {
	print "Option: $f\n";
	if( $f =~ /^-[dD][A-Pa-p]/) {
	    ($disk) = $f =~ /^-[dD]([A-Pa-p])/;
	    $disk = uc $disk;
	    print "Disk = '$disk'\n";
	} elsif( $f =~ /-[tT]/) {
	    $test = 1;
	    print "Test mode\n";
	} else {
	    print("Unknown option: $f\n");
	    exit;
	}
    } else {

	my $path;
	my $file = $f;
	my @a = split /\//,$f;
	if( $#a > 0) {
	    $path = join( '/', @a[1..$#a]);
	    $file = $a[$#a];
	}
	dosys("$srec_cat $f -binary -offset 0x100 -o temp.hex -intel");
	dosys("$send_hex temp.hex " .$disk . ":" . $file);
    }
}
