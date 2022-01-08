$fn = 128;

bullet_diameter     = 17.27;
bullet_tip_diameter = 3;
bullet_height       = 30;
bullet_amount       = 1;
mold_wall           = 2;

half_mold(bullet_amount,
          bullet_diameter, 
          bullet_tip_diameter, 
          bullet_height, 
          mold_wall);

module half_mold(amount, diameter, tip, height, wall) {
    
    mold_width=diameter+2*wall;
    
    module single_mold(diameter,tip,wall,height) {
        difference(){
            translate([0,0,height/2]) {
                cube([mold_width,mold_width,height],center=true);
            }
            union(){
                cylinder(1/6*height, d=diameter);
                translate([0,0,1/6*height]) {
                    cylinder(2/6*height, d1=diameter, d2=diameter/4);
                }
                translate([0,0,3/6*height]) {
                    cylinder(3/6*height, d1=tip, d2=tip);
                }
            }
        }
    }    


    module molds(amount){
        for (i=[0 : mold_width : mold_width*(amount-1)]) {
            translate([i,0,0]) {
                single_mold(diameter,tip,wall,height);
            }
        }
    }
    
    
    translate([0,0,height]){
        rotate([0,180,0]) {
            difference(){
                molds(amount);
                translate([-mold_width/2,0,0])
                    cube([mold_width*amount+0.2,mold_width,height]);
            }
        }
    }
}