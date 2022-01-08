// table module

table_height    = 800;
table_width     = 1200;
table_length    = 600;
table_leg_width = 50;

// example rendering with above values
table(table_height,table_width,table_length,table_leg_width);


module table(height,
             width,
             length,
             leg_width)
{
    cutout_width    = width - 2*leg_width;
    cutout_height   = height - leg_width;
    
    difference(){
        // main frame
        cube([width, length, height]);
        
        // leg cutout
        translate([leg_width,0,0])
            cube([cutout_width, length, cutout_height]);
    }
}