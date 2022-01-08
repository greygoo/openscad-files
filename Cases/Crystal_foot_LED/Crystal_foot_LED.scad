$fn = 8;

foot_height = 20;
foot_diameter = 70;

switch_length = 10.5;
switch_width = 10;
switch_height = 5.5;

led_height = 20;
led_diameter = 5;

battery_height = 12;
battery_length = 45 + 5 + 1;
battery_width = 2 * battery_height;

screw_diameter = 2.5;
screw_length = 15;

crystal_foot_width = 2.15;
crystal_foot_length = 2.7;
crystal_foot_height = 5;
crystal_foot_distance = 16.5;



module crystal_foot(){
    translate([0,0,crystal_foot_height/2])
    cube([crystal_foot_length, crystal_foot_width, crystal_foot_height],center = true);
}


difference(){
    cylinder(foot_height, foot_diameter/2, foot_diameter/2);
    cylinder(led_height, led_diameter/2, led_diameter/2);


    translate([0,0,- battery_height/2 + foot_height]){
        cube([battery_length, battery_width, battery_height], center = true);
    }
    
    translate([0,foot_diameter/2 - 5,0]){
        translate([0,0,foot_height - screw_length]){
            cylinder(screw_length, screw_diameter/2, screw_diameter/2);
        }
    }

    translate([0,-(foot_diameter/2 - 5),0]){
        translate([0,0,foot_height - screw_length]){
            cylinder(screw_length, screw_diameter/2, screw_diameter/2);
        }
    }
    
        translate([foot_diameter/2 - 5,0,0]){
        translate([0,0,foot_height - screw_length]){
            cylinder(screw_length, screw_diameter/2, screw_diameter/2);
        }
    }

    translate([-(foot_diameter/2 - 5),0,0]){
        translate([0,0,foot_height - screw_length]){
            cylinder(screw_length, screw_diameter/2, screw_diameter/2);
        }
    }
    
    translate([foot_diameter/2-7.3,-switch_length +4,foot_height-battery_height+switch_height]){
        rotate([0,0,67.5]){
            cube([switch_length, switch_width, switch_height], center = true);
        }
    }
    translate([0,(crystal_foot_distance - crystal_foot_width)/2,0]) crystal_foot();
    translate([0,-(crystal_foot_distance - crystal_foot_width)/2,0]) crystal_foot();
}
