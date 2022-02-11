include <make_cuts-v2.scad>
include <cube_round_xy.scad>
include <screw_holes.scad>

// Example values
// Render options
/*$fn              = 32;
case_part        = "case_inlay";
render_mode      = "normal";

// Board values
dim_board        = [60,30,2];
space_top        = 7;
space_bottom     = 3;
space_bscrew     = 1;

// Board Screw values
dia_bscrew       = 3.2;
loc_bscrews      = [[3.5,3.5],
                    [dim_board[0]-3.5,3.5],
                    [dim_board[0]-3.5,dim_board[1]-3.5],
                    [3.5,dim_board[1]-3.5]];                    

// Case Screw values
dia_cscrew       = 3;
dia_chead        = 5.5;
height_chead     = 2.5;
height_cscrew    = 15;
                    
// Case values
wall_frame       = 1.2;
rim              = 1;
mki              = 2;
                  
// ports
cuts             = [[[0,0],[5,3],wall_frame+rim,"front","sqr_indent"],       
                    [[0,0],[5,3],wall_frame+rim,"back","sqr_indent"],
                    [[0,0],[5,3],wall_frame+rim,"left","sqr"],
                    [[0,0],[5,3],wall_frame+rim,"right","sqr"],
                    [[0,0],[5,3],wall_frame+rim,"top","sqr"],
                    [[0,0],[5,3],wall_frame+rim,"bottom","sqr_indent"],
                    ];


// case module
case(part=case_part,
     render_mode=render_mode,
     
     wall_frame=wall_frame,
     rim=rim,
     mki=mki,
          
     dim_board=dim_board,
     cuts=cuts,
     space_top=space_top,
     space_bottom=space_bottom,
     space_bscrew=space_bscrew,

     dia_cscrew=dia_cscrew,
     dia_chead=dia_chead,
     height_chead=height_chead,
     height_cscrew=height_cscrew,
     
     dia_bscrew=dia_bscrew,
     loc_bscrews=loc_bscrews);*/
     
     
     
     
// case module
module case(part="frame", // which part to render
            render_mode="normal", // how to render
            
            wall_frame=1.4,         // wall_frame thickness
            rim=0.3,         // rim between board and wall_frame thickness
            mki=2,       // corner rounding value (0=no rounding)
            gap=0.3,
            grow=2,
            
            dim_board,     // board dimension (without components)
            cuts,      // location of port openings ()
            space_top,        // height of components on top of board
            space_bottom,        // height of components below board
            space_bscrew=1,   // space around board screw holes
            
            dia_cscrew = 3.3, // case screw values
            dia_chead = 5.5,
            height_chead = 3,
            height_cscrew = 15,
            height_bottom = 5, // height of bottom case part
     
            dia_bscrew=3,       // screw diameter
            height_bhead=2.4, 
            loc_bscrews)        // screw locations (array of [x,y] pairs, 
                                //starting left lower corner, counterclockwise)  
{
    // calculate values;
    height_bscrew   = space_bottom-height_bhead;
    height_frame    = space_top+space_bottom+dim_board[2]; // height of case without bottom/cover
    height_case     = height_frame+2*(height_chead);
    height_floor    = height_chead+1;
    height_top      = height_chead+1;
    height_inlay    = space_bottom;
    height_headspace = space_top;
    //height_bottom   = space_bottom+height_floor-rim;
    height_cover    = height_case-height_bottom;

    wall_case       = dia_chead-wall_frame;
    dim_frame       = dim_board+[2*(wall_frame+rim),2*(wall_frame+rim),height_frame];
    dim_case        = dim_frame+[2*wall_case,2*wall_case,height_case]; 
    
    loc_cscrews     = [[dia_chead/2,dia_chead/2-0.36844],
                       [dim_case[0]-dia_chead/2,dia_chead/2-0.36844],
                       [dim_case[0]-dia_chead/2,dim_case[1]-dia_chead/2+0.36844],
                       [dia_chead/2,dim_case[1]-dia_chead/2+0.36844]];
    loc_corner_cuts = [[0,0],
                       [dim_case[0],0],
                       [dim_case[0],dim_case[1]],
                       [0,dim_case[1]]];
    
    
    
    if(part=="frame"){
        frame();
    }
    
    if(part=="case_inlay"){
        case_inlay();
        //%case_bottom();
        //%case_cover();
    }
    
    if(part=="case_bottom"){
        case_bottom();
        //%case_cover();
        //%case_inlay();
    }
    
    if(part=="case_cover"){
        case_cover();
        //%case_bottom();
        //%case_inlay();
    }
    
    module case_inlay(){
        translate([wall_case,wall_case,height_floor]){
            frame(height=space_bottom);
        }
        
    }
    
    module case_bottom(){
        difference(){
            bottom();
            cutouts_case();
            cutout_case_screws();
        }
    }
    
    module case_cover(){
        difference(){
            union(){
                difference(){
                    cover();
                    cutouts_case();
                }
                difference(){
                    translate([wall_case,wall_case,height_floor]){
                        frame();
                    }
                    case_inlay();
                }
            }
            cutout_case_screws();
        }    
    }
    
    module cutouts_case(){
        translate([wall_case,wall_case,height_floor]){
            cutout_frame_bottom();
            cutout_frame_cover();
            cutout_case_ports();
        }
    }
    
    module bottom(){
        // bottom case shape
        cube_round_xy([dim_case[0],dim_case[1],height_bottom],mki);
    }
    
    module cover(){
        translate([0,0,height_bottom]){
            cube_round_xy([dim_case[0],dim_case[1],height_cover],mki);
        }
    }
    
    module cutout_frame_bottom(){
        // cut out for inlay
        translate([-gap,-gap,0]){
            cube_round_xy([dim_frame[0]+2*gap,
                           dim_frame[1]+2*gap,
                           height_inlay],mki);
        }
    }
    
    module cutout_frame_cover(){
        // cut out for inlay
        #translate([0,0,height_inlay]){
            cube_round_xy([dim_frame[0],
                           dim_frame[1],
                           dim_board[2]+space_top],mki);
        }
    }
    
    module cutout_case_screws(){
        // cut out screw holes
        screw_holes(loc=loc_cscrews,dia=dia_cscrew,h=height_case);
        // cut out screw heads bottom
        screw_holes(loc=loc_cscrews,dia=dia_chead,h=height_chead,fn=6);
        // cut of corners
        screw_holes(loc=loc_corner_cuts,dia=dia_chead,h=height_chead);
        // cut out screw heads top
        translate([0,0,height_case-height_chead]){
            screw_holes(loc=loc_cscrews,dia=dia_chead,h=height_chead);
            screw_holes(loc=loc_corner_cuts,dia=dia_chead,h=height_chead);
        }
    }

    module cutout_case_ports(){
        cutout_ports(move=-wall_frame-gap,extend=wall_case,grow=grow);
    }
    
    module frame(height=dim_frame[2]){
        difference(){
            union(){
                outer_frame(height=height);
                inner_frame();
            }
            cutout_ports(grow=grow);
        }
    }
    
    module outer_frame(height=dim_frame[2]){
        difference(){
            cube_round_xy([dim_frame[0],dim_frame[1],height],mki);
            cutout_board();
        }
    }
    
    module inner_frame(){
        rim();
        board_screws();
    }
    
    module rim(){
        translate([0,0,space_bottom-height_bscrew]){
            difference(){
                    translate([wall_frame,wall_frame,0]){
                        cube([dim_board[0]+2*rim,dim_board[1]+2*rim,height_bscrew]);
                    }
                    translate([wall_frame+rim,wall_frame+rim,0]){
                       cube([dim_board[0],dim_board[1],height_bscrew]);
                }
            }
        }
    }
            
    module board_screws(){
        translate([0,0,space_bottom-height_bscrew]){
            translate([wall_frame+rim,wall_frame+rim,0]){
                difference(){
                    corner_latches(dim_board,loc_bscrews,dia_bscrew,space_bscrew,height_bscrew);
                    screw_holes(loc=loc_bscrews,dia=dia_bscrew,h=height_frame);
                }
            }
        }
    }
     
    module cutout_board(){
        translate([wall_frame,wall_frame,0]){
            cube([dim_board[0]+2*rim,dim_board[1]+2*rim,height_frame]);
        }
    }
    
    // cutout of port openings
    module cutout_ports(extend=0,move=0,grow=2){
        translate([wall_frame+rim,wall_frame+rim,space_bottom]){
            make_cuts_v2(dim=dim_board,cuts=cuts,extend=extend,move=move,grow=grow);
        }
    }
}