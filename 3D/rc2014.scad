
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
