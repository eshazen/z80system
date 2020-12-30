
// Cherry MX switch body dimensions
mx_wid = 0.614;
mx_hgt = 0.457;
mx_stem = 0.157;
mx_shgt = 0.142;

// approximate keycap dimensions
kc_wid = 0.709;
kc_hgt = 0.370;

// keyboard parameters
kb_u = 0.75;			// unit spacing

// text parameters
txt_h = 0.15;

// PCB parameters
pcb_t = 0.063;			// thickness
pcb_xb = 0.1;			// X border
pcb_yb = 0.1;			// Y border


// draw pcb
module pcb( x0, y0, x1, y1) {
     translate( [x0*kb_u-pcb_xb, -(y1-1)*kb_u-pcb_yb, -pcb_t])
	  color([ 0, 0.5, 0, 0.5])
	  cube( [(x1-x0)*kb_u+2*pcb_xb, (y1-y0)*kb_u+2*pcb_yb, pcb_t]);
}

// draw a keycap
module cap(wid) {
     scale( [wid, 1, 1])
	  rotate( [0, 0, 45])
	  color( [0.5, 0.5, 0.5, 0.75])
	  cylinder( h=kc_hgt, d1=1.414*kc_wid, d2=1.414*0.75*kc_wid, $fn=4);
}

// draw an MX switch from lower left corner
// params are in KB U units
module key(x,y,wide,lab1,lab2,lab3) {
     translate( [(x+(wide-1)/2)*kb_u, -y*kb_u, 0]) {
	  color([0.2, 0.2, 0.2, 1.0]) cube( [mx_wid, mx_wid, mx_hgt]);
	  translate( [(mx_wid/2-mx_stem/2), (mx_wid/2-mx_stem/2), mx_hgt])
	       cube( [mx_stem, mx_stem, mx_shgt]);
	  // 3 lines of text
	  translate( [mx_wid/2, mx_wid/2, mx_hgt+mx_shgt+0.35]) {
	       // top line
	       translate( [0, mx_hgt*0.33, 0])
		    color("yellow")
		    linear_extrude( 0.005)
		    text(lab1,size=txt_h,halign="center",valign="center");
	       // middle line
	       color("yellow")
	       linear_extrude( 0.005)
	       text(lab2,size=txt_h,halign="center",valign="center");
	       // bottom line
	       translate( [0, -mx_hgt*0.33, 0])
		    color("yellow")
		    linear_extrude( 0.005)
		    text(lab3,size=txt_h,halign="center",valign="center");
	  }
	  translate( [mx_wid/2, mx_wid/2, mx_hgt+0.1])
	       cap(wide);
     }
}

