// GENERAL VALUES
WALL            = 1.5;
RIM_HEIGHT      = 3;
RIM_GAP         = [0.3, 0.4, 0.4];
LID_HEIGHT      = WALL + 2;

// RASPBERRY PI VALUES
PI_DIM              = [31.2, 67.2, 7];
PI_PADDING          = [0.4,0.4,0];
PI_HOLE             = [3.5,3.5,0];
PI_HOLE_RADIUS      = 2.75/2;
PI_SCREWHOLE_RADIUS = 2.5;
PI_SCREWHOLE_DEPTH  = 10;
PI_CASE             = PI_DIM + PI_PADDING + [2 * WALL, 2 * WALL, 2 * WALL];

PI_USB1_DIM         = [9.2, WALL, 3.6];
PI_USB2_DIM         = [9.2, WALL, 3.6];
PI_HDMI_DIM         = [16, WALL, 6.2];
PI_SDCARD_DIM       = [13.2, WALL, 2.8];
PI_CAMERA_DIM       = [18.4, WALL, 2.4];
PI_GPIO_DIM         = [8,52,WALL];

// CAMERA VALUES
CAM_DIM             = [5,5,3];
CAM_PADDING         = [0.4,0.4,0];
CAM_CASE            = CAM_DIM + CAM_PADDING + 2 * [WALL,WALL,WALL];


// WHAT TO RENDER
pi_case_bottom();
//pi_case_top();


module pi_case(){
    difference(){
        cube(PI_CASE, center = true);
        cube(PI_DIM + 2 * PI_PADDING, center = true);
        pi_mounts();
        pi_openings();
    }
}

module pi_lid_mask_small(){
    // LID 
    translate([0,0, PI_CASE[2]/2 - (LID_HEIGHT - RIM_HEIGHT)/2])
        cube([PI_CASE[0],
              PI_CASE[1],
              LID_HEIGHT - RIM_HEIGHT],
              center = true);

    // RIM1
    translate([0,0, PI_CASE[2]/2 - RIM_HEIGHT/2 - (LID_HEIGHT - RIM_HEIGHT)])
        cube([PI_CASE[0] - WALL,
              PI_CASE[1] - WALL,
              RIM_HEIGHT] - RIM_GAP/2,
              center = true);
}

module pi_lid_mask_big(){
    // LID 
    translate([0,0, PI_CASE[2]/2 - (LID_HEIGHT - RIM_HEIGHT)/2])
        cube([PI_CASE[0],
              PI_CASE[1],
              LID_HEIGHT - RIM_HEIGHT],
              center = true);
    
    // RIM2
    translate([0,0, PI_CASE[2]/2 - RIM_HEIGHT/2 - (LID_HEIGHT - RIM_HEIGHT)])
        cube([PI_CASE[0] - WALL,
              PI_CASE[1] - WALL,
              RIM_HEIGHT] + RIM_GAP/2,
              center = true);
}

module pi_case_bottom(){
    difference(){
        pi_case();
        pi_lid_mask_big();
    }
}

module pi_case_top(){
    intersection(){
        pi_case();
        pi_lid_mask_small();
    }
}

module pi_hole(){
    translate([])
        cylinder(WALL,
                 PI_HOLE_RADIUS,
                 PI_HOLE_RADIUS,
                 center = true);
}



module pi_mounts(){
    PI_MOUNT_OFFSET_X = PI_DIM[0]/2 - PI_HOLE[0];
    PI_MOUNT_OFFSET_Y = PI_DIM[1]/2 - PI_HOLE[1];

    translate([0,0,- PI_CASE[2]/2 + WALL/2]) {
        // back right mount
        translate([PI_MOUNT_OFFSET_X,
                   PI_MOUNT_OFFSET_Y,
                   0]) pi_hole();
        
        // back left mount
        translate([- PI_MOUNT_OFFSET_X,
                   PI_MOUNT_OFFSET_Y,
                   0]) pi_hole();
        
        // front left mount
        translate([- PI_MOUNT_OFFSET_X,
                   - PI_MOUNT_OFFSET_Y,
                   0]) pi_hole();

        // front right mount
        translate([PI_MOUNT_OFFSET_X,
                   - PI_MOUNT_OFFSET_Y,
                   0]) pi_hole();
    }
}

module pi_openings(){
    PI_USB1_LOC   = [- PI_CASE[0]/2 + WALL/2,
                   - PI_DIM[1]/2 + PI_USB1_DIM[0]/2 + 7.4,
                   - PI_CASE[2]/2 + PI_USB1_DIM[2]/2 +  
                     WALL + PI_PADDING[2] + 2];

    PI_USB2_LOC   = [- PI_CASE[0]/2 + WALL/2,
                   - PI_DIM[1]/2 + PI_USB2_DIM[0]/2 + 20.1,
                   - PI_CASE[2]/2 + PI_USB2_DIM[2]/2 +  
                     WALL + PI_PADDING[2] + 2];

    PI_HDMI_LOC   = [- PI_CASE[0]/2 + WALL/2,
                   - PI_DIM[1]/2 + PI_HDMI_DIM[0]/2 + 34,
                   - PI_CASE[2]/2 + PI_HDMI_DIM[2]/2 +  
                     WALL + PI_PADDING[2]];
                     
    PI_SDCARD_LOC = [- PI_DIM[0]/2 + PI_SDCARD_DIM[0]/2 + 10.9,
                    + PI_CASE[1]/2 - WALL/2,
                    - PI_CASE[2]/2 + PI_SDCARD_DIM[2]/2 + 
                     WALL + PI_PADDING[2] + 1.6];

    PI_CAMERA_LOC = [- PI_DIM[0]/2 + PI_CAMERA_DIM[0]/2 + 6.2,
                    - PI_CASE[1]/2 + WALL/2,
                    - PI_CASE[2]/2 + PI_CAMERA_DIM[2]/2 + 
                     WALL + PI_PADDING[2] + 1.4];
                     
    PI_GPIO_LOC   = [PI_DIM[0]/2 - PI_GPIO_DIM[0]/2,
                     0,
                     PI_CASE[2]/2 - WALL/2 ];
    
    translate(PI_USB1_LOC)
        rotate ([0,0,90])
            cube(PI_USB1_DIM, center = true);

    translate(PI_USB2_LOC)
        rotate ([0,0,90])
            cube(PI_USB2_DIM, center = true);

    translate(PI_HDMI_LOC)
        rotate ([0,0,90])
            cube(PI_HDMI_DIM, center = true);

    translate(PI_SDCARD_LOC)
        cube(PI_SDCARD_DIM, center = true);

    translate(PI_CAMERA_LOC)
        cube(PI_CAMERA_DIM, center = true);
    
    translate(PI_GPIO_LOC)
        cube(PI_GPIO_DIM, center = true);
}
