//
// fuse/switch bracket
//

sw_wid = 75;
sw_len = 55;
sw_thk = 1.6;
sw_wall = 15;

// e = 0.1;

hole_dia = 4.0;

module hole( x, y, dia=4) {
     translate( [x, y, -e])
	  cylinder( h=sw_thk+2*e, d=dia);
}

module slot( x, y, sw_wid, hgt) {
  translate( [x, y, -e])
     cube( [sw_wid, hgt, sw_thk+2*e]);
}

module righty( w, h, t) {
  linear_extrude( height=t, convexity=10) {
       polygon( [ [0,0], [w, 0], [0, h], [0, 0]]);
  }
}

module bracket() {
  scale( [1/25.4, 1/25.4, 1/25.4]) {
     
  difference() {
    cube( [sw_wid, sw_len, sw_thk]);	/* plate */
    hole( 10, 14);
    hole( 10+40, 14);
    slot( (40-29)/2+10, 14-21/2, 29, 21);
    hole( 65, 14, 6.5);
    hole( 30, 40, 15);		/* fuse holder */
    translate( [55, 3, sw_thk/2])
	 linear_extrude( height=sw_thk) {
	     text( "OFF", size=6);
    }
    translate( [55, 20, sw_thk/2])
	 linear_extrude( height=sw_thk) {
	     text( "ON", size=6);
    }
    
		 
  }
  difference() {
    translate( [0, 0, -sw_wall])
     cube( [sw_wid, sw_thk, sw_wall+e]);
    rotate( [90, 0, 0])
      translate( [0, 0, -sw_thk]) {
	 hole( 7, -sw_wall/2);
	 hole( sw_wid-7, -sw_wall/2);
      }
  }
  translate( [0, 0, e])
  rotate( [0, 90, 0]) {
       righty( sw_wall, sw_wall, sw_thk);
       translate( [0, 0, sw_wid-sw_thk])
	           righty( sw_wall, sw_wall, sw_thk);
  }
  }
}

