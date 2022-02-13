$fn=32;
include <../generic_case-v2/basic_case-parameterized-v2.scad>

//part                = "case_cover";
//part                = "case_inlay";
part                = "case_bottom";

wall                = 1.2;
rim                 = 0.8;
mki                 = 4;

RPI(part);

module RPI(part){
    dim_pi_board        = [65,30,1.5];
    uppers_pi           = 2.5;
    lowers_pi           = 4;
    dia_pi_screws       = 3;
    loc_pi_screws       = [[3.2,3.3],
                           [dim_pi_board[0]-3.2,3.3,0],
                           [dim_pi_board[0]-3.2,dim_pi_board[1]-3,0],
                           [3.2,dim_pi_board[1]-3.3,0]];
    cuts_pi             = [[[7,-dim_pi_board[2]],[8.2,3],wall+rim+1,"front","sqr_indent"],  // usb1
                           [[19.5,-dim_pi_board[2]],[8.2,3],wall+rim+1,"front","sqr_indent"], // usb2
                           [[47,-dim_pi_board[2]],[11.3,3.4],wall+rim+1,"front","sqr_indent"],  // mini hdmi
                           [[11.3,-dim_pi_board[2]],[11.8,3],wall+rim+1,"right","sqr_indent"],  // SD
                           [[6.6,-dim_pi_board[2]],[16.7,2.2],wall+rim+1,"left","sqr_indent"]]; // cam
    space_pi_screws     = 2;
    grow                = 4;
    height_bottom       = 4.8;
    dia_cscrew          = 2.3;
    dia_chead           = 4.7;
    height_chead        = 1.8;
    text                = "TSM";
    font                = "Source Sans Pro:style=Bold";
    size_text           = 8;
    loc_text            = [4.5,14.5];
    
    case(part=part,
         dim_board=dim_pi_board,
         space_top=uppers_pi,
         space_bottom=lowers_pi,
         dia_bscrew=dia_pi_screws,
         space_bscrew=space_pi_screws,     
         loc_bscrews=loc_pi_screws,
         cuts=cuts_pi,
         wall_frame=wall,
         rim=rim,
         grow=grow,
         dia_cscrew=dia_cscrew,
         dia_chead=dia_chead,
         height_chead=height_chead,
         height_bottom=height_bottom,
         mki=mki,
         text=text,
         size_text=size_text,
         loc_text=loc_text,
        font=font);
}