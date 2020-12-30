// video card
scal = 1/25.4;
module video_at( x, y, z) {
     translate( [x, y, z])
	  scale( [scal, scal, scal])
	  import("mc6845.stl");
}
