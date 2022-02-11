$fn=32;
include <../generic_case-v2/basic_case-parameterized-v2.scad>

wall                = 1.2;
rim                 = 0.8;

// T3 LoRa frame values
dim_t3_board        = [65,27,1.25];
uppers_t3           = 5;
lowers_t3           = 12;
dia_t3_screws       = 2.3;
loc_t3_screws       = [[2.6,1.45],
                       [dim_t3_board[0]-2.6,3.2,0],
                       [dim_t3_board[0]-2.6,dim_t3_board[1]-1.45,0],
                       [2.6,dim_t3_board[1]-3.2,0]];
cuts_t3             = [[[14.8,-8],[7,7],wall+rim+1,"front","rnd"],  // antenna port
                       [[2.75,0],[8,3],wall+rim+1,"left","sqr_indent"], // usb port
                       [[13.4,0],[11.5,3],wall+rim+1,"left","sqr_indent"],  // sdcard/usb port
                       [[40.8,-dim_t3_board[2]-2.1],[4.65,2.1],wall+rim+1,"back","sqr_button"],  // reset
                       [[49.5,-dim_t3_board[2]-4],[9.4,4],wall+rim+1,"back","sqr_indent"]];// switch
space_t3_screws     = 1;
grow                = 4;
height_bottom       = 9;


%case(part="case_bottom",
     dim_board=dim_t3_board,
     space_top=uppers_t3,
     space_bottom=lowers_t3,
     dia_bscrew=dia_t3_screws,
     space_bscrew=space_t3_screws,     
     loc_bscrews=loc_t3_screws,
     cuts=cuts_t3,
     wall_frame=wall,
     rim=rim,
     grow=grow,
     height_bottom=height_bottom);


%case(part="case_inlay",
     dim_board=dim_t3_board,
     space_top=uppers_t3,
     space_bottom=lowers_t3,
     dia_bscrew=dia_t3_screws,
     space_bscrew=space_t3_screws,     
     loc_bscrews=loc_t3_screws,
     cuts=cuts_t3,
     wall_frame=wall,
     rim=rim,
     grow=grow,
     height_bottom=height_bottom);

    
case(part="case_cover",
     dim_board=dim_t3_board,
     space_top=uppers_t3,
     space_bottom=lowers_t3,
     dia_bscrew=dia_t3_screws,
     space_bscrew=space_t3_screws,     
     loc_bscrews=loc_t3_screws,
     cuts=cuts_t3,
     wall_frame=wall,
     rim=rim,
     grow=grow,
     height_bottom=height_bottom);