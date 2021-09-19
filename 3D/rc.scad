include <keyboard.scad>
include <my_keys.scad>
include <lcd.scad>
include <rc2014.scad>
include <cpu.scad>
include <video.scad>
include <case.scad>

lcd_at( 0, 1, 0.5);
my_keys();

for( i = [0 : 8]) {
     board_at( 6.+0.6*i, 1, 0.25);
}

%case_at( -0.5, -3.5, -0.5);

