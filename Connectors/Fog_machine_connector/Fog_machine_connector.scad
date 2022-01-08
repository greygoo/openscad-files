fog_inner_diameter = 12;
fog_outer_diameter = 21;
fog_fan_width      = 2;
fog_fan_height     = 5;
wall               = 2;
height             = 30;
foot_diameter      = 40;


module crosscut(diameter, width, height) {
    cube([diameter, width, height], center = true);
    rotate(90) cube([diameter, width, height], center = true);
}

difference(){
    difference(){
        cylinder(height, foot_diameter/2, fog_outer_diameter/2 + wall, center = true);
        cylinder(height, fog_inner_diameter/2, fog_inner_diameter/2, center = true);
    }
    crosscut(fog_outer_diameter, fog_fan_width, height);
    translate([0,0,-fog_fan_height])
        rotate(45)
            crosscut(foot_diameter, 15, height);
}
