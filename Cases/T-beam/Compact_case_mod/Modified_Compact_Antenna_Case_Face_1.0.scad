val_minkowski       = 2;

dim_usbcut          = [10,13.2,4.4];
offset_usbcut       = [40,49.15,-0.2];
rotation_usbcut     = 0;

dim_topcut          = [81,16,5.1];
dim_topcover        = dim_topcut + [0,-4,-4];
offset_topcut       = [22.7,54,6] ;
offset_topcover     = offset_topcut + [-2.1,0,-1.1];
rotation_topcut     = 90;
rotation_topcover   = rotation_topcut;

dim_frontcut        = [30,20,6.1];
dim_frontcover      = [18,2,5];
offset_frontcut     = [7,112,0];
offset_frontcover   = offset_frontcut + [0.5,-2.1,0];
rotation_frontcut   = 35;
rotation_frontcover = rotation_frontcut;

dim_sidecut         = [61,10.5,9.1];
dim_sidecover       = dim_sidecut;
dim_sidelower       = [16.2,14.5,5];
dim_sideundercut    = [dim_sidecut[0]+(2*val_minkowski),
                       dim_sidecut[1]+(2*val_minkowski),
                       val_minkowski];
offset_sidecut      = [20,74,0];
offset_sidecover    = offset_sidecut + [0,0,0];
offset_sidelower    = offset_sidecut + [val_minkowski,val_minkowski,0];
offset_sideundercut = offset_sidecut + [val_minkowski,val_minkowski,-val_minkowski];
rotation_sidecut    = 180;
rotation_sidecover  = rotation_sidecut;
rotation_sidelower  = rotation_sidecut;
rotation_sideundercut = rotation_sidecut;


difference(){
    import("original_files/Compact_Antenna_Case_Face_1.0.STL", convexity=3);
    //remove top part of old antenna
    translate(offset_topcut)
        rotate(rotation_topcut)
            cube(dim_topcut);
    //remove front part of old antenna
    translate(offset_frontcut)
        rotate(rotation_frontcut)
                cube(dim_frontcut);
    //remove side part for new antenna
    translate(offset_sidecut)
        rotate(rotation_sidecut)
            cube(dim_sidecut);
    //increase usb opening to allow for normal cables to fit
    translate(offset_usbcut)
        rotate(rotation_usbcut)
            cube(dim_usbcut);
}



//add cover
difference() {
    union(){
        //add top cover
        translate(offset_topcover)
            rotate(rotation_topcover)
                cube(dim_topcover);
        //add side cover
        translate(offset_sidecover)
            rotate(rotation_sidecover)
                minkowski(){
                    difference(){
                        cube(dim_sidecover);
                        //translate([14,offset_sidecut[1]-dim_sidecut[1],13])
                        translate([-8.5,0,13.5])
                            rotate([0,45,0])
                                cube([dim_sidecut[1],
                                       dim_sidecut[1],
                                       dim_sidecut[2]]);
                    }
                    sphere(val_minkowski);
                }
    }
    //remove front part
    translate(offset_frontcut)
        rotate(rotation_frontcut)
            cube(dim_frontcut);
    //remove side cover inside
    translate(offset_sidecut)
        rotate(rotation_sidecut)
            cube(dim_sidecut);
    //remove side cover lower inner part
    translate(offset_sidelower)
        rotate(rotation_sidelower)
            cube(dim_sidelower);
    //remove side cover lower part
    translate(offset_sideundercut)
        rotate(rotation_sideundercut)
            cube(dim_sideundercut);
}

//add front cover
translate(offset_frontcover)
    rotate(rotation_frontcover)
        cube(dim_frontcover);

