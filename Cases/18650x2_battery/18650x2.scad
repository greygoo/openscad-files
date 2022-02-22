$fn=32;
include <../generic_case-v2/basic_case-parameterized-v2.scad>

//part                = "case_cover";

// Render
//bat(part);

dim_bat_board        = [100.5,48.5,1.65];
uppers_bat           = 5;
lowers_bat           = 22;
dia_bat_screws       = 3;
loc_bat_screws       = [[2.8,6.6],
                       [dim_bat_board[0]-1.8,7.2,0],
                       [dim_bat_board[0]-1.8,dim_bat_board[1]-8.2],
                       [2.8,dim_bat_board[1]-8.5,0]];
cuts_bat             = [[[7.6,-6],[7.6,4],"front","sqr_indent"],  // button
                       [[7,0],[9,3.45],"back","sqr_indent"], // usb-c
                       [[20.7,0],[7.75,2.95],"back","sqr_indent"],  // usb
                       [[83.5,-6.5],[9,4],"back","sqr_indent"], // switch
                       [[18,-8],[13.2,5.8],"left","sqr_indent"]]; // big usb
space_bat_screws     = 2;

module bat(part                = "case_all",
           grow                = 4,
           height_bottom       = 16,
           dia_cscrew          = 3.4,
           dia_chead           = 4.7,
           height_chead        = 1.8,
           text                = "TSM",
           font                = "Source Sans Pro:style=Bold",
           size_text           = 8,
           loc_text            = [4.5,14.5],
           wall                = 1.2,
           rim                 = 0.8,
           mki                 = 4,
           port_length         = 4.8){
    
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
         port_length=port_length,      
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