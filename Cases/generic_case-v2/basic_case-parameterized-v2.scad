include <make_cuts-v2.scad>
include <cube_round_xy.scad>
include <screw_holes.scad>

// Example values
// Render options
/*$fn              = 32;
case_part        = "case_cover";
render_mode      = "normal";

// Board values
dim_board        = [60,30,2];
space_top        = 5;
space_bottom     = 5;
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
cuts             = [[[0,0],[5,3],wall_frame+rim,"front","sqr_cone"],       
                    [[0,0],[5,3],wall_frame+rim,"back","sqr"],
                    [[0,0],[5,3],wall_frame+rim,"left","sqr"],
                    [[0,0],[5,3],wall_frame+rim,"right","sqr"],
                    [[0,0],[5,3],wall_frame+rim,"top","sqr"],
                    [[0,0],[5,3],wall_frame+rim,"bottom","sqr"],
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
            gap=0.2,
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
     
            dia_bscrew=3,       // screw diameter
            height_bhead=2.4, 
            loc_bscrews)        // screw locations (array of [x,y] pairs, 
                                //starting left lower corner, counterclockwise)  
{
    // calculate values;
    height_frame    = space_top+space_bottom+dim_board[2]; // height of case without bottom/cover
    height_case     = height_frame+2*(height_chead);
    height_bscrew   = space_bottom-height_bhead;
    wall_case       = dia_chead; 
    dim_frame       = dim_board+[2*(wall_frame+rim),2*(wall_frame+rim),space_top+space_bottom];
    dim_case        = dim_frame+[2*(wall_case-wall_frame),2*(wall_case-wall_frame),height_case]; 
    loc_cscrews     = [[-(wall_case-wall_frame-dia_chead/2),-(wall_case-wall_frame-dia_chead/2+0.36844)],
                      [dim_frame[0]+(wall_case-wall_frame-dia_chead/2),-(wall_case-wall_frame-dia_chead/2+0.36844)],
                      [dim_frame[0]+(wall_case-wall_frame-dia_chead/2),dim_frame[1]+(wall_case-wall_frame-dia_chead/2+0.36844)],
                      [-(wall_case-wall_frame-dia_chead/2),dim_frame[1]+(wall_case-wall_frame-dia_chead/2+0.36844)]];
    loc_corner_cuts = [[0,0],
                       [dim_case[0],0],
                       [dim_case[0],dim_case[1]],
                       [0,dim_case[1]]];
    
    
    
    if(part=="frame"){
        frame();
    }
    
    if(part=="inlay"){
        translate([wall_case-wall_frame,wall_case-wall_frame,height_chead]){
            frame(height=space_bottom);
        }
    }
    
    if(part=="case_bottom"){
        difference(){
            cube_round_xy([dim_case[0],dim_case[1],space_bottom],mki);
            translate([wall_case-wall_frame,wall_case-wall_frame,0]){
                translate([0,0,height_chead]){
                    translate([-gap/2,-gap/2,-gap/2]){
                        cube_round_xy([dim_frame[0]+gap,
                                        dim_frame[1]+gap,
                                        space_bottom+dim_board[2]],mki);
                    }
                }
                screw_holes(loc=loc_cscrews,dia=dia_cscrew,h=height_case);
                screw_holes(loc=loc_cscrews,dia=dia_chead,h=height_chead,fn=6);
                
                translate([0,0,height_chead]){
                    cutout_ports(extend=wall_case+0.2,grow=grow);
                }
            }
            screw_holes(loc=loc_corner_cuts,dia=dia_chead,h=height_chead);
        }
    }
    
    if(part=="case_cover"){
        difference(){
            translate([0,0,space_bottom]){
                cube_round_xy([dim_case[0],dim_case[1],2*height_chead+space_top+dim_board[2]],mki);
            }
            translate([0,0,height_case-height_chead]){
                screw_holes(loc=loc_corner_cuts,dia=dia_chead,h=height_chead);
            }
            translate([wall_case-wall_frame,wall_case-wall_frame,0]){
                translate([0,0,(height_case-height_frame)/2]){
                    translate([-gap/2,-gap/2,-gap/2]){
                        cube_round_xy([dim_frame[0]+gap,dim_frame[1]+gap,space_bottom+gap],mki);
                    }
                }
                screw_holes(loc=loc_cscrews,dia=dia_cscrew,h=height_case);
                translate([0,0,height_case-height_chead]){
                    screw_holes(loc=loc_cscrews,dia=dia_chead,h=height_chead);
                }
                translate([0,0,height_chead]){
                    #cutout_ports(extend=wall_case+wall_frame,move=-wall_frame,grow=grow);
                }
            }
            translate([wall_case+wall_frame,
                       wall_case+wall_frame,
                       (height_case-height_frame)/2+space_bottom]){
                translate([-gap/2,-gap/2,-gap/2]){
                    cube_round_xy([dim_board[0]+gap,dim_board[1]+gap,space_top++dim_board[2]+gap],mki);
                }
            }
        }
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
    
//    // bottom
//    module bottom(){
//        translate([0,0,-wall_frame]){
//            difference(){
//                cube_round_xy([dim_frame[0],dim_frame[1],height_bottom],mki);
//                cutout_ports();
//            }
//        }
//    }
    
    module outer_frame(height=dim_frame[2]){
        difference(){
            cube_round_xy([dim_frame[0],dim_frame[1],height],mki);
            cutout_inside();
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
     
    module cutout_inside(){
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
    
//    module case_screws(){
//        translate([wall_frame+rim,wall_frame+rim,0]){
//            screw_holes(loc=loc_cscrews,dia=dia_cscrew,h=height_frame);
//        }
//    }
}