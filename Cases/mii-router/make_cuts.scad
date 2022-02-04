// module to create openings
// d    = object dimenstion
// w    = object wall thickness
// h1   = space above board
// h2   = space below board
// cuts = array of cuts to be created
// cuts format: location,size,length,direction,
//      direction:
//          0=front
//          1=back
//          2=left
//          3=right

module create_cuts(d,w,h1,h2,cuts){
    for(cut=cuts){
        
        // front
        if(cut[3]==0){
            translate([cut[0][0],0,cut[0][1]]){
                translate([w,w-cut[2],0]){
                    cube([cut[1][0],cut[2],cut[1][1]]);
                }
            }
        }
        
        // back
        if(cut[3]==1){
            translate([cut[0][0],0,cut[0][1]]){
                translate([w,w+d[1],0]){
                    cube([cut[1][0],cut[2],cut[1][1]]);
                }
            }
        }
        // left
        if(cut[3]==2){
            translate([0,cut[0][0],cut[0][1]]){
                translate([w-cut[2],w,0]){
                    cube([cut[2],cut[1][0],cut[1][1]]);
                }
            }
        }
        // right
        if(cut[3]==3){
            translate([0,cut[0][0],cut[0][1]]){
                translate([d[0]+w,w,0]){
                    cube([cut[2],cut[1][0],cut[1][1]]);
                }
            }
        }
    }
}