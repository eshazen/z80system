#!/usr/bin/perl
# read a KLE JSON file
# output OpenSCAD function calls for each key
#   key( x, y, wid, "label")  (where x, y, wid are in U units (normally 0.75"))
# outtput another call to draw the PCB:
#   pcb( x0, y0, x1, y1)      (where coords are again in U units)

use strict;

use JSON::Parse 'parse_json';
use File::Slurper 'read_text';
use Data::Dumper;

my $na = $#ARGV + 1;
die "usage:  parse-kle.pl <json-file> [<scad-file>]\n"
    if( $na < 1);

open my $sf, "> $ARGV[1]" if( $na > 1);

my $json = read_text( $ARGV[0]);
my $perl = parse_json( $json);

die "Parse failed (top not ARRAY)" if( ref($perl) ne "ARRAY");

my $mods;

my $pos_x = 0;
my $pos_y = 0;
my $wide = 1;

# keep track of limits
my ($x0, $y0, $x1, $y1) = (99, 99, -99, -99);

sub esc {
    my $kee = shift @_;
    $kee =~ s/\\/\\\\/g; # backslash
    $kee =~ s/\"/\\\"/g; # quotes
    return $kee;
}

foreach my $row ( @{$perl}) {
    my $type = ref($row);
    if( $type eq "HASH") {	# meta-data
	print "Found meta-data:\n";
	print Dumper( $row);
    } elsif( $type eq "ARRAY") {
	print "Keyboard row:\n";
	foreach my $kee ( @{$row}) {
	    my $ktype = ref($kee);
	    if( $ktype eq "") {
		# Fix the string
		my @lin = split /\n/, $kee;
		my $nlin = $#lin + 1;
		my ($l1, $l2, $l3) = ( "", "", "");
		if( $sf) {
		    if( $nlin == 1) { # single caption, center vertically
			$l2 = esc($lin[0]);
		    } elsif( $nlin == 2) {
			$l1 = esc($lin[0]);
			$l3 = esc($lin[1]);
		    } elsif( $nlin == 3) {
			$l1 = esc($lin[0]);
			$l2 = esc($lin[1]);
			$l3 = esc($lin[2]);
		    }
		    print $sf qq{key($pos_x,$pos_y,$wide, "$l1", "$l2", "$l3");\n};
		    $x0 = $pos_x if( $pos_x < $x0);
		    $y0 = $pos_y if( $pos_y < $y0);
		    $x1 = $pos_x + $wide if( $pos_x + $wide > $x1);
		    $y1 = $pos_y + 1 if( $pos_y + 1 > $y1);
		}
		printf "  Key: [%-10s]  %s\n", $kee, $mods;

		$mods = "";
		$pos_x += $wide;
		$wide = 1;
	    } elsif( $ktype eq "HASH") {
		foreach my $mkey ( keys %{$kee} ) {
		    my $mval = $kee->{$mkey};
		    if( ref($mval) ne "") {
			$mods .= " $mkey (" . Dumper($mval) .")";
		    } else {
			if( $mkey eq "w") {
			    print "set width = $mval\n";
			    $wide = $mval;
			} elsif( $mkey eq "x") {
			    $pos_x += $mval;
			}
			$mods .= " $mkey -> $mval";
		    }
		}
	    }
	}
	$pos_y += 1;
	$wide = 1;
	$pos_x = 0;
    } else {
	die "Unknown type: $type";
    }
}

print "PCB limits: ($x0, $y0) to ($x1, $y1)\n";
print $sf "pcb( $x0, $y0, $x1, $y1);\n" if( $sf);

