dim=[40,60,80];
loc=[10,20];
w=2;
x=30;
y=20;
z=10;
shape="round";

%cube(dim);

translate([x/2,0,y/2]){ // move to zero
    //front
    rotate([90,0,0])
        translate([0,0,+z/2-w]) // move into wall
            mkshape(shape);

    //back
    translate([dim[0]-x,0,0])
    rotate([270,0,0])
        translate([0,0,+z/2-w+dim[1]])
            mkshape(shape);
}


translate([0,x/2,y/2]){            
    //right
    rotate([90,0,90])
        translate([0,0,+z/2-w+dim[0]])
            mkshape(shape);
    
    //left
    translate([0,dim[1]-x,0])
    rotate([90,0,270])
        translate([0,0,+z/2-w])
            mkshape(shape);
}

translate([x/2,y/2,0]){            
    //top
    rotate([0,0,0])
        translate([0,0,+z/2-w+dim[2]])
            mkshape(shape);
    
    //bottom
    translate([0,dim[1]-y,0])
    rotate([180,0,0])
        translate([0,0,+z/2-w])
            mkshape(shape);
}

module mkshape(shape){
    if(shape=="square"){
        cube([x,y,z],center=true);
    }
    if(shape=="round"){
        translate([-x/2,-y/2,0])
        resize([0,y,0])
            cylinder(d=x,h=z,center=true);
    }
}
