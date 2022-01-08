$fn=32;

laptop_height       = 21;
connector_width     = 8;
connector_length    = 40;
wall                = 4;
screw_diameter      = 3;

connector(connector_length,connector_width,laptop_height,wall,screw_diameter);

module connector(l,w,h,wall,s){
    extra = s+2*wall;
    difference(){
        hull(){
            cube([l,w,h]+[0,2*wall,2*wall]);
            translate([0,-extra,0]) cube([l,w+2*wall+2*extra,wall]);
        }
        union(){
            translate([0,wall,wall]) cube([l,w+extra+wall,h]);
            screw_holes(screw_diameter,wall,connector_width,connector_length);
        }
    }
}

//#screw_holes(screw_diameter,wall,connector_width,connector_length);

module screw_holes(s,wall,w,l){
    
    module screw_hole(s,wall){
        cylinder(wall,s,s);
        translate([0,0,wall/2])
            cylinder(wall/2,s,2*s);
    }
    
    translate([s+wall,-wall,0]){
        screw_hole(s,wall);
        translate([0,0,wall])
            cylinder(laptop_height+2*wall,2*s,2*s);
    }
    
    translate([s+wall,l-2*wall,0]){
        screw_hole(s,wall);
        
    }
    translate([l-s-wall,- wall,0]){
        #screw_hole(s,wall);
        translate([0,0,wall])
            cylinder(laptop_height+2*wall,2*s,2*s);
    }
    
    translate([l-s-wall,l-2*wall,0])
        screw_hole(s,wall);
}

