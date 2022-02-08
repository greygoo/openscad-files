// module to create openings on a cube case
// d    = cube dimension [x,y,z]
// w    = object wall thickness 
// cuts = array of cuts to be created
// cuts format: location([x,y]),size[x,y],length,side,shape
//      direction:
//          front,back,left,right,top,bottom

//board_dim=[20,20,1.5];
//cut_location=[0,0];
//cut_size=[3,2];
//cut_length=5;
//cuts=[[cut_location,cut_size,cut_length,"front","square"],
//      [cut_location,cut_size,cut_length,"back","square"],
//      [cut_location,cut_size,cut_length,"left","square"],
//      [cut_location,cut_size,cut_length,"right","square"],
//      [cut_location,cut_size,cut_length,"top","square"],
//      [cut_location,cut_size,cut_length,"bottom","square"]];
//%cube(board_dim);

//make_cuts_v2(dim=board_dim,
//             cuts=cuts);

module make_cuts_v2(dim=[10,10,0],
                    cuts=[[[0,0],[10,10,10],1,"front","square"]]){
                     
    for(cut=cuts){
        loc_x   = cut[0][0];
        loc_y   = cut[0][1];
        x       = cut[1][0];
        y       = cut[1][1];
        l       = cut[2];
        side    = cut[3];
        shape   = cut[4];
        
// fix: move to loc
        if(side=="front" || side=="back" || side==0 || side==1) {
            translate([x/2,0,y/2]+[0,0,dim[2]]){
                if(side=="front" || side==0)
                    translate([loc_x,0,loc_y])
                        rotate([90,0,0]) // rotate have length outwords
                            translate([0,0,+l/2]) // move inside wall
                                mkshape(x,y,l,shape);

                if(side=="back" || side==1)
                    translate([dim[0]-x,0,0]+[-loc_x,0,loc_y])
                        rotate([270,0,0])
                            translate([0,0,+l/2+dim[1]])
                                mkshape(x,y,l,shape);
            }
        }

        if(side=="right" || side=="left" || side==2 || side==3 ) {
            translate([0,x/2,y/2]+[0,0,dim[2]]) {
                if(side=="right" || side==3)
                    translate([0,loc_x,loc_y]+[0,0,0])
                        rotate([90,0,90])
                            translate([0,0,+l/2+dim[0]])
                                mkshape(x,y,l,shape);
            
                if(side=="left" || side==2)
                    translate([0,dim[1]-x,0]+[0,-loc_x,loc_y])
                        rotate([90,0,270])
                            translate([0,0,+l/2])
                                mkshape(x,y,l,shape);
            }
        }

        if(side=="top" || side=="bottom" || side==4 || side==5 ) {
            translate([x/2,y/2,0]) {  // move to x,y [0,0] on wall          
                if(side=="top" || side==4)
                    translate([loc_x,loc_y,0])
                        rotate([0,0,0])
                            translate([0,0,+l/2+dim[2]])
                                mkshape(x,y,l,shape);
                
                if(side=="bottom" || side==5)
                    translate([0,dim[1]-y,0]+[loc_x,-loc_y,0]) // move to zero opposite + location
                        rotate([180,0,0]) // rotate have length outwords
                            translate([0,0,+l/2]) // move inside wall 
                                mkshape(x,y,l,shape);
            }
        }
    }
}

module mkshape(x,y,l,shape){
    if(shape=="square"){
        cube([x,y,l],center=true);
    }
    if(shape=="round"){
        translate([-x/2,-y/2,0])
        resize([0,y,0])
            cylinder(d=x,h=l,center=true);
    }
}
