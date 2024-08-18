
e = 0.1;
$fn = 32;

wid = 8.5;
len = 3.5;
hgt = 3.5;

pin_dia = 0.5;
pin_len = (7.2-3.5);
pin_spc = 2.5;

t_trav = 1.0;
t_xy = 1.5;
t_len = 3.5;

module pin_at( x, y) {
     translate( [x, y, -pin_len])
	  cylinder( h=pin_len+e, d=pin_dia);
}

module body() {
     translate( [-wid/2, -len/2, 0])
	  cube( [wid, len, hgt]);
     pin_at( 0, 0);
     pin_at( -pin_spc, 0);
     pin_at( pin_spc, 0);
     translate( [-t_trav-t_xy/2, -t_xy/2, hgt-e])
	  cube( [t_xy, t_xy, t_len]);
}

body();
