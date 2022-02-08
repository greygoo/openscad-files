$fn=32;

include <make_cuts-v2.scad>
include <cube_round_xy.scad>
include <screw_holes.scad>

// Example values
//// Board values
//dim_board        = [60,30,2];
//space_top        = 5;
//space_bottom     = 5;
//
//// Case values
//wall             = 2;
//rim              = 1;
//mki              = 2;
//bottom           = 0;
//render_mode      = "normal";
//
//// Board Screw values
//dia_bscrew       = 3.2;
//space_bscrew     = 1;
//dia_bhead        = 5.2;
//height_bhead     = 2.4;
//loc_bscrews      = [[3.5,3.5],
//                    [dim_board[0]-3.5,3.5],
//                    [dim_board[0]-3.5,dim_board[1]-3.5],
//                    [3.5,dim_board[1]-3.5]];
//                    
//// Port values
//cuts             = [[[0,0],[5,3],wall+rim,"front","square"],       
//                    [[0,0],[5,3],wall+rim,"back","square"],
//                    [[0,0],[5,3],wall+rim,"left","square"],
//                    [[0,0],[5,3],wall+rim,"right","square"]];
//
//
//
//case(dim_b=dim_board,
//     h1=space_top,
//     h2=space_bottom,
//     dia_s=dia_bscrew,
//     space_s=space_bscrew,     
//     loc_s=loc_bscrews,
//     w=wall,
//     r=rim,
//     cuts=cuts,
//     mki=mki,
//     bottom=bottom,
//     render_mode=render_mode);
     
// case module
module case(dim_b,     // board dimension (without components)
            h1,        // height of components on top of board
            h2,        // height of components below board
            dia_s=3,     // screw diameter
            loc_s,     // screw locations (array of [x,y] pairs, starting left lower corner, counterclockwise)
            w=1.4,         // wall thickness
            r=0.3,         // rim between board and wall thickness
            space_s=1,   // space around screw holes
            mki=2,       // corner rounding value (0=no rounding)
            cuts,      // location of port openings ()
            bottom=1,
            render_mode="normal")    
{
    // calculate values;
    h           = h1+h2+dim_b[2]; // total height
    height_s    = w;
        
    // case
    if(render_mode=="normal"){
        difference(){
            union(){
                outer_frame();
                inner_frame();
            }
            cutout_ports();
        }
    }
    if(bottom==1){
        translate([0,0,-w]){
            cube_round_xy([dim_b[0]+2*(r+w),dim_b[1]+2*(r+w),w],mki);
        }
    }
    
    // outer frame
    module outer_frame(){
        difference(){
            cube_round_xy([dim_b[0]+2*(w+r),dim_b[1]+2*(w+r),h],mki);
            cutout_inside();
        }
    }
    
    // screw connectors for board
    module inner_frame(){
        translate([0,0,h2-height_s]){
            // rim
            difference(){
                    translate([w,w,0]){
                        cube([dim_b[0]+2*r,dim_b[1]+2*r,height_s]);
                    }
                    translate([w+r,w+r,0]){
                       cube([dim_b[0],dim_b[1],height_s]);
                }
            }
            
            // screw holes
            translate([w+r,w+r,0]){
                difference(){
                    corner_latches(dim_b,loc_s,dia_s,space_s,height_s);
                    screw_holes(loc=loc_s,dia=dia_s,h=h);
                }
            }
        }
    }
    
    module cutout_inside(){
        translate([w,w,0]){
            cube([dim_b[0]+2*r,dim_b[1]+2*r,h]);
        }
    }
    
    // cutout of port openings
    module cutout_ports(){
        translate([w+r,w+r,h2]){
            make_cuts_v2(dim=dim_b,cuts=cuts);
        }
    }
}