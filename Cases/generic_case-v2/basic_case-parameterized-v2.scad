include <make_cuts-v2.scad>
include <cube_round_xy.scad>
include <screw_holes.scad>

// Example values
// Render options
/*$fn              = 32;
case_part        = "case";
render_mode      = "normal";

// Case values
wall             = 2;
rim              = 1;
mki              = 2;

// Board values
dim_board        = [60,30,2];
cuts             = [[[0,-3],[5,3],wall+rim,"front","sqr"],       
                    [[0,0],[5,3],wall+rim,"back","sqr"],
                    [[0,0],[5,3],wall+rim,"left","sqr"],
                    [[0,0],[5,3],wall+rim,"right","sqr"]];
space_top        = 5;
space_bottom     = 5;
space_bscrew     = 1;

// Case Screw values
dia_cscrew       = 3.3;
dia_chead        = 5.5;
height_chead     = 3;
loc_cscrews      = [];

// Board Screw values
dia_bscrew       = 3.2;
dia_bhead        = 5.2;
height_bhead     = 2.4;
loc_bscrews      = [[3.5,3.5],
                    [dim_board[0]-3.5,3.5],
                    [dim_board[0]-3.5,dim_board[1]-3.5],
                    [3.5,dim_board[1]-3.5]];                    

// case module
case(part=case_part,
     render_mode=render_mode,
     
     w=wall,
     r=rim,
     mki=mki,
          
     dim_b=dim_board,
     cuts=cuts,
     space_top=space_top,
     space_bottom=space_bottom,
     space_bscrew=space_bscrew,

     dia_cscrew=dia_cscrew,
     dia_chead=dia_chead,
     height_chead =height_chead,
     loc_cscrews=loc_cscrews,
     
     dia_bscrew=dia_bscrew,
     dia_bhead=dia_bhead,
     height_bhead=height_bhead,     
     loc_bscrews=loc_bscrews);*/
     
// case module
module case(part="case", // which part to render
            render_mode="normal", // how to render
            
            dim_b,     // board dimension (without components)
            cuts,      // location of port openings ()
            space_top,        // height of components on top of board
            space_bottom,        // height of components below board
            space_bscrew=1,   // space around screw holes
            
            w=1.4,         // wall thickness
            r=0.3,         // rim between board and wall thickness
            mki=2,       // corner rounding value (0=no rounding)
            
            dia_cscrew = 3.3, // case screw values
            dia_chead = 5.5,
            height_chead = 3,
            loc_cscrews,
     
            dia_bscrew=3,     // screw diameter
            dia_bhead=5.2,
            height_bhead=2.4,
            loc_bscrews)     // screw locations (array of [x,y] pairs, starting left lower corner, counterclockwise)  
{
    // calculate values;
    h           = space_top+space_bottom+dim_b[2]; // total height
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
    if(part=="bottom"){
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
        translate([0,0,space_bottom-height_s]){
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
                    corner_latches(dim_b,loc_bscrews,dia_bscrew,space_bscrew,height_s);
                    screw_holes(loc=loc_bscrews,dia=dia_bscrew,h=h);
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
        translate([w+r,w+r,space_bottom]){
            make_cuts_v2(dim=dim_b,cuts=cuts);
        }
    }
}