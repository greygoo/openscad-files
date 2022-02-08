include <../generic_case/basic_case-parameterized-v2.scad>

wall                = 1.6;
rim                 = 0.8;

// T3 LoRa frame values
dim_t3_board        = [65,27,1.25];
uppers_t3           = 5;
lowers_t3           = 12;
dia_t3_screws       = 2.1;
loc_t3_screws       = [[2.6,1.45],
                       [dim_t3_board[0]-2.6,3.2,0],
                       [dim_t3_board[0]-2.6,dim_t3_board[1]-1.45,0],
                       [2.6,dim_t3_board[1]-3.2,0]];
cuts_t3             = [[[14.8,-8],[7,7],wall+rim+1,"front","round"],  // antenna port
                       [[1.5,-1.75],[11,6],wall+rim+1,"left","square"], // usb port
                       [[13.4,0],[11.5,3],wall+rim+1,"left","square"],  // sdcard/usb port
                       [[40.8,-dim_t3_board[2]-2.1],[4.65,2.1],wall+rim+1,"back","square"],  // reset
                       [[49.5,-dim_t3_board[2]-4],[9.4,4],wall+rim+1,"back","square"]];// reset button
space_t3_screws        = 1;

case(dim_b=dim_t3_board,
     h1=uppers_t3,
     h2=lowers_t3,
     dia_s=dia_t3_screws,
     space_s=space_t3_screws,     
     loc_s=loc_t3_screws,
     cuts=cuts_t3,
     w=wall,
     r=rim);