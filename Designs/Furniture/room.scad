// room plan

use <rack.scad>;
use <bed.scad>;
use <table.scad>;


room_dim    = [5000,5000,2300];
wall        = 300;

door_height = 2000;
door_width  = 1000;
door_offset = 3000;

window_height   = 600;
window_width    = 800;
window_offset_z = 1500;
window_offset_x = 2000;

// room
difference(){
    translate([-wall,-wall,-wall])
        // room + walls
        cube(room_dim+[2*wall,2*wall,wall]);
    
        // room inside
        cube(room_dim);
    
        // door
        translate([door_offset,-wall,0])
            cube([door_width,wall,door_height]);
    
        // window
        translate([0,window_offset_x,window_offset_z])
            rotate([0,0,-270])        
                cube([window_width,wall,window_height]);
}