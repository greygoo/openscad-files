//module to create openings for a electronics board
// d        - cube dimension [x,y,z] 
// cuts     - array of cuts to be created
// extend   - amount to extend outwards
// move     - move inwards(-)/outwards(+)
//
// cuts: 
//          [[[x,y],    // location
//            [x,y],    // size
//            length,   // length
//            side,     // side
//            shape],   // shape
//           [...],...]
//      
//      location:
//          x/y coordinates of lower left of opening,
//          meassured from the boards left top
//      size:
//          x/y dimension of the opening
//      length:
//          length of the opening
//      side:
//          Side of the board, one of
//          front,back,left,right,top,bottom
//      shape:
//          shape of the opening, one of
//           square/rnd,
//           sqr_cone/rnd_cone,
//           sqr_indent/rnd_indent,
//           sqr_button/rnd_button

// Example
//$fn=32;
//board_dim=[20,20,1.5];
//cut_location=[0,0];
//cut_size=[3,2];
//cut_length=5;
//extend=7;
//move=0;
//cuts=[[cut_location,cut_size,cut_length,"front","sqr"],
//      [cut_location,cut_size,cut_length,"back","sqr_cone"],
//      [cut_location,cut_size,cut_length,"left","sqr_indent"],
//      [cut_location,cut_size,cut_length,"right","sqr_button"],
//      [cut_location,cut_size,cut_length,"top","rnd_indent"],
//      [cut_location,cut_size,cut_length,"bottom","rnd_button"]];
//      
//%cube(board_dim);
//make_cuts_v2(dim=board_dim,
//             cuts=cuts,
//             extend=extend,
//             move=move);

module make_cuts_v2(dim=[10,10,0],
                    cuts=[[[0,0],[10,10,10],1,"front","sqr"]],
                    extend=0,
                    move=0){
                     
    for(cut=cuts){
        loc_x   = cut[0][0];
        loc_y   = cut[0][1];
        x       = cut[1][0];
        y       = cut[1][1];
        l       = cut[2];
        side    = cut[3];
        shape   = cut[4];
        

        if(side=="front" || side=="back" || side==0 || side==1) {
            translate([x/2,0,y/2]+[0,0,dim[2]]){        // move x,y to 0 and on top of board
                if(side=="front" || side==0)
                    translate([loc_x,0,loc_y])          // move to location
                        rotate([90,0,0])                // rotate up
                            translate([0,0,+l/2])       // move up to z=0
                                mkshape(x,y,l,shape,extend,move);   // create centered shape

                if(side=="back" || side==1)
                    translate([dim[0]-x,0,0]+[-loc_x,0,loc_y])
                        rotate([270,0,0])
                            translate([0,0,+l/2+dim[1]])
                                mkshape(x,y,l,shape,extend,move);
            }
        }

        if(side=="right" || side=="left" || side==2 || side==3 ) {
            translate([0,x/2,y/2]+[0,0,dim[2]]) {
                if(side=="right" || side==3)
                    translate([0,loc_x,loc_y]+[0,0,0])
                        rotate([90,0,90])
                            translate([0,0,+l/2+dim[0]])
                                mkshape(x,y,l,shape,extend,move);
            
                if(side=="left" || side==2)
                    translate([0,dim[1]-x,0]+[0,-loc_x,loc_y])
                        rotate([90,0,270])
                            translate([0,0,+l/2])
                                mkshape(x,y,l,shape,extend,move);
            }
        }

        if(side=="top" || side=="bottom" || side==4 || side==5 ) {
            translate([x/2,y/2,0]) {          
                if(side=="top" || side==4)
                    translate([loc_x,loc_y,0])
                        rotate([0,0,0])
                            translate([0,0,+l/2+dim[2]])
                                mkshape(x,y,l,shape,extend,move);
                
                if(side=="bottom" || side==5)
                    translate([0,dim[1]-y,0]+[loc_x,-loc_y,0])
                        rotate([180,0,0])
                            translate([0,0,+l/2]) 
                                mkshape(x,y,l,shape,extend,move);
            }
        }
    }
}

// Create shapes that will be cut out
module mkshape(x,y,l,shape,extend,move){
    // square shapes
    if(shape=="sqr"){
        translate([0,0,extend/2+move]){
            cube([x,y,l+extend],center=true);
        }
    }
    if(shape=="sqr_cone"){
        translate([0,0,move]){
            hull(){
                cube([x,y,l],center=true);
                translate([0,0,l/2-0.000001/2]){
                    cube([2*x,2*y,0.000001],center=true);
                }
                if(extend>=0){
                    translate([0,0,l/2+extend-0.000001/2]){
                        cube([2*x,2*y,0.000001],center=true);
                    }
                }
            }
        }
    }
    if(shape=="sqr_indent"){
        translate([0,0,move]){
            cube([x,y,l],center=true);
            translate([0,0,+l/4+extend/2]){
                cube([2*x,2*y,l/2+extend],center=true);
            }
        }
    }
    if(shape=="sqr_button"){
        translate([0,0,move]){
            cube([x,y,l],center=true);
            translate([0,0,-l/4]){
                cube([2*x,2*y,l/2],center=true);
            }
            translate([0,0,l/2+extend/2]){
                cube([2*x,2*y,extend],center=true);
            }
        }
    }
    
    // round shapes
    if(shape=="rnd"){
        translate([-x/2,-y/2,extend/2+move]){
            resize([0,y,0]){
                cylinder(d=x,h=l+extend,center=true);
            }
        }
    }
    if(shape=="rnd_cone"){
        translate([-x/2,-y/2,+move]){
            resize([0,2*y,0]){
                cylinder(d1=x,d2=2*x,h=l,center=true);
            }
            translate([0,0,l/2+extend/2]){
                resize([0,2*y,0]){
                    cylinder(d=2*x,h=extend,center=true);
                }
            }
        }        
    }
    if(shape=="rnd_indent"){
            translate([-x/2,-y/2,-l/4+move]){
                resize([0,y,0]){
                    cylinder(d=x,h=l/2,center=true);
                }
            }
            translate([-x/2,-y/2,l/4+move]){
                resize([0,2*y,0]){
                    cylinder(d=2*x,h=l/2,center=true);
                }
            }
            translate([-x/2,-y/2,l/2+extend/2+move]){
                resize([0,2*y,0]){
                    cylinder(d=2*x,h=extend,center=true);
                }
            }
    }
    if(shape=="rnd_button"){
            translate([-x/2,-y/2,l/4+move]){
                resize([0,y,0]){
                    cylinder(d=x,h=l/2,center=true);
                }
            }
            translate([-x/2,-y/2,-l/4+move]){
                resize([0,2*y,0]){
                    cylinder(d=2*x,h=l/2,center=true);
                }
            }
            translate([-x/2,-y/2,l/2+extend/2+move]){
                resize([0,2*y,0]){
                    cylinder(d=2*x,h=extend,center=true);
                }
            }
    }
}
