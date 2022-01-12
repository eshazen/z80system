
// bottom plate
// all in inches for now

wid = 12.5;
hgt = 14.0;
// thk = 0.125;
 thk=0.092;

case_hgt = 3.25;

e = 0.01;
g = 0.01;			/* mechanical gap */

mhd = 0.150;

include <switch.scad>

module hole_at( x, y, d) {
     translate( [x, y, -e])
	  cylinder( h=thk+2*e, d=d);
}

kb_wid = 11.9;
kb_hgt = 4.3;
kb_marg = (wid-kb_wid)/2;

kb_slope = 10;			/* KB slope in degrees */

kb_case_front_z = 5/8;
kb_case_rear_z = 1.5;
kb_case_flat_dy = 4.75;
kb_case_dy = kb_case_flat_dy/cos(kb_slope);

kb_hole_offset = 0.15;
kb_hole_dy = kb_hgt - kb_hole_offset*2;
kb_flat_dy = cos(kb_slope)*kb_hole_dy;

kb_case_left_marg = 0.35;	/* offset from edge of PCB to case opening */
kb_case_right_marg = 0.25;
kb_case_bottom_marg = 0.20;
kb_case_top_marg = 0.30;

module kb_pcb() {
     color("green") {
	  difference() {
	       cube( [14.5-2.6, 6.5-2.2, .063]);
	       hole_at( kb_hole_offset, kb_hole_offset, 0.125);
	       hole_at( kb_wid-kb_hole_offset, kb_hole_offset, 0.125);
	       hole_at( kb_wid-kb_hole_offset, kb_hgt-kb_hole_offset, 0.125);
	       hole_at( kb_hole_offset, kb_hgt-kb_hole_offset, 0.125);
	  }
     }
}

sbh = 0.5;

module kb_plate_bracket() {
  difference() {
    cube( [sbh, kb_case_dy, thk]);
    hole_at( sbh/2, 0.5, 0.125);
    hole_at( sbh/2, kb_case_dy-0.5, 0.125);
  }
}

module kb_plate() {
  difference() {
    // the main plate
    cube( [wid+thk, kb_case_dy, thk]);
    // cutout for the keys
    translate( [kb_marg+kb_case_left_marg, kb_marg+kb_case_bottom_marg, -e])
      cube( [kb_wid-kb_case_left_marg-kb_case_right_marg,
	     kb_hgt-kb_case_top_marg-kb_case_bottom_marg, 1.6+2*e]);
  }
  // side brackets
  translate( [thk+g, 0, e]) rotate( [0, 90, 0]) kb_plate_bracket();
  translate( [wid-g-thk, 0, e]) rotate( [0, 90, 0]) kb_plate_bracket();
  // front lip
  translate( [0, -thk, 0]) {
    difference() {
      cube( [wid+thk, thk, thk]);
      rotate( [-kb_slope, 0, 0])
	translate( [-e, -2*e, -thk+g])
      cube( [wid+thk+2*e, thk*2, thk]);
    }
  }
}

module kb_plate_rot() {
  color("brown") {
    translate([ 0, 0, kb_case_front_z]) {
      rotate( [ kb_slope, 0, 0]) {
	kb_plate();
      }
    }
  }
}

//
// hard disk mount per Toshiba
// ref lower left corner of drive
//
hd_wid = 4.0;
hd_hgt = 5.787;
hd_thk = 1.028;			/* NOTE: depends on unit, up to 1.654 */
hd_hole_dia = 0.150;

hd_x = 1.5;
hd_y = 5.5;

module hd_holes() {
     translate( [0.125, 1.162, 0]) {
	  hole_at( 0, 0, hd_hole_dia);
	  hole_at( 0, 1.25, hd_hole_dia);
	  hole_at( 0, 3, hd_hole_dia);

	  hole_at( 3.75, 0, hd_hole_dia);
	  hole_at( 3.75, 1.25, hd_hole_dia);
	  hole_at( 3.75, 3, hd_hole_dia);
     }
}

module hd_box() {
     cube( [hd_wid, hd_hgt, hd_thk]);
}

ps_wid = 3.75;
ps_hgt = 5.0;
ps_thk = 1.75;

module ps_box() {
     cube( [ps_wid, ps_hgt, ps_z]);
}

// backplane PRO size (confirm!)
bp_wid = 5.0;
bp_hgt = 7.75;

// backplane PRO hole spacing (confirm)
bp_hdx = 4.5;
bp_hdy = 7.25;

// bp position on chassis
bp_x = 6.5;
bp_y = 5.75;



// Draw a standard RC2014 board vertically

// points from http://rc2014.co.uk/1377/module-template/
// (rounded a bit, in mm)
// corner cut so we can merge a circle for the radius
rc_points = [ [0,0], [0,35], [15,50], [99.1-5, 50], [99.1, 45],
	      [99.1, 0], [0, 0]];

module board_at( x, y, z) {
     translate( [x, y, z])
	  scale( [1/25.4, 1/25.4, 1/25.4])
	  rotate( [90, 0, 90])
	  color( [0.4, 0, 0.5, 1])
	  linear_extrude( 1.6) {
	  union() {
	       polygon( points=rc_points);
	       translate( [99.1-5, 45])
		    circle( r=5.1);
	  }
     }
}


module bp_holes() {
     translate( [(bp_wid-bp_hdx)/2, (bp_hgt-bp_hdy)/2, 0]) {
	  hole_at( 0, 0, 0.150);
	  hole_at( bp_hdx, 0, 0.150);
	  hole_at( bp_hdx, bp_hdy, 0.150);
	  hole_at( 0, bp_hdy, 0.150);
     }
}

module bp_pcb() {
     color("blue") cube( [bp_wid, bp_hgt, 0.063]);
}

slot_spc = 0.65;
slot_num = 12;
slot_yoff = ((bp_hgt)-((slot_num-1)*slot_spc))/2;
slot_xoff = ((bp_wid)-100/25.4)/2;

module bp_boards() {
     translate( [bp_x+slot_xoff, bp_y+slot_yoff, 0.7]) {
	  rotate( [0, 0, -90]) {
	       for( i=[0:slot_num-1]) {
		    board_at( -i*slot_spc, 0, 0);
	       }
	  }
     }
}


module case_holes() {
     for( x=[0.25:1.5:wid]) {
	  for( y=[0.25:1.5:hgt]) {
	       hole_at( x, y, 0.15);
	  }
     }
}


module plate() {
     difference() {
	  cube( [wid, hgt, thk]);

	  // keyboard mount holes
	  translate( [ kb_marg, kb_marg, 0]) {
	       hole_at( kb_hole_offset, kb_hole_offset, 0.125);
	       hole_at( kb_wid-kb_hole_offset, kb_hole_offset, 0.125);
	       hole_at( kb_hole_offset, kb_hole_offset+kb_flat_dy, 0.125);
	       hole_at( kb_wid-kb_hole_offset, kb_hole_offset+kb_flat_dy, 0.125);
	  }

	  // HD mount holes
	  translate( [hd_x, hd_y, 0]) hd_holes();

	  translate( [bp_x, bp_y, 0]) bp_holes();

	  case_holes();
     }
}



$fn=32;

module parts() {
     translate( [ kb_marg, kb_marg, 0.5])
	  rotate( [ kb_slope, 0, 0])
	  kb_pcb();

     translate( [hd_x, hd_y, 0.5]) {
	  color("grey") {
	       hd_box();
	       translate( [0, abs(ps_hgt-hd_hgt), hd_thk+0.25])
		    ps_box();
	  }
     }

     translate( [bp_x, bp_y, 0.5]) bp_pcb();
     bp_boards();

     // switch bracket
     color("black") translate( [0, hgt-thk, thk]) rotate( [90, 00, 270]) bracket();

}


// rounded slot
module slot( w, l) {
     translate( [w/2, w/2, -e]) {
	  cylinder( h=thk+2*e, r=w/2);
	  translate( [0, l-w, 0])
	       cylinder( h=thk+2*e, r=w/2);
     }
     translate( [0, w/2, -e])
	  cube( [w, l-w, thk+2*e]);
}


// left side
module left() {

     lpoints = [ [0,thk+sw_len/25.4], [0, case_hgt], [hgt-kb_case_dy, case_hgt], [hgt-kb_case_dy, 1.5],
		[hgt, 5/8], [hgt, 0], [sw_wid/25.4+thk, 0], [sw_wid/25.4+thk, thk+sw_len/25.4] ];

     difference() {
	  linear_extrude(thk) { polygon( points=lpoints);};
	  for( x=[sw_wid/25.4+.5:0.75:hgt-kb_case_dy]) {
	       translate( [x, 0.75, 0])
		    slot( 0.2, 2);
	  }
     }
}


// right side
module right() {

     rpoints = [ [0,0], [0, case_hgt], [hgt-kb_case_dy, case_hgt], [hgt-kb_case_dy, 1.5],
		[hgt, 5/8], [hgt, 0], [0,0]];

     difference() {
	  linear_extrude(thk) { polygon( points=rpoints);};
	  for( x=[sw_wid/25.4+.5:0.75:hgt-kb_case_dy]) {
	       translate( [x, 0.75, 0])
		    slot( 0.2, 2);
	  }
     }
}

// back
module back() {

     bpoints = [ [0,0], [0, case_hgt], [wid, case_hgt], 
		 [wid, 0], [2, 0], [2,2], [5,2], [5,0], [0,0] ];

     linear_extrude(thk) { polygon( points=bpoints);};
}

// front
module front() {
     fpoints = [ [0,0], [0, 5/8], [wid+thk, 5/8], [wid+thk, 0] ];

     linear_extrude(thk) { polygon( points=fpoints);};
}

// upper front
module upfront() {
     translate( [0, kb_case_flat_dy+thk, kb_case_rear_z])
	  rotate( [90, 0, 0])
	  color("brown") cube( [wid+thk, case_hgt-kb_case_rear_z, thk]);
}

module sides() {
  rotate( [90, 0, -90]) {
    translate([-hgt,0,-thk]) {
      left();
      translate( [0, 0, -wid])
	right();
    }
  }

  rotate( [90, 0, 0])  translate( [0, 0, -hgt])    back();

  rotate( [90, 0, 0]) front();
}

module draw() {
     scale( [25.4, 25.4, 25.4]) {
       % plate();

        % sides();
       // parts();


       //	  kb_plate_rot();
	  //	  upfront();

    }


}


//projection()
 draw();

// flat KB plate for printing
// rotate( [180, 0, 0]) scale( [25.4, 25.4, 25.4]) kb_plate();
