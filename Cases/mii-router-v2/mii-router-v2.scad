include <../RaspberryPiZero/RaspberryPiZero.scad>
include <../LoRa-T3/LoRa-T3_case.scad>
include <../18650x2_battery/18650x2.scad>

wall_frame=1.2;
rim=0.8;
mki=0.5;
offset_t3_x=10;
offset_t3_y=8;
offset_t3_z=-8;
lowers_t3=5;

offset_pi_y=3;

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

//shape_cases();
cases();


//////////////////////////////////////////
// frames

module filler_pi_frame(){
    translate([0,dim_pi_frame[1],0]){
        offset_pi_frame(){
            cube_round_xy([dim_pi_frame[0],
                           dim_bat_frame[1]-dim_pi_frame[1]-offset_pi_y,
                           dim_pi_frame[2]],mki);
        }
    }
}

module filler_t3_frame(){
    translate([0,dim_t3_frame[1],0]){
        offset_t3_frame(){
            cube_round_xy([dim_t3_frame[0],
                           dim_bat_frame[1]-dim_t3_frame[1]-offset_t3_y,
                           dim_t3_frame[2]],mki);
        }
    }
}

module offset_pi_frame() {
    translate([dim_bat_frame[0]-dim_pi_frame[0],
           offset_pi_y,
           height_bat_frame]) children();
}


module offset_t3_frame() {
    translate([offset_t3_x,
           offset_t3_y,
           height_bat_frame+height_pi_frame+0]) children();
}

//////////////////////////////////////////
// cases

module cases(){
    part_bat(part="case_cover");
    offset_pi_case(){
        part_pi(part="case_all");
    }
    offset_t3_case(){
        part_t3(part="case_all");
    }
    filler_pi_case();
    filler_t3_case();
}

module filler_pi_case(){
    translate([0,dim_pi_case[1],0]){
        offset_pi_case(){
            cube_round_xy([dim_pi_case[0],
                           dim_bat_case[1]-dim_pi_case[1]-offset_pi_y,
                           dim_pi_case[2]],mki);
        }
    }
}

module filler_t3_case(){
    translate([0,dim_t3_case[1],0]){
        offset_t3_case(){
            cube_round_xy([dim_t3_case[0],
                           dim_bat_case[1]-dim_t3_case[1]-offset_t3_y,
                           dim_t3_case[2]],mki);
        }
    }
}

module offset_pi_case() {
    translate([dim_bat_case[0]-dim_pi_case[0],
           offset_pi_y,
           height_bat_case]) children();
}


module offset_t3_case() {
    translate([offset_t3_x,
           offset_t3_y,
           height_bat_case+height_pi_case+0]) children();
}


////////////////////////////////////////////
// cutout shapes


module shape_cases(){
    cube_round_xy(dim_bat_case,mki);
    offset_pi_case(){
        cube_round_xy(dim_pi_case,mki);
    }
    offset_t3_case(){
        cube_round_xy(dim_t3_case,mki);
    }
    filler_pi_case();
    filler_t3_case();
}

module shape_ports(){
    
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
        render_top=false,
        render_floor=false);
}

module part_pi(part){
    RaspberryPiZero(part=part,
                    dia_chead=0,
                    dia_cscrew=0,
                    height_chead=0,
                    mki=mki,
                    rim=rim);
}

module part_t3(part){
    T3(part=part,
            dia_chead=0,
            dia_cscrew=0,
            height_chead=0,
            mki=mki,
            rim=rim);
}