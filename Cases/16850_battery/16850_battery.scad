$fn=32;
include <../generic_case-v2/basic_case-parameterized-v2.scad>

part                = "case_cover";
//part                = "case_inlay";
//part                = "case_bottom";

wall                = 1.2;
rim                 = 0.8;
mki                 = 4;

bat(part);

module bat(part){
    dim_bat_board        = [99.4,29.8,1.6];
    uppers_bat           = 5.7;
    lowers_bat           = 20;
    dia_bat_screws       = 3;
    loc_bat_screws       = [[2.25,2.25],
                           [dim_bat_board[0]-2.25,2.25,0],
                           [dim_bat_board[0]-2.25,dim_bat_board[1]-2.25],
                           [2.25,dim_bat_board[1]-2.25,0]];
    cuts_bat             = [[[85.6,0],[8,2.5],wall+rim+1,"front","sqr_indent"],  // usb
                           [[9.3,-dim_bat_board[2]-1.2-5.75],[13.4,5.75],wall+rim+1,"left","sqr_indent"], // usb
                           [[18.8,0],[9,3.3],wall+rim+1,"back","sqr_indent"],  // usb-c
                           [[85.3,-dim_bat_board[2]-1.5-2.7],[4.5,2.7],wall+rim+1,"back","sqr_button"]]; // button
    space_bat_screws     = 2;
    grow                = 4;
    height_bottom       = 16;
    dia_cscrew          = 2.3;
    dia_chead           = 4.7;
    height_chead        = 1.8;
    text                = "TSM";
    font                = "Source Sans Pro:style=Bold";
    size_text           = 8;
    loc_text            = [4.5,14.5];
    
    case(part=part,
         dim_board=dim_bat_board,
         space_top=uppers_bat,
         space_bottom=lowers_bat,
         dia_bscrew=dia_bat_screws,
         space_bscrew=space_bat_screws,     
         loc_bscrews=loc_bat_screws,
         cuts=cuts_bat,
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