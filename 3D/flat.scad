include <keyboard.scad>
include <my_keys.scad>
include <lcd.scad>
include <rc2014.scad>
include <cpu.scad>
include <video.scad>
include <case.scad>

module drawit() {
// lcd_at( 2.5, 1, 0.5);
//board_at( 6, 1, 0.25);
color("orange")
cpu_at( -1, 6.25, -0.0630);

color("brown")
video_at( 4.75, 7, -0.0630);

// case_at( -0.5, -3.5, -0.5);
// my_keys();
}

translate([0,3.5,1]) drawit();
