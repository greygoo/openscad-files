$fn=32;
hole_depth=30;

//battery frame values
dim_batt_board  = [99.1,29.15,1.5];
uppers_batt     = 6;
lowers_batt     = 15;
wall_batt       = 2;
dia_batt_screws = 3.2;
loc_batt_screws = [[2,2,0],
                   [2,dim_batt_board[1]-2,0],
                   [dim_batt_board[0]-2,2,0],
                   [dim_batt_board[0]-2,dim_batt_board[1]-2,0]];
height_batt     = uppers_batt+lowers_batt+dim_batt_board[2];
cuts_batt       = [[[82,-1.5],[13.8,5],hole_depth,0],
                   [[6,-8.9],[15.5,8.9],hole_depth,2],
                   [[8,-6],[6.5,4.5],hole_depth,1],
                   [[68.8,-1.5],[13,6.5],hole_depth,1]];

// pi frame values
dim_pi_board    = [65,30,1.5];
uppers_pi       = 5;
lowers_pi       = 6;
wall_pi         = 3;
dia_pi_screws   = 3.2;
loc_pi_screws   = [[3.5,3.5,0],
                   [3.5,dim_pi_board[1]-3.5,0],
                   [dim_pi_board[0]-3.5,3.5,0],
                   [dim_pi_board[0]-3.5,dim_pi_board[1]-3.5,0]];
height_pi       = uppers_pi+lowers_pi+dim_pi_board[2];
cuts_pi         = [[[17,-5.5],[13,5.5],hole_depth,0],
                   [[44.25,-6.5],[16.5,6.5],hole_depth,0],
                   [[6.6,-3.7],[16.6,2.2],hole_depth,2],
                   [[11.25,-3.8],[11.5,3.8],hole_depth,3]];

// T3 LoRa frame values
dim_t3_board    = [65,27,1.25];
uppers_t3       = 5;
lowers_t3       = 5;
wall_t3         = 3;
dia_t3_screws   = 2.1;
loc_t3_screws   = [[dim_t3_board[0]-2.6,3.2,0],
                   [dim_t3_board[0]-2.6,dim_t3_board[1]-3.2,0]];
height_t3       = uppers_t3+lowers_t3+dim_t3_board[2];
cuts_t3         = [[[9.2,-13.2],[9,9],hole_depth,0],  // antenna port
                   [[9.2,-13.2],[9,9],10,0],          // internal antenna cutout//fix!!
                   [[2,-dim_t3_board[2]],[22.5,5.5],hole_depth,2],  // sdcard/usb port
                   [[7.2,-dim_t3_board[2]-3.6],[5.75,3.6],hole_depth,1],  // power switch
                   [[20.10,-dim_t3_board[2]-2.1],[4.5,2.1],hole_depth,1]]; // reset button
                   

//cable cutouts
dim_cables = ([5,7,height_pi+height_t3+height_batt]);
loc_cables = ([-5,
               -abs(dim_batt_board[1]-dim_cables[1])/2-dim_cables[1]+wall_batt,
               abs(height_batt-dim_cables[2])/2]);


//connection screw values
loc_conn_screws1     = [[5,-2*wall_batt,height_batt/2+0.625],
                        [-2*wall_batt,dim_batt_board[1]-wall_batt,height_batt/2+0.625],
                        [40,-2*wall_batt,height_batt/2+0.625]];
loc_conn_screws2     = [[dim_batt_board[0]+2*wall_batt,2,height_batt/2-5],
                        [dim_batt_board[0]+2*wall_batt,dim_batt_board[1]-wall_batt,height_batt/2-5]];
dia_conn_screws     = 3.5;
wall_conn_screws    = 2;
height_conn_screws1 = height_batt+height_pi+height_t3+4;
height_conn_screws2 = height_batt+height_pi+4;


loc_screw_tops       = [[5,-2*wall_batt,height_batt/2+0.625],
                        [-2*wall_batt,dim_batt_board[1]-wall_batt,height_batt/2+0.625],
                        [40,-2*wall_batt,height_batt/2+0.625],
                        [dim_batt_board[0]+2*wall_batt,2,height_batt/2-5],
                        [dim_batt_board[0]+2*wall_batt,dim_batt_board[1]-wall_batt,height_batt/2-5]];
                   
// calculated values
offset_batt     = 0;
offset_pi       = [+(abs(dim_batt_board[0]-dim_pi_board[0])/2)-abs(wall_pi-wall_batt),
                   -(abs(dim_batt_board[1]-dim_pi_board[1])/2)-abs(wall_pi-wall_batt),
                   height_batt/2+height_pi/2];
offset_t3       = [-(abs(dim_batt_board[0]-dim_t3_board[0])/2)+abs(wall_t3-wall_batt),
                   +abs(dim_batt_board[1]-dim_t3_board[1])/2-abs(wall_t3-wall_batt),
                   height_batt/2+height_pi+height_t3/2];


//part_bottom();
//part_battery();
//part_pi();
//part_t3();
part_top();



module part_top(){
    difference(){
        object();
        translate([-100,-100,33-50]){
            cube([200,200,50]);
        }            
    }
}

module part_t3(){
    difference(){
        object();
        translate([-100,-100,18.74-50]){
            cube([200,200,50]);
        }
        translate([-100,-100,33]){
            cube([200,200,50]);
        }
    }
}

module part_pi(){
    difference(){
        object();
        translate([-100,-100,-40]){
            cube([200,200,50]);
        }
        translate([-100,-100,18.74]){
            cube([200,200,50]);
        }
    }
}

module part_battery(){
    difference(){
        object();
        translate([-100,-100,-59.9]){
            cube([200,200,50]);
        }
        translate([-100,-100,10]){
            cube([200,200,50]);
        }
    }
}

module part_bottom(){
    difference(){
        object();
        translate([-100,-100,-9.9]){
            cube([200,200,50]);
        }
    }
}

module object(){
    difference(){
        hull(){
            battery();
            pi();
            t3();
            connection(location=loc_conn_screws1,
                       dia=dia_conn_screws+wall_batt,
                       height=height_conn_screws1);
            connection(location=loc_conn_screws2,
                       dia=dia_conn_screws+wall_batt,
                       height=height_conn_screws2);
            //cover();
            //bottom();
        };
        cutouts();
        cutout_batt();
        cutout_pi();
        cutout_t3();
    }

    difference(){
        union(){
            battery();
            pi();
            t3();;
        }
        cutouts();
    }
}


//module cover(){
//    translate(offset_t3+[0,0,uppers_t3+wall_t3/2]){
//        cube(dim_t3_board,center=true);
//    }
//}
//
//module bottom(){
//    translate(-[0,0,lowers_batt-wall_batt]){
//        #cube(dim_batt_board,center=true);
//    }
//}



module connection(dia,height,location){
    translate([-dim_batt_board[0]/2,
               -dim_batt_board[1]/2,
               0]){
            echo(location);
            conn_holes(loc_s=location,
                       dia_s=dia,
                       h=height);
            //#conn_holes(loc_s=loc_conn_screws2,
            //            dia_s=dia,
            //            h=height_conn_screws2);      
    }
}

module cables(){
    translate(loc_cables+[0,-wall_batt,0]){
        cube(dim_cables+[wall_batt,-wall_batt,0],center=true);
    }
}
   
module cutout_batt(){
    translate(offset_batt){
        #cube([dim_batt_board[0]+2*wall_batt,
               dim_batt_board[1]+2*wall_batt,
               height_batt],center=true);
    }
}
    
module cutout_pi(){
    translate(offset_pi){
        #cube([dim_pi_board[0]+2*wall_pi,
               dim_pi_board[1]+2*wall_pi,
               height_pi],center=true);
    }
}
    
module cutout_t3(){
    translate(offset_t3){
        #cube([dim_t3_board[0]+2*wall_t3,
               dim_t3_board[1]+2*wall_t3,
               height_t3],center=true);
    }
}

module cutouts(){
    //translate(loc_cables){
    //    cube(dim_cables,center=true);
    //}
    
    // holes for connecton screws
    //connection(dia_conn_screws);
    connection(location=loc_conn_screws1,
               dia=dia_conn_screws,
               height=height_conn_screws1+6);
    connection(location=loc_conn_screws2,
               dia=dia_conn_screws,
               height=height_conn_screws2+6);
    
    // cutout for free space beside raspi
    translate([-dim_batt_board[0]/2+(dim_batt_board[0]-dim_pi_board[0])/2,
               offset_pi[1],
               offset_pi[2]]){
        #cube([dim_batt_board[0]-dim_pi_board[0],
               dim_pi_board[1],
               height_pi],center=true);
    }
    
    translate(offset_batt){
        create_cuts(d=dim_batt_board,
                    w=wall_batt,
                    h1=uppers_batt,
                    h2=lowers_batt,
                    cuts=cuts_batt);
    }
    translate(offset_pi){
        create_cuts(d=dim_pi_board,
                    w=wall_pi,
                    h1=uppers_pi,
                    h2=lowers_pi,
                    cuts=cuts_pi);
    }
    translate(offset_t3){
        create_cuts(d=dim_t3_board,
                    w=wall_t3,
                    h1=uppers_t3,
                    h2=lowers_t3,
                    cuts=cuts_t3);
    }
}

// battery frame
module battery(){
    difference(){
        translate(offset_batt){
            frame(dim_b=dim_batt_board,
                  dia_s=dia_batt_screws,
                  loc_s=loc_batt_screws,
                  h1=uppers_batt,
                  h2=lowers_batt,
                  w=wall_batt);  
        }
        //cutouts();
    }
}

// pi frame
module pi(){
    difference(){
        translate(offset_pi){
            frame(dim_b=dim_pi_board,
                  dia_s=dia_pi_screws,
                  loc_s=loc_pi_screws,
                  h1=uppers_pi,
                  h2=lowers_pi,
                  w=wall_pi);
        }
        //cutouts();
    }
}

module t3(){
    // T3 frame
    difference(){
        translate(offset_t3){
            frame(dim_b=dim_t3_board,
                  dia_s=dia_t3_screws,
                  loc_s=loc_t3_screws,
                  h1=uppers_t3,
                  h2=lowers_t3,
                  w=wall_t3);
        }
        //cutouts();
    }     
}


// make screw_holes
module conn_holes(loc_s,dia_s,h){
    for (loc=loc_s){
        translate(loc){
            cylinder(d=dia_s,
                     h=h,
                     center=true);
        }
    }
}



// frame module
module frame(dim_b,
             dia_s,
             loc_s,
             h1,
             h2,
             w) {
                   
    // basic frame
    difference(){                   
        cube([dim_b[0]+2*w,
              dim_b[1]+2*w,
              h1+h2+dim_b[2]],center=true);
        cube([dim_b[0],
              dim_b[1],
              h1+h2+dim_b[2]],center=true);
    }


    // screws holes   
    translate([-dim_b[0]/2,
               -dim_b[1]/2,
               -h1/2-dim_b[2]/2+1]) {
        for (loc=loc_s){
            translate(loc){
                difference(){
                    cylinder(d=dia_s+2*w,
                             h=h2-2,
                             center=true);
                    cylinder(d=dia_s,
                             h=h2-2,
                             center=true);
                }
            }
        }
    }
}

// module to create openings
// d    = object dimenstion
// w    = object wall thickness
// cuts = array of cuts to be created
// cuts format: location,size,length,direction,
//      direction:
//          0=front
//          1=back
//          2=left
//          3=right
module create_cuts(d,w,h1,h2,cuts){
    // move to 0,0,top of board                
    translate([-d[0]/2-w,
               -d[1]/2-w,
               -(h1+h2+d[2])/2+h2+d[2]]){
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
}