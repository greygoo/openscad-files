$fn = 8;

cover_height = 3;
cover_diameter = 70;
cover_pad = 2;

led_height = 20;
led_diameter = 5;

battery_height = 12;
battery_length = 45 + 5 + 1 -8;
battery_width = 2 * battery_height -1;

screw_diameter = 2.5;
screw_length = 15;

union(){
    difference(){
        cylinder(cover_height, cover_diameter/2, cover_diameter/2);
        //cylinder(led_height, led_diameter/2, led_diameter/2);

        // holes
        translate([0,cover_diameter/2 - 5,0]){
            translate([0,0,cover_height - screw_length]){
                cylinder(screw_length, screw_diameter/2, screw_diameter/2);
            }
        }

        translate([0,-(cover_diameter/2 - 5),0]){
            translate([0,0,cover_height - screw_length]){
                cylinder(screw_length, screw_diameter/2, screw_diameter/2);
            }
        }
        
            translate([cover_diameter/2 - 5,0,0]){
            translate([0,0,cover_height - screw_length]){
                cylinder(screw_length, screw_diameter/2, screw_diameter/2);
            }
        }

        translate([-(cover_diameter/2 - 5),0,0]){
            translate([0,0,cover_height - screw_length]){
                cylinder(screw_length, screw_diameter/2, screw_diameter/2);
            }
        }

        translate([battery_length/2+4,0,1.2]){
            cube([8,battery_width,2.4], center = true);
        }
    }

    translate([0,0,- cover_pad/2]){
        cube([battery_length, battery_width, cover_pad], center = true);
    }
}