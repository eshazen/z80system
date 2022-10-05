//
// retro-z80 system case
// copied 2022-10-02 from bottom.scan
// updating for laser-cut version with separate panels and interlocking tabs
//
mm=25.4;
e = 0.01;
g = 0.005;			/* mechanical gap */

wid = 12.5;
hgt = 14.0;

bthk = 3.0/mm;			/* bottom thickness */
sthk = 2.0/mm;			/* side thickness */

thk = 10/mm;			/* missed thickness */

case_hgt = 3.25;

sbh = 0.5;

nbtab = 15;			/* number of tabs on each side of base */


bracket_shift = 0.25;		/* shift switch bracket forward */

// animation:  $t runs (0...1)
// explo = $t * 0.25;

explo = abs($t-0.5)*0.25;			/* "explode" factor */
// explo = 0;

//
// generate a set of tabs
// automatically enlarge by e
//
module tabs( length, 		/* length in X */
	     num, 		/* number of tabs */
	     pol,		/* polarity 0=cut 1=create */
	     wid,		/* width in Y */
	     hgt		/* height in Z */
     )
{
     tlen = length / num;	/* length of one tab */
     de = g;			/* clearance set by global g */
     
     // // draw a "ruler"
     // cube( [length, e, e]);
     // for( i= [0 : 1: num]) {
     // 	  translate( [ tlen*i, 0, 0])
     // 	       color("black")
     // 	       cube( [e, e, 2]);
     // }
	  

     translate( [-de, 0, 0]) {

	  if( pol) {
	       for( i= [ 0 : 2 : num-1 ]) {
		    translate( [ tlen*i, -de, -de]) {
			 cube( [tlen+2*de, wid+2*de, hgt+2*de]);
		    }
	       }
	  } else {
	       for( i= [ 1 : 2 : num-1 ]) {
		    translate( [ tlen*i, -de, -de]) {
			 cube( [tlen+2*de, wid+2*de, hgt+2*de]);
		    }
	       }
	  }

     }
}


include <switch.scad>

module hole_at( x, y, d) {
     translate( [x, y, -e])
	  cylinder( h=bthk+2*e, d=d);
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

module kb_plate_bracket() {
  difference() {
    cube( [sbh, kb_case_dy, sthk]);
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
     translate( [sthk+g, 0, e]) rotate( [0, 90, 0]) kb_plate_bracket();
     translate( [wid-g-sthk, 0, e]) rotate( [0, 90, 0]) kb_plate_bracket();
     // front lip
     translate( [0, -sthk+e, 0]) {
	  difference() {
	       cube( [wid+sthk, sthk, sthk]);
	       rotate( [-kb_slope, 0, 0])
		    translate( [-e, -2*e, -sthk+g])
		    cube( [wid+sthk+2*e, sthk*2, sthk]);
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

ps_z = 1.5;

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
	  scale( [1/mm, 1/mm, 1/mm])
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
slot_xoff = ((bp_wid)-100/mm)/2;

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

     translate( [0, 0, -explo])
     difference() {
	  cube( [wid, hgt, bthk]);

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

	  // cut out tabs on left edge
	  translate( [sthk, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( hgt, nbtab, 1, sthk, bthk);

	  // tabs on right edge
	  translate( [wid, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( hgt, nbtab, 1, sthk, bthk);

	  // tabs on back edge
	  translate( [0, hgt-sthk, 0])
	       tabs( wid, nbtab, 1, sthk, bthk);

	  // tabs on front edge
	  tabs( wid, nbtab, 1, sthk, bthk);

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
	       translate( [0, abs(ps_hgt-hd_hgt), hd_thk+0.1])
		    ps_box();
	  }
     }

     translate( [bp_x, bp_y, 0.5]) bp_pcb();
     bp_boards();

     // switch bracket
     color("black") translate( [0, hgt-bracket_shift, bthk]) rotate( [90, 00, 270]) bracket();

}


// rounded slot
module slot( w, l) {
     translate( [w/2, w/2, -e]) {
	  cylinder( h=bthk+2*e, r=w/2);
	  translate( [0, l-w, 0])
	       cylinder( h=bthk+2*e, r=w/2);
     }
     translate( [0, w/2, -e])
	  cube( [w, l-w, bthk+2*e]);
}


// top lid
module lid_flat() {
     difference() {
	  cube( [wid, hgt-kb_case_dy , sthk]);
	  for( x=[.5: 1: wid-.5])
	       translate( [x, 2, 0])
	       slot( .25, 5);
	  // cut out tabs at back and front
	  tabs( wid, nbtab, 1, sthk, sthk);
	  translate( [0, hgt-kb_case_dy-sthk, 0])
	       tabs( wid, nbtab, 1, sthk, sthk);	       
	  // cut out tabs and left and right
	  translate( [sthk, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( hgt-kb_case_dy, 7, 1, sthk, sthk);
	  translate( [wid, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( hgt-kb_case_dy, 7, 1, sthk, sthk);

     }

     // delete 3D printed bracket
     //     translate( [sthk+g, 0, -sbh+e]) rotate( [90, 0, 90]) lid_bracket();
     //     translate( [wid-sthk-g, 0, -sbh+e]) rotate( [90, 0, 90]) lid_bracket();
}

module lid_bracket() {
     translate( [sbh, 0, 0])
     difference() {
	  cube( [hgt-kb_case_dy-2*sbh, sbh, sthk]);
	  hole_at( 2*sbh, sbh/2, .125);
	  hole_at( hgt-kb_case_dy-4*sbh, sbh/2, .125);
     }
}

module lid() {
     translate( [0, kb_case_dy, explo+case_hgt-sthk])
     lid_flat();
}

// side (left or right)

// left side
module side( left) {

     rpoints = [ [0,0], [0, case_hgt], [hgt-kb_case_dy, case_hgt], [hgt-kb_case_dy, kb_case_rear_z],
		[hgt, kb_case_front_z], [hgt, 0], [0,0]];

     difference() {
	  // draw the side outline
	  linear_extrude(sthk) { polygon( points=rpoints);};

	  if( left) {
	       // cut out the switch bracket
	       translate( [bracket_shift-g, -e, -e])
		    cube( [sw_wid/mm+2*g, sw_len/mm+e+g+bthk, sthk+2*e]);
	  }

	  // cut out the cooling slots
	  for( x=[sw_wid/mm+.5:0.75:hgt-kb_case_dy]) {
	       translate( [x, 0.75, 0])
		    slot( 0.2, 2);
	  }

	  // cut out tabs on bottom
	  tabs( hgt, nbtab, 0, bthk, sthk);

	  // tabs on top
	  translate( [0, case_hgt-sthk, 0])
	       tabs( hgt-kb_case_dy, 7, 0, sthk, sthk);

	  // cut out tabs on back
	  translate( [sthk, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( case_hgt, 5, 0, sthk, sthk);


	  // cut out tabs on lower front
	  translate( [hgt, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( kb_case_front_z, 5, 0, sthk, sthk);

	  // tabs upper front
	  translate( [hgt-kb_case_dy, kb_case_rear_z, 0])
	       rotate( [0, 0, 90])
	       tabs( case_hgt-kb_case_rear_z, 5, 0, sthk, sthk);
     }
}


// back
module back() {

     bpoints = [ [0,0], [0, case_hgt], [wid, case_hgt], 
		 [wid, 0], [2, 0], [2,2], [5,2], [5,0], [0,0] ];
     difference() {
	  linear_extrude(sthk) { polygon( points=bpoints); };
	  // top tabs
	  tabs( wid, nbtab, 0, sthk, sthk);
	  // bottom tabs
	  translate( [0, case_hgt-sthk, 0])
	       tabs( wid, nbtab, 0, bthk, sthk);	       
	  // tabs at left and right
	  translate( [sthk, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( case_hgt, 5, 1, sthk, sthk);
	  translate( [wid, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( case_hgt, 5, 1, sthk, sthk);
     }
	  
}

// front
module front() {
     fpoints = [ [0,0], [0, kb_case_front_z], [wid, kb_case_front_z], [wid, 0] ];

     difference() {
	  linear_extrude(sthk) { polygon( points=fpoints);};
	  // bottom tabs
	  tabs( wid, nbtab, 0, bthk, sthk);
	  // left and right tabs
	  translate( [sthk, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( kb_case_front_z, 5, 1, sthk, sthk);
	  translate( [wid, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( kb_case_front_z, 5, 1, sthk, sthk);
     }
}

ubh = 0.3;

module upfront_bracket() {
     upf_b_y = case_hgt-kb_case_rear_z;
     difference() {
	  cube( [ubh, upf_b_y, sthk]);
	  hole_at( ubh/2, .25, .125);
	  hole_at( ubh/2, upf_b_y-.25, .125);
     }
}
	  

module upfront_flat() {
     difference() {
	  cube( [wid, case_hgt-kb_case_rear_z, sthk]);
	  // tabs top and bottom
	  tabs( wid, nbtab, 0, sthk, sthk);
	  translate( [0, case_hgt-kb_case_rear_z-sthk, 0])
	       tabs( wid, nbtab, 0, sthk, sthk);
	  // tabs left and right
	  translate( [sthk, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( case_hgt-kb_case_rear_z, 5, 1, sthk, sthk);
	  translate( [wid, 0, 0])
	       rotate( [0, 0, 90])
	       tabs( case_hgt-kb_case_rear_z, 5, 1, sthk, sthk);
     }
	  

//     translate( [sthk+g, 0, e]) rotate( [0, 90, 0]) upfront_bracket();
//     translate( [wid-sthk-g, 0, e]) rotate( [0, 90, 0]) upfront_bracket();
}

// upper front
module upfront() {
     translate( [0, kb_case_flat_dy+2*sthk-explo, kb_case_rear_z])
	  rotate( [90, 0, 0])
	  upfront_flat();
}

module sides() {
  rotate( [90, 0, -90]) {
    translate([-hgt,0,-sthk]) {
	 translate( [0, 0, explo])
//	 color("lightgreen") side(1);
	 side(1);
	 translate( [0, 0, -explo])
	 translate( [0, 0, sthk-wid])
	      color("lightgreen") side(0);
    }
  }

  rotate( [90, 0, 0])  translate( [0, 0, -hgt-explo]) color("beige")   back();

  rotate( [90, 0, 0]) translate( [0, 0, explo-sthk]) color("blue") front();
}

module draw() {
     scale( [mm, mm, mm]) {
       color("cyan") plate();
//       sides();
	//  side(1);

//	back();

//       parts();


       	// kb_plate_rot();
//	 color("violet") lid();
//	 color("pink") upfront();
	 
//	  upfront_flat();

//	 lid_flat();
//	color("magenta") lid();
     }


}


projection()
draw();

// flat KB plate for printing
//rotate( [180, 0, 0]) scale( [mm, mm, mm]) kb_plate();
// rotate( [180, 0, 0]) scale( [mm, mm, mm]) upfront_flat();
// rotate( [180, 0, 0]) scale( [mm, mm, mm]) lid_flat();
