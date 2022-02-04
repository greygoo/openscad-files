include <basic_case-parameterized.scad>

// global values
$fn=32;
hole_depth          = 30;   // outwards length of port cut outs
wall                = 2;    // wall thickness of board cases
rim                 = 0.6;  // rim thickness around boards
screw_spacing       = 1;    // space around screw holes
mki                 = 2;    // value for rounding corners of cases

// battery values
dim_batt_board      = [99.1,29.15,1.5]; // dimension of the board itself (wo components)
uppers_batt         = 6; // space used for ocmponents on top of board
lowers_batt         = 15; // space used for components on bottom of board
dia_batt_screws     = 3.2; // diameter for screws used by board
loc_batt_screws     = [[2,2,0],
                       [dim_batt_board[0]-2,2,0],
                       [dim_batt_board[0]-2,dim_batt_board[1]-2,0],
                       [2,dim_batt_board[1]-2,0]]; // location of screws relative to board 0/0
cuts_batt           = [[[82,-1.5],[13.8,5],hole_depth,0],
                      [[6,-8.9],[15.5,8.9],hole_depth,2],
                      [[8,-6],[6.5,4.5],hole_depth,1],
                      [[68.8,-1.5],[13,6.5],hole_depth,1]]; // port openings in case

// pi values
dim_pi_board        = [65,30,1.5];
uppers_pi           = 5;
lowers_pi           = 6;
dia_pi_screws       = 3.2;
loc_pi_screws       = [[3.5,3.5],
                       [dim_pi_board[0]-3.5,3.5],
                       [dim_pi_board[0]-3.5,dim_pi_board[1]-3.5],
                       [3.5,dim_pi_board[1]-3.5]];
cuts_pi             = [[[5,-5.5],[25,5.5],hole_depth,0],        // USB
                       [[44.25,-6.5],[16.5,6.5],hole_depth,0],  // HDMI
                       [[0.6,-9],[28.6,16],hole_depth,2],       // camera/cables
                       [[11.25,-3.8],[11.5,3.8],hole_depth,3]]; // SD card

// T3 LoRa frame values
dim_t3_board        = [65,27,1.25];
uppers_t3           = 5;
lowers_t3           = 5;
dia_t3_screws       = 2.1;
loc_t3_screws       = [[2.6,2.6],
                       [dim_t3_board[0]-2.6,3.2,0],
                       [dim_t3_board[0]-2.6,dim_t3_board[1]-3.2,0],
                       [2.6,dim_t3_board[1]-3.2,0]];
cuts_t3             = [[[9.2,-13.2],[9,9],hole_depth,0],  // antenna port
                       [[9.2,-13.2],[11.35,11.35],10,0],          // internal antenna cutout//fix!!
                       [[2,-dim_t3_board[2]],[22.5,5.5],hole_depth,2],  // sdcard/usb port
                       [[7.2,-dim_t3_board[2]-3.6],[5.75,3.6],hole_depth,1],  // power switch
                       [[20.10,-dim_t3_board[2]-2.1],[4.5,2.1],hole_depth,1],// reset button
                       [[0,-dim_t3_board[2]],[dim_t3_board[1],uppers_t3+dim_t3_board[2]],10,3], // opening to side high
                       [[(dim_t3_board[1]-20)/2,-10],[20,8.8],15,3]]; // opening to side long

// calculated values
height_batt         = uppers_batt+lowers_batt+dim_batt_board[2];
height_pi           = uppers_pi+lowers_pi+dim_pi_board[2];
height_t3           = uppers_t3+lowers_t3+dim_t3_board[2];

// connection screw values
dia_conn            = 3.5; // diameter of screws connectiong all cases
overhang_conn       = 6; // how much higher the connection screws than the cases
height_conn_high    = height_batt+height_pi+height_t3+overhang_conn;
height_conn_low     = height_batt+height_pi+overhang_conn;
loc_conn_high       = [[-(screw_spacing+dia_conn)/2+wall,
                        (screw_spacing+dia_conn)/2],
                       [(screw_spacing+dia_conn)/2,
                        dim_batt_board[1]+2*(wall+rim)+(screw_spacing+dia_conn)/2-wall],
                       [dim_t3_board[0]+2*(wall+rim)+(screw_spacing+dia_conn)/2,
                        -(dim_pi_board[1]-dim_batt_board[1])-(screw_spacing+dia_conn)/2+wall],
                       [dim_t3_board[0]+2*(wall+rim)-(screw_spacing+dia_conn)/2,
                        dim_batt_board[1]+2*(wall+rim)+(screw_spacing+dia_conn)/2-wall]];
loc_conn_low        = [[dim_batt_board[0]+2*(wall+rim)+(screw_spacing+dia_conn)/2-wall,
                        (screw_spacing+dia_conn)/2],
                       [dim_batt_board[0]+2*(wall+rim)-(screw_spacing+dia_conn)/2,
                        dim_batt_board[1]+2*(wall+rim)+(screw_spacing+dia_conn)/2-wall]];


// uncomment the part to render
//part_top();
//part_t3();
part_pi();
//part_battery();
//part_bottom();

//complete_object();

// create parts by cutting out from whole object
module part_bottom(){
    difference(){
        complete_object();
        translate([-50,-50,lowers_batt-wall]){
            cube([200,200,100]);
        }
    }
}

module part_battery(){
    difference(){
        complete_object();
        translate([-50,-50,lowers_batt-wall-100]){
            cube([200,200,100]);
        }
        translate([-50,-50,height_batt+lowers_pi-wall]){
            cube([200,200,100]);
        }
    }
}

module part_pi(){
    difference(){
        complete_object();
        translate([-50,-50,height_batt+lowers_pi-wall-100]){
            cube([200,200,100]);
        }
        translate([-50,-50,height_batt+height_pi-wall]){
            cube([200,200,100]);
        }
    }  
}

module part_t3(){
    difference(){
        complete_object();
        translate([-50,-50,height_batt+height_pi-wall-100]){
            cube([200,200,100]);
        }
        translate([-50,-50,height_batt+height_pi+height_t3-uppers_t3-dim_t3_board[2]]){
            cube([200,200,100]);
        }
    }
}

module part_top(){
    difference(){
        complete_object();
        translate([-50,-50,height_batt+height_pi+height_t3-uppers_t3-dim_t3_board[2]-100]){
            #cube([200,200,100]);
        }
    }
}

// whole object with all cases and hull
module complete_object(){
    difference(){
        union(){
            // hull with port cutouts
            difference(){
                hull(){
                    connection_short(dia=dia_conn+screw_spacing);
                    connection_long(dia=dia_conn+screw_spacing);
                    battery(render_mode="normal");
                    pi(render_mode="normal");
                    t3(render_mode="normal");
                }
                battery(render_mode="shape");
                pi(render_mode="shape");
                #t3(render_mode="shape");
            }
            // add cases whith connection holes cut out
            connection_short(dia=dia_conn+screw_spacing);
            connection_long(dia=dia_conn+screw_spacing);
            battery(render_mode="normal");
            pi(render_mode="normal");
            t3(render_mode="normal");
        }
        // cut out the connection screw holes
        connection_short(dia=dia_conn);
        connection_long(dia=dia_conn);
        // cut out top screw openings
        translate([0,0,height_conn_high-(overhang_conn/2-1)]){
            connection_long(dia=dia_conn+2*screw_spacing);
        }
        translate([0,0,height_conn_low-(overhang_conn/2-1)]){
            connection_short(dia=dia_conn+2*screw_spacing);
        }
        // cut out bottom screw openings
        translate([0,0,-height_conn_high+(overhang_conn/2-1)]){
            connection_long(dia=dia_conn+2*screw_spacing);
        }
        translate([0,0,-height_conn_low+(overhang_conn/2-1)]){
            connection_short(dia=dia_conn+2*screw_spacing);
        }
    }
}

// battery case
module battery(render_mode){
    case(dim_b=dim_batt_board,
         dia_s=dia_batt_screws,
         loc_s=loc_batt_screws,
         h1=uppers_batt,
         h2=lowers_batt,
         w=wall,
         r=rim,
         space_s=screw_spacing,
         mki=mki,
         cuts=cuts_batt,
         render_mode=render_mode);
}

// pi case placed on top of battery
module pi(render_mode){
    translate([dim_batt_board[0]-dim_pi_board[0],
               dim_batt_board[1]-dim_pi_board[1],
               height_batt]){
        case(dim_b=dim_pi_board,
             dia_s=dia_pi_screws,
             loc_s=loc_pi_screws,
             h1=uppers_pi,
             h2=lowers_pi,
             w=wall,
             r=rim,
             space_s=screw_spacing,
             mki=mki,
             cuts=cuts_pi,
             render_mode=render_mode);
    }
}
     
// t3 case placed on top of pi
module t3(render_mode){
    translate([0,
               dim_batt_board[1]-dim_t3_board[1],
               height_batt+height_pi]){
        case(dim_b=dim_t3_board,
             dia_s=dia_t3_screws,
             loc_s=loc_t3_screws,
             h1=uppers_t3,
             h2=lowers_t3,
             w=wall,
             r=rim,
             space_s=screw_spacing,
             mki=mki,
             cuts=cuts_t3,
             render_mode=render_mode);
    }
}

// long connection screws
module connection_long(dia){
    translate([0,0,-overhang_conn/2]){
        conn_holes(locations=loc_conn_high,
                   dia=dia,
                   h=height_conn_high);
    }
}

// short connection screws
module connection_short(dia){
    translate([0,0,-overhang_conn/2]){
        conn_holes(locations=loc_conn_low,
                   dia=dia,
                   h=height_conn_low);
    }
}

// make screw_holes
module conn_holes(locations,dia,h){
    for (location=locations){
        translate([location[0],location[1],0]){
            cylinder(d=dia,
                     h=h);
        }
    }
}