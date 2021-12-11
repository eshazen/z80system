//
// simple case for minimial-60 keyboaard
//

pcb_wid = 302.26;
pcb_hgt = 109.22;

case_wid = 311;
case_hgt = 121;
case_front = 15.9;     // 5/8
case_rear =  38.1;      // 1.5
x_hole = [ 3.81, 161.3, 298.5];
// y_hole = [ 3.81, 105.4];   in plane of PCB
y_hole = [ 3.81, 107.0 ];  // on bottom

x_marg = (case_wid - (x_hole[2]-x_hole[0]))/4;
y_marg = (case_hgt - 103.2)/4;

// bit of trig
opp = case_rear - case_front;
adj = case_hgt;
slope = sqrt( opp*opp+adj*adj);
angle = atan( opp/adj);

hole_dia = 3.2;

e = 0.1;
thick = 1.6;

$fn=48;

module hole_at( x, y, dia) {
     translate( [x, y, -e])
	  cylinder( h=30, d=dia);
}

//
// sloping panel, not part of the main print
//
module sloping() {
     translate( [0, 0, case_front])
	  rotate( [angle, 0, 0])
	  linear_extrude( height=thick) {
	  polygon( points = [[ 0,0], [case_wid, 0], [case_wid, slope],
			     [ 0, slope], [0,0]]);
     };
}

module end() {
     linear_extrude( height=thick) {
	  polygon( points = [ [0,0], [case_hgt, 0], [case_hgt, case_rear+thick],
			      [0, case_front+thick], [0, 0]]);
	  }
}

module case() {
     difference() {
	  cube( [case_wid, case_hgt, thick]);
	  for( x=x_hole) {
	       for( y=y_hole) {
		    hole_at( x+x_marg, y+y_marg, hole_dia);
	       }
	  }
     }
     cube( [case_wid, thick, case_front+thick]);
     translate( [0, case_hgt-thick, 0])
	  cube( [case_wid, thick, case_rear+thick]);

     rotate( [90, 0, 90]) {
	  end();
	  translate( [0, 0, case_wid])
	       end();
     }
}

case();
