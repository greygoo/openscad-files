// bed module

bed_length              = 2020;
bed_width               = 1020;
bed_frame_height        = 30;

bed_leg_height          = 1520;
bed_leg_width           = 74;

bed_rim_height          = 500;
bed_rim_width           = 20;

bed_frame_bar_width     = 144;
bed_frame_bar_height    = 20;
bed_frame_bar_space     = 80;


// example render with above values
bed(bed_length,
    bed_width,
    bed_frame_height,
    bed_leg_height,
    bed_leg_width,
    bed_rim_height,
    bed_rim_width,
    bed_frame_bar_height,
    bed_frame_bar_width,
    bed_frame_bar_space
    );


module bed(length,
           width,
           frame_height,
           leg_height,
           leg_width,
           rim_height,
           rim_width,
           frame_bar_height,
           frame_bar_width,
           frame_bar_space){
               
    // calculate frame bar values
    frame_bar_length    = width;
    frame_bar_num       = floor((length - frame_bar_width)
                         /(frame_bar_width + frame_bar_space));
    
    frame_bar_space     = (((length - frame_bar_width)
                            %(frame_bar_width + frame_bar_space))
                           /frame_bar_num)
                          +frame_bar_space;
               
    // calculate leg values
    bed_leg_x   = bed_length - leg_width;
    bed_leg_y   = bed_width - leg_width;
    bed_leg_pos = [[0,0,0],
                   [bed_leg_x,0,0],
                   [bed_leg_x,bed_leg_y,0],
                   [0,bed_leg_y,0]];


    // legs
    color("red")
    for (i=bed_leg_pos){
        translate(i)
            cube([leg_width,leg_width,leg_height]);
    }

    
    // upper side cross bars
    for(i=[0,width-leg_width])
        translate([0,i,leg_height])
            cube([length,leg_width,leg_width]);

    // upper front/back crossbars
    for(i=[0,length-leg_width]){
        translate([i,leg_width,leg_height])
            cube([leg_width,width-2*leg_width,leg_width]);
    }
    
    // lower side crossbars
    translate([leg_width,width-leg_width,rim_height])
        cube([length-2*leg_width,leg_width,leg_width]);
    
    // lower front/back cross bars
    for(i=[0,length-leg_width]){
        translate([i,leg_width,rim_height])
            cube([leg_width,width-2*leg_width,leg_width]);
    }    



    // bed frame bars
    translate([0,0,leg_height+leg_width]) {
    
        // first frame bar
        cube([frame_bar_width, frame_bar_length, frame_bar_height]);
        
        
        // remaining frame bars
        for(i=[0:1:frame_bar_num]){
            translate([i*(frame_bar_width+frame_bar_space),0,0])
                cube([frame_bar_width, frame_bar_length, frame_bar_height]);
        }
    }
    
    /*color("blue")
    translate([0,0,bed_leg_height])
        cube([length,width,frame_height]);
    */ 
    // side rims
    #for(i=[-rim_width, width])
        translate([0,i,leg_height])
            cube([length,rim_width,rim_height]);
    
    // front/back rims
    #for(i=[-rim_width, length])
        translate([i,-rim_width,leg_height])
            cube([rim_width,width + 2*rim_width,rim_height]);
    
    // output materials
    echo("Legs:\t\t 4x: ", h=leg_width, w=leg_width, l=leg_height);
    echo("Upper crossbars side:\t 2x: ", h=leg_width, w=leg_width, l=length);
    echo("Lower crossbars side:\t 1x: ", h=leg_width, w=leg_width, l=length-2*leg_width);
    echo("Crossbars f/b:\t 4x: ", h=leg_width, w=leg_width, h=width-2*leg_width);
    echo();
    echo("Total length\t ", 4*leg_height
                          + 2*length
                          + length-2*leg_width
                          + 4*(width-2*leg_width));
    echo("Rims side\t 2x: ", h=rim_width, w=rim_height, l=length);
    echo("Rims front/back\t 2x: ", h=rim_width, w=rim_height, l=width + 2*rim_width);
    echo("Frame bars\t ", num=frame_bar_num + 1, h=frame_bar_height, w=frame_bar_width, l=frame_bar_length);
    echo("Frame bar space\t ",frame_bar_space);
}

