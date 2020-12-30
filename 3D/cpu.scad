
scal = 1/25.4;
module cpu_at( x, y, z) {
     translate( [x, y, z])
	  scale( [scal, scal, scal])
	  import("cpu_board.stl");
}
