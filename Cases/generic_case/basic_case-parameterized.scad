$fn=32;

include <make_cuts.scad>

/* // Example values for a raspberry pi zero 
dim_pi_board        = [65,30,1.5];
uppers_pi           = 5;
lowers_pi           = 6;
wall_pi             = 2;
rim_pi              = 1.4;
dia_pi_screws       = 3.2;
screw_spacing_pi    = 1;
loc_pi_screws       = [[3.5,3.5],
                       [dim_pi_board[0]-3.5,3.5],
                       [dim_pi_board[0]-3.5,dim_pi_board[1]-3.5],
                       [3.5,dim_pi_board[1]-3.5]];
hole_depth          = 30;
cuts_pi         = [[[17,-5.5],[13,5.5],hole_depth,0],       // USB
                   [[44.25,-6.5],[16.5,6.5],hole_depth,0],  // HDMI
                   [[6.6,-3.7],[16.6,2.2],hole_depth,2],    // camera
                   [[11.25,-3.8],[11.5,3.8],hole_depth,3]]; // SD card
render_mode         = "normal";
                   
case(dim_b=dim_pi_board,
     dia_s=dia_pi_screws,
     loc_s=loc_pi_screws,
     h1=uppers_pi,
     h2=lowers_pi,
     w=wall_pi,
     r=rim_pi,
     space_s=screw_spacing_pi,
     mki=2,
     cuts=cuts_pi,
     render_mode=render_mode);*/


// case module
module case(dim_b,     // board dimension (without components)
             dia_s,     // screw diameter
             loc_s,     // screw locations (array of [x,y] pairs, starting left lower corner, counterclockwise)
             h1,        // height of components on top of board
             h2,        // height of components below board
             w,         // wall thickness
             r,         // rim between board and wall thickness
             space_s,   // space around screw holes
             mki,       // corner rounding value (0=no rounding)
             cuts,
             render_mode)    // location of port openings ()
{
                 
    // calculated values
    h           = h1+h2+dim_b[2]; // total height
    height_s    = w;              // screw_height
    loc_c       = [[[0,0],[loc_s[0][0],0],[loc_s[0][0],loc_s[0][1]],[0,loc_s[0][1]]],
                   [[loc_s[1][0],0],[dim_b[0],0],[dim_b[0],loc_s[1][1]],[loc_s[1][0],loc_s[1][1]]],
                   [[loc_s[2][0],loc_s[2][1]],[dim_b[0],loc_s[2][1]],[dim_b[0],dim_b[1]],[loc_s[2][0],dim_b[1]]],
                   [[0,loc_s[3][1]],[loc_s[3][0],loc_s[3][1]],[loc_s[3][0],dim_b[1]],[0,dim_b[1]]]]; // corners

    if(render_mode=="shape")
    {    
        // whole case - cutout shape (for embedding in other stuff)
        hull(){
            outer_frame();
        }
        //translate([0,0,h2-height_s]){
        //    inner_frame();
        //}
        translate([0,0,h2+dim_b[2]]){
            create_cuts(d=dim_b,
                          w=w+r,
                          h1=h1,
                          h2=h2,
                          cuts=cuts);
        }
    }
    else
    {
        // whole case - normal render
        difference(){
            union(){
                outer_frame();
                translate([0,0,h2-height_s]){
                    inner_frame();
                }
            }
            translate([0,0,h2+dim_b[2]]){
                create_cuts(d=dim_b,
                              w=w+r,
                              h1=h1,
                              h2=h2,
                              cuts=cuts);
            }
        }
    } 

     
    // outer frame
    module outer_frame(){
        difference(){
            cube_round_xy([dim_b[0]+2*w+2*r,
                  dim_b[1]+2*w+2*r,
                  h],mki);
            translate([w,w,0]){
                cube([dim_b[0]+2*r,
                      dim_b[1]+2*r,
                      h]);
            }
        }
    }
    
    // inner frame
    module inner_frame(){
        // rim around board
        difference(){
            translate([w,w,0]){
                cube([dim_b[0]+2*r,dim_b[1]+2*r,height_s]);
            }
            translate([r+w,r+w,0]){
                cube([dim_b[0],dim_b[1],height_s]);
            }
        }

        // screw connectors in the corners
        translate([w+r,w+r,0]){
            difference(){
                corner_latches();
                screw_holes();
            }
        }        
    }
    
    module screw_holes(){
        for(loc=loc_s){
            translate(loc){
                cylinder(d=dia_s,h=height_s);
            }
        }
    }
    
    module corner_latches(){
        difference(){
            for(i=[0 : len(loc_c)-1]){
                hull(){
                    linear_extrude(height_s)
                        polygon(points=loc_c[i]);
                    translate(loc_s[i]){
                        cylinder(d=dia_s+space_s,h=height_s);
                    }
                }
            }
        }
    }
}

module cube_round_xy(dim,mki){
    translate([mki/2,mki/2,0]){
        linear_extrude(dim[2]){
            minkowski(){
                square([dim[0]-mki,dim[1]-mki]);
                circle(d=mki);
            }
        }
    }
}