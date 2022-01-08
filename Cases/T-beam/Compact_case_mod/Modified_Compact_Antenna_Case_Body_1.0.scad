//$fn                 = 32;
val_minkowski       = 2;

dim_usbcut          = [10,13.2,4.4];
offset_usbcut       = [40,49.15,5.9];
rotation_usbcut     = 0;

dim_frontcut        = [30,20,12];
dim_frontcover      = [21.4,1.2,10.006];
offset_frontcut     = [7,112,0.2];
offset_frontcover   = offset_frontcut + [0,-1.4,0];
rotation_frontcut   = 35;
rotation_frontcover = rotation_frontcut;

dim_sidecut         = [63,10.5,3.2];
dim_sidecover       = dim_sidecut;
dim_sidelower       = [16,14.5,12];
dim_sideundercut    = [dim_sidecut[0]+(2*val_minkowski),
                       dim_sidecut[1]+(2*val_minkowski),
                       val_minkowski+5];
offset_sidecut      = [20,74,7];
offset_sidecover    = offset_sidecut + [0,0,0];
offset_sidelower    = offset_sidecut + [val_minkowski,val_minkowski,-val_minkowski];
offset_sideundercut = offset_sidecut + 
                      [val_minkowski,val_minkowski,dim_sidecover[2]];
rotation_sidecut    = [0,0,180];
rotation_sidecover  = rotation_sidecut;
rotation_sidelower  = rotation_sidecut;
rotation_sideundercut = rotation_sidecut;

//create cutouts from fixed original stl file
difference(){
    import("original_files/Compact_Antenna_Case_Body_fixed_1.0.STL", convexity=5);
    //remove front part of old antenna
    translate(offset_frontcut)
        rotate(rotation_frontcut)
                cube(dim_frontcut);
    //remove side part for new antenna
    translate(offset_sidecut)
        rotate(rotation_sidecut)
            cube(dim_sidecut);
    //remove side lower part
    translate(offset_sideundercut)
        rotate(rotation_sideundercut)
            cube(dim_sideundercut);
    //increase usb opening to allow for normal cables to fit
    translate(offset_usbcut)
        rotate(rotation_usbcut)
            cube(dim_usbcut);
}

//add cover
difference() {
    union(){
        //add side cover
        translate(offset_sidecover)
            rotate(rotation_sidecover)
                minkowski(){
                    difference(){
                        cube(dim_sidecover);
                        translate([-8.5,0,13.5])
                            rotate([0,45,0])
                                cube([dim_sidecut[1],
                                       dim_sidecut[1],
                                       dim_sidecut[2]]);
                    }
                    sphere(val_minkowski);
                }
    }

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
        #cube(dim_frontcover);