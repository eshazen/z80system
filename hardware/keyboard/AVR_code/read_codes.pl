#!/usr/bin/perl
#
# read hand-typed ascii code table
# generate C static data tables normal[] and shifted[]
# (control handled in the C code)

use Data::Dumper;

while( $line = <>) {
    chomp $line;

    # skip blank lines and comments
    next if( length($line) < 2 || $line =~ /^#/);

    @d = split /\s+/,$line;
    if( $#d < 1 && $#d > 2) {
	print "bad format in $line\n";
	next;
    }

    $ncode = hex( $d[0]);
    $norm = $d[1];
    $shft = '';
    if( $#d == 2) {
	$shft = $d[2];
    }

    $line_norm[$ncode] = $line;

    if( length($norm) == 1) {
	$inorm = ord($norm);
	$tbl_norm[$ncode] = $inorm;
    } else {
	$tbl_norm[$ncode] = 27 if( $norm eq "ESC");
	$tbl_norm[$ncode] = 8 if( $norm eq "BS");
	$tbl_norm[$ncode] = 9 if( $norm eq "TAB");
	$tbl_norm[$ncode] = 13 if( $norm eq "CR");
	$tbl_norm[$ncode] = 32 if( $norm eq "SPC");
	$tbl_norm[$ncode] = 0x80 if( $norm eq "SHFT");
    }

    if( length($shft) == 1) {
	$ishft = ord($shft);
	$tbl_shft[$ncode] = $ishft
    } else {
	$tbl_shft[$ncode] = 0x7f if( $shft eq "DEL");
    }
}

print "static unsigned int normal[] = {\n";
for( $i=0; $i<64; $i++) {
    printf "   0x%02x,  // [%02x] %s\n", $tbl_norm[$i], $i, $line_norm[$i];
}
print "};\n";

print "static unsigned int shifted[] = {\n";
for( $i=0; $i<64; $i++) {
    printf "   0x%02x,  // [%02x] %s\n", $tbl_shft[$i], $i, $line_norm[$i];
}
print "};\n";

