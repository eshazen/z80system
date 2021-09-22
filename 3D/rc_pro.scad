include <keyboard.scad>
include <my_keys.scad>
include <lcd.scad>
include <rc2014.scad>
include <cpu.scad>
include <video.scad>
include <case.scad>

lcd_at( 0, 1.5, 0.5);
my_keys();

slots = 8;

module pro_backplane() {
     color("blue");
     cube( [0.6+0.65*slots-1, 5, .063]);
     for( i = [0 : slots-1]) {
	  board_at( 0.3+0.6*i, 0.5, 0.125);
     }
}


%case_at( -0.5, -3.5, -0.5);
translate( [6, 1, 0])
pro_backplane();

