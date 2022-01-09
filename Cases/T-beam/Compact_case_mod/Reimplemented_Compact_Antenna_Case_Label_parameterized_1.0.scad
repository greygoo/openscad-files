$fn=32;

// parameters for Nameplate
button1 = "RST";
button2 = "SET";
button3 = "PWR";
font    = "Liberation Sans";
size    = 4;
spacing = 0.9;

// static values, don't change
plate_height = 13.61;
plate_length = 25.535;
plate_depth  = 1;
plate_frame  = 2;
orig_size    = 4.5;
minkowski_val = 0.8;


//original stl for reference
translate([-plate_height/2,-plate_length/2,-plate_depth/2])
    translate([-33.46,-63.3175,-6])
        %import("original_files/Compact_Antenna_Case_Label_1.0.STL", convexity=5);

//recreate plate
difference(){
    translate([minkowski_val,0,0]){
        minkowski(){
            cube([plate_height,plate_length-2*minkowski_val,plate_depth/2],center=true);
            cylinder(r=minkowski_val,h=plate_depth/2,center=true);
        }
    }
    translate([plate_height/2+minkowski_val,minkowski_val,0])
        cube([2*minkowski_val,plate_length+2*minkowski_val,plate_depth],center=true);


    //Button 1
    translate([0,plate_length/2-size/2-plate_frame-(orig_size-size)/2,0])
        linear_extrude(plate_depth/2)
            #text(text=button1,
                 font=font,
                 size=size,
                 halign="center",
                 valign="center",
                 spacing=spacing);

    //Button 2
    translate([0,0,0])
        linear_extrude(plate_depth/2)
            #text(text=button2,
                 font=font,
                 size=size,
                 halign="center",
                 valign="center",
                 spacing=spacing);

    //Button 3
    translate([0,-(plate_length/2-size/2-plate_frame-(orig_size-size)/2),0])
        linear_extrude(plate_depth/2)
            #text(text=button3,
                 font=font,
                 size=size,
                 halign="center",
                 valign="center",
                 spacing=spacing);
             }