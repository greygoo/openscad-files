$fn = 32;

translate([-15.8,-19.9,-4.4])
    %import("original_files/Compact_Antenna_Case_ScreenShield_1.0.STL", convexity=5);

// display parameters
display_length      = 26;
display_height      = 16;
minkowski_display   = 1;

// values based on case, don't change
frame_depth             = 2.95;
frame_overhang_width    = 1.8;
frame_overhang_height   = 1;
frame_height            = 24.7;
frame_length            = 32.2;

display_offset_x    = 1.3;
display_offset_y    = 1.3;

minkowski_big       = 2.8;
minkowski_small     = 1;


difference(){
    // frame
    union(){ 
        // frame bottom plate
        translate([minkowski_big,minkowski_big,0]){
            minkowski(){
                cube([frame_height-2*minkowski_big,
                      frame_length-2*minkowski_big,
                      frame_overhang_height/2]);
                cylinder(r=minkowski_big,h=frame_overhang_height/2);
            }
        }

        // frame inner raised part
        translate([frame_overhang_width+minkowski_small,
                   frame_overhang_width+minkowski_small,
                   0]){
            minkowski(){
                cube([frame_height-2*(frame_overhang_width+minkowski_small),
                      frame_length-2*(frame_overhang_width+minkowski_small),
                      frame_depth/2]);
                cylinder(r=minkowski_small,h=frame_depth/2);
            }
        }
    }
    //cutting out display opening
    translate([display_offset_x+frame_overhang_width+minkowski_display,
               display_offset_y+frame_overhang_width+minkowski_display,
               0]){
        minkowski(){
            cube([display_height-2*minkowski_display,
                  display_length-2*minkowski_display,
                  frame_depth/2]);
            cylinder(r=minkowski_display,h=frame_depth/2);
        }
    }
}