include <../RaspberryPiZero/RaspberryPiZero.scad>
include <../LoRa-T3/LoRa-T3_case.scad>
include <../18650x2_battery/18650x2.scad>

wall_frame=1.2;
rim=0.3;
mki=0;

height_bat_frame=calc_height_frame(uppers_bat,lowers_bat,dim_bat_board);
height_bat_case=calc_height_case(height_frame=height_bat_frame,
                                 height_top=wall_frame,
                                 height_floor=wall_frame);
dim_bat_frame=calc_dim_frame(dim_bat_board,wall_frame,rim,height_bat_frame);                        
dim_bat_case=calc_dim_case(dim_bat_frame,wall_frame,height_bat_case);

height_pi_frame=calc_height_frame(uppers_pi,lowers_pi,dim_pi_board);                                 
height_pi_case=calc_height_case(height_frame=height_pi_frame,
                                 height_top=wall_frame,
                                 height_floor=wall_frame);
dim_pi_frame=calc_dim_frame(dim_pi_board,wall_frame,rim,height_pi_frame);                        
dim_pi_case=calc_dim_case(dim_pi_frame,wall_frame,height_pi_case);

height_t3_frame=calc_height_frame(uppers_t3,lowers_t3,dim_t3_board);                                 
height_t3_case=calc_height_case(height_frame=height_t3_frame,
                                 height_top=wall_frame,
                                 height_floor=wall_frame);
dim_t3_frame=calc_dim_frame(dim_t3_board,wall_frame,rim,height_t3_frame);                        
dim_t3_case=calc_dim_case(dim_t3_frame,wall_frame,height_t3_case);

//hull(){
bat(part="case_all",
    dia_chead=0,
    dia_cscrew=0,
    height_chead=0,
    height_bottom=6,
    mki=mki);
    
translate([dim_bat_case[0]-dim_pi_case[0],
           dim_bat_case[1]-dim_pi_case[1],
           height_bat_case]){
    RaspberryPiZero(part="case_all",
                    dia_chead=0,
                    dia_cscrew=0,
                    height_chead=0,
                    mki=mki);
}

translate([10,
           dim_bat_case[1]-dim_t3_case[1],
           height_bat_case+height_pi_case-10]){
    T3(part="case_all",
            dia_chead=0,
            dia_cscrew=0,
            height_chead=0,
            mki=mki);
//}
}