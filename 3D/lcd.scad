include <cpm.scad>

// LCD size
lcd_wid = 5.669;
lcd_hgt = 4.134;
lcd_thk = 0.591;

module lcd_at( x, y, z) {
     translate( [x, y, z]) {
	  // LCD screen
	  color( [0.3, 0.3, 0.3, 1.0])
	       cube( [lcd_wid, lcd_hgt, lcd_thk]);
	  // fake text on the screen
	  translate( [0.1, lcd_hgt-0.1, lcd_thk+0.00])
	       show_text( strings, lcd_hgt/40);
     }
}
