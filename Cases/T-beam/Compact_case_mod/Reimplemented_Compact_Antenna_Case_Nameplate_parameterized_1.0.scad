// parameters for Nameplate
name    = "TSM";
font    = "Liberation Sans:style=Bold";
size    = 8;
spacing = 1;

// static values, don't change
plate_height = 10;
plate_length = 28;
plate_depth  = 2;


difference(){
    translate([-24.8,-8.8,-4.4])
        import("original_files/Compact_Antenna_Case_Nameplate_1.0.STL", convexity=5);


    translate([0,0,plate_depth/2])
        linear_extrude(plate_depth/2)
            text(text=name,
                 font=font,
                 size=size,
                 halign="center",
                 valign="center",
                 spacing=spacing);
}