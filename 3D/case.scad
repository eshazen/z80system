//
// system with 8-slot (parameterized) RC2014 backplane
//


// base geometry
base_wid = 12;
base_hgt = 9.7;
case_thick = 0.125;

// side profile
side_hgt = 1.0;

module case_side_at( x, y, z) {
     translate( [x, y, z]) {
     // sides, for now just rectangular
	  cube( [case_thick, base_hgt, side_hgt]);
     }
}

module case_front_at( x, y, z) {
     translate( [x, y, z]) {
	  cube( [base_wid, case_thick, side_hgt]);
     }
}

module case_at( x, y, z) {
     translate( [x, y, z]) {
	  // base plate
	  cube( [base_wid, base_hgt, case_thick]);
	  case_side_at( 0, 0, case_thick);
	  case_side_at( base_wid, 0, case_thick);
	  case_front_at( 0, 0, case_thick);
	  case_front_at( 0, base_hgt, case_thick);
	  translate( [0, 0, side_hgt+case_thick])
	       %cube( [base_wid, base_hgt, case_thick]);
     }
}
