include <make_cuts-v2.scad>
include <cube_round_xy.scad>
include <screw_holes.scad>

// Example values
// Render options
/*$fn              = 32;
case_part        = "body";
render_mode      = "normal";

// Case values
wall             = 3;
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
dia_cscrew       = 1.8;
dia_chead        = 4;
height_chead     = 3;
loc_cscrews      = [[-(dia_chead/2),-(dia_chead/2)],
                    [dim_board[0]+(dia_chead/2),-(dia_chead/2)],
                    [dim_board[0]+(dia_chead/2),dim_board[1]+(dia_chead/2)],
                    [-(dia_chead/2),dim_board[1]+(dia_chead/2)]];

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
     
     wall=wall,
     rim=rim,
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
            
            wall=1.4,         // wall thickness
            rim=0.3,         // rim between board and wall thickness
            mki=2,       // corner rounding value (0=no rounding)
            
            dim_b,     // board dimension (without components)
            cuts,      // location of port openings ()
            space_top,        // height of components on top of board
            space_bottom,        // height of components below board
            space_bscrew=1,   // space around screw holes
            
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
    height_case = space_top+space_bottom+dim_b[2]; // height of case without bottom/cover
    height_bottom = wall;
    dim_case    = dim_b+[2*(wall+rim),2*(wall+rim),space_top+space_bottom];
    height_bscrew = space_bottom-height_chead;
    //bottom();
    
    if(render_mode=="normal"){
        if(part=="body"){
            body();
        }
        
        if(part=="bottom"){
            bottom();
        }
        
        if(part=="cover"){
            cover();
        }
    }
    
    if(render_mode=="shape"){
        if(part=="body"){
            hull(){
                body();
            }
            hull(){
                cutout_ports();
            }
        }
        
        if(part=="bottom"){
            echo("shape/bottom is unsupported");
        }
        
        if(part=="cover"){
            echo("shape/cover is unsupported");
        }
    }


    // case
    module body(){
        difference(){
            union(){
                outer_frame();
                inner_frame();
            }
            cutout_ports();
            case_screws();
        }
    }
    
    // bottom
    module bottom(){
        translate([0,0,-wall]){
            difference(){
                cube_round_xy([dim_case[0],dim_case[1],height_bottom],mki);
                cutout_ports();
            }
        }
    }
    
    module outer_frame(){
        difference(){
            cube_round_xy(dim_case,mki);
            cutout_inside();
        }
    }
    
    module inner_frame(){
        rim();
        board_screws();
    }
    
    module rim(){
        translate([0,0,space_bottom-height_bscrew]){
            // rim
            difference(){
                    translate([wall,wall,0]){
                        cube([dim_b[0]+2*rim,dim_b[1]+2*rim,height_bscrew]);
                    }
                    translate([wall+rim,wall+rim,0]){
                       cube([dim_b[0],dim_b[1],height_bscrew]);
                }
            }
        }
    }
            
    module board_screws(){
        translate([0,0,space_bottom-height_bscrew]){
            translate([wall+rim,wall+rim,0]){
                difference(){
                    corner_latches(dim_b,loc_bscrews,dia_bscrew,space_bscrew,height_bscrew);
                    screw_holes(loc=loc_bscrews,dia=dia_bscrew,h=height_case);
                }
            }
        }
    }
    
    module case_screws(){
        translate([wall+rim,wall+rim,0]){
            screw_holes(loc=loc_cscrews,dia=dia_cscrew,h=height_case);
        }
    }
    
    module cutout_inside(){
        translate([wall,wall,0]){
            cube([dim_b[0]+2*rim,dim_b[1]+2*rim,height_case]);
        }
    }
    
    // cutout of port openings
    module cutout_ports(){
        translate([wall+rim,wall+rim,space_bottom]){
            make_cuts_v2(dim=dim_b,cuts=cuts);
        }
    }
}