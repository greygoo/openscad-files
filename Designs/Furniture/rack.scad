// rack module

rack_shelf_number   = 3;

// overall rack dimensions
rack_length         = 750;
rack_width          = 300;
rack_height         = 1500;

// values required to calculate shelfes
rack_bar_width      = 50;  // side bar/wall width
rack_board_height   = 50;  // height of single inlay boards
rack_floor_space    = 70; // free space below lowest board


// rendering with examples from above
rack(rack_shelf_number,
     rack_length,
     rack_width,
     rack_height,
     rack_bar_width,
     rack_board_height,
     rack_floor_space);


module rack(shelf_number,
            length,
            width,
            height,
            bar_width=50,
            board_height=50,
            floor_space=50){

    shelf_length   = length - 2 * bar_width;
    shelf_height   = (height - floor_space - board_height
                          - shelf_number * board_height)
                          / shelf_number - 1;
    shelf_offset   = shelf_height + board_height;

    difference(){
        // main frame
        cube([length,width,height]);
        
        // cutouts for shelfes
        translate([0,0,floor_space + board_height])
            for(i=[0:1:shelf_number - 1]) {
                echo(i * shelf_offset);
                translate([bar_width,0,i * shelf_offset])
                    cube([shelf_length,width,shelf_height]);
        }
    }
}