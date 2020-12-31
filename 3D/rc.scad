include <keyboard.scad>
include <my_keys.scad>
include <lcd.scad>
include <rc2014.scad>
include <cpu.scad>
include <video.scad>
include <case.scad>

lcd_at( 0, 1, 0.5);

for( i = [0 : 5]) {
     board_at( 6.5+0.7*i, 1, 0.25);
}

%case_at( -0.5, -3.5, -0.5);
