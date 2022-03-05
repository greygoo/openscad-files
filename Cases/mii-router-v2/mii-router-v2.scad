include <../RaspberryPiZero/RaspberryPiZero.scad>
include <../LoRa-T3/LoRa-T3_case.scad>
include <../18650x2_battery/18650x2.scad>

wall_frame=1.2;
rim=0.8;
mki=0.5;
lowers_t3=5;

offset_pi_y=0;
offset_t3_x=0;
offset_t3_y=0;

// override pi ports
cuts_pi             = [//[[7,-dim_pi_board[2]-2.7],[8.2,3],"front","sqr_indent"],  // usb1
                       //[[19.5,-dim_pi_board[2]-2.7],[8.2,3],"front","sqr_indent"], // usb2
                       //[[47,-dim_pi_board[2]-3.4],[11.3,3.4],"front","sqr_indent"],  // mini hdmi
                       [[11.3,-dim_pi_board[2]-3+0.7],[11.8,6],"right","sqr_indent"],  // SD
                       //[[6.6,-dim_pi_board[2]-2.2],[16.7,2.2],"left","sqr_indent"], // cam
                       //[[6.5,23.5],[51,5.5],"top","sqr"] // gpio header
                       [[2,-10],[23,10],"left","sqr"], // con t3
                       ];
                       
// override t3 ports
cuts_t3             = [[[14.8,-8],[7.8,7.8],"front","rnd_indent"],  // antenna port
                       [[5,5],[60,20],"bottom","sqr"], //space below antenna
                       //[[2.75,0],[8,3],"left","sqr_indent"], // usb port
                       //[[13.4,0],[11.5,3],"left","sqr_indent"],  // sdcard/usb port
                       //[[40.8,-dim_t3_board[2]-2.1],[4.65,2.1],"back","sqr_cone"],  // reset
                       //[[49.5,-dim_t3_board[2]-4],[9.4,4],"back","sqr_cone"],// switch
                       [[2,-6.5],[30,9.5],"back","sqr"], //con pi
                       [[24.6,4.5],[25,17],"top","sqr"]]; //display
                       
// override battery ports
cuts_bat             = [[[7.6,-6],[7.6,4],"front","sqr_indent"],  // button
                       [[7,0],[9,3.45],"back","sqr_indent"], // usb-c
                       //[[20.7,0],[7.75,2.95],"back","sqr_cone"],  // usb
                       //[[83.5,-6.5],[9,4],"back","sqr_indent"], // switch
                       //[[18,-8],[13.2,5.8],"left","sqr_indent"] // big usb
                       ];
                       

height_bat_frame=calc_height_frame(uppers_bat,lowers_bat,dim_bat_board);
height_bat_case=calc_height_case(height_frame=height_bat_frame,
                                 height_top=wall_frame,
                                 height_floor=wall_frame);
echo("dim_bat_board: ",dim_bat_board);
echo("wall_frame: ",wall_frame);
echo("rim: ",rim);
echo("height_bat_frame", height_bat_frame);
dim_bat_frame=calc_dim_frame(dim_bat_board,wall_frame,rim,height_bat_frame);
echo("dim_bat_frame: ",dim_bat_frame);
dim_bat_case=calc_dim_case(dim_bat_frame,wall_frame,height_bat_case);

height_pi_frame=calc_height_frame(uppers_pi,lowers_pi,dim_pi_board);
height_pi_case=calc_height_case(height_frame=height_pi_frame,
                                 height_top=wall_frame,
                                 height_floor=wall_frame);
echo("height_pi_case: ",height_pi_case);
dim_pi_frame=calc_dim_frame(dim_pi_board,wall_frame,rim,height_pi_frame);
dim_pi_case=calc_dim_case(dim_pi_frame,wall_frame,height_pi_case);
echo("dim_pi_case: ",dim_pi_case);
height_t3_frame=calc_height_frame(uppers_t3,lowers_t3,dim_t3_board);
height_t3_case=calc_height_case(height_frame=height_t3_frame,
                                 height_top=wall_frame,
                                 height_floor=wall_frame);
dim_t3_frame=calc_dim_frame(dim_t3_board,wall_frame,rim,height_t3_frame);
dim_t3_case=calc_dim_case(dim_t3_frame,wall_frame,height_t3_case);


//////////////////////////////////////////
// render

translate([0,0,20])
    top();

translate([0,0,10])
    middle();
bottom();
module top(){
    difference(){
        case_all();
        sep_bottom();
        sep_middle();
    }
}

module middle(){
    difference(){
        case_all();
        sep_bottom();
        sep_top();
    }
}

module bottom(){
    difference(){
        case_all();
        sep_middle();
        sep_top();
    }
}

//shape_cases();
module case_all(){
    difference(){
        hull(){
            cases();
        }
        shape_cases();
        shape_ports();
    }
    cases();
}

//#shape_cases();
//cases();
//shape_ports();

// seperation cubes
dim_sep=[200,200];
height_sep_bottom = 20;
height_sep_middle = 15;
height_sep_top    = 20;


module sep_bottom(){
   cube([dim_sep[0],dim_sep[1],height_sep_bottom]);
}

module sep_middle(){
    translate([0,0,height_sep_bottom]){
        cube([dim_sep[0],dim_sep[1],height_sep_middle]);
    }
}

module sep_top(){
    translate([0,0,height_sep_bottom+height_sep_middle]){
        cube([dim_sep[0],dim_sep[1],height_sep_top]);
    }
}

//////////////////////////////////////////
// cases

module cases(){
    part_bat(part="case_all");
    place_pi_case(){
        part_pi(part="case_all");
    }
    place_t3_case(){
        part_t3(part="case_all");
    }
    //filler_pi_case();
    //filler_t3_case();
}

//module filler_pi_case(){
//    translate([0,dim_pi_case[1],0]){
//        place_pi_case(){
//            cube_round_xy([dim_pi_case[0],
//                           dim_bat_case[1]-dim_pi_case[1]-offset_pi_y,
//                           dim_pi_case[2]],mki);
//        }
//    }
//}
//
//module filler_t3_case(){
//    translate([0,dim_t3_case[1],0]){
//        place_t3_case(){
//            cube_round_xy([dim_t3_case[0],
//                           dim_bat_case[1]-dim_t3_case[1]-offset_t3_y,
//                           dim_t3_case[2]],mki);
//        }
//    }
//}

module place_pi_case() {
    translate([dim_bat_case[0]-dim_pi_case[0],
           offset_pi_y,
           height_bat_case]) children();
}

module place_t3_case() {
    translate([dim_t3_case[0]+offset_t3_x,
               dim_t3_case[1]+dim_pi_case[1]+offset_t3_y,
               height_bat_case+0]){
        rotate([0,0,180]) children();
    }
}


////////////////////////////////////////////
// shapes

module shape_cases(){
    part_bat(part="case_shape");
    place_pi_case(){
        part_pi(part="case_shape");
    }
    place_t3_case(){
        part_t3(part="case_shape");
    }
}

module shape_ports(){
    part_bat(part="cutout_shape");
    place_pi_case(){
        part_pi(part="cutout_shape");
    }
    place_t3_case(){
        part_t3(part="cutout_shape");
    }
}

////////////////////////////////////////////
// imported part modules with static values

module part_bat(part){
    bat(part=part,
        dia_chead=0,
        dia_cscrew=0,
        height_chead=0,
        height_bottom=6,
        mki=mki,
        wall=wall_frame,
        rim=rim,
        render_top=0);
}

module part_pi(part){
    RaspberryPiZero(part=part,
                    dia_chead=0,
                    dia_cscrew=0,
                    height_chead=0,
                    mki=mki,
                    wall=wall_frame,
                    rim=rim,
                    render_floor=0,
                    render_top=1,
                    port_extend=20);
}

module part_t3(part){
    T3(part=part,
            dia_chead=0,
            dia_cscrew=0,
            height_chead=0,
            mki=mki,
            wall=wall_frame,
            rim=rim,
            render_floor=0,
            text="");
}