frm_front       = 8;
dim_front       = [190,141,4];
mki_front       = 8;          // minkowski dim of frontplate
loc_front       = [mki_front/2,mki_front/2,0];

dim_display     = [155,100,dim_front[2]];
loc_display     = [frm_front,dim_front[1]-dim_display[1]-frm_front,0];
dia_scw_display = 2;
dph_scw_display = dim_front[2]-1;
hed_scw_display = 5;
loc_scw_display = [[4.17,dim_display[1]+4.9,0],
                   [dim_display[0]-4.17,dim_display[1]+4.9,0],
                   [4.17,-4.9,0],
                   [dim_display[0]-4.17,-4.9,0]]; //relative to display


dim_switches    = [dim_front[0]-2*frm_front,
                   dim_front[1]-dim_display[1]-3*frm_front,
                   dim_front[2]];
loc_switches    = [frm_front,
                   dim_front[1]-dim_switches[1]-dim_display[1]-2*frm_front,
                   0];
                   
dim_plugs       = [dim_front[0]-dim_display[0]-3*frm_front,
                   dim_front[1]-dim_switches[1]-3*frm_front,
                   dim_front[2]];
loc_plugs       = [dim_display[0]+2*frm_front,
                   dim_switches[1]+2*frm_front,
                   0];
                   
 

difference(){
    frontplate();
    display();
    switches();
    plugs();
}
#screws();

module frontplate(){
    minkowski() {
        translate(loc_front)
            cube([dim_front[0]-mki_front,
                 dim_front[1]-mki_front,
                 dim_front[2]/2]);
        cylinder(d=mki_front, h=dim_front[2]/2);
    }
}

module display(){
    translate(loc_display)
        cube(dim_display);
}

module switches(){
    translate(loc_switches)
        cube(dim_switches);
}

module plugs(){
    translate(loc_plugs)
        cube(dim_plugs);
}

module screws(){
    translate(loc_display){
        for(loc=loc_scw_display){
            translate(loc)
                cylinder(h=dph_scw_display,d=dia_scw_display);
        }
    }
}

//cube([100,100,50]);
//translate([200*$t,100*$t,0])
//rotate([0,$t*360,0])
//cylinder(d1=500*$t,d2=$t*500, h=50*$t);