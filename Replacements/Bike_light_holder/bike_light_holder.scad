light_width1 = 35;
light_width2 = 40;
light_height = 5;
connector_length = 35;


translate ([light_width1/2 + 2 ,0,0])
    cube([3,connector_length,light_height - 0.2], center = true);
    
translate ([-(light_width1/2 + 2) ,0,0])
    cube([3,connector_length,light_height - 0.2], center = true);

translate ([0,connector_length/2 - 2.5,0])
    cube([light_width1+4, 5, light_height - 0.2],center = true);
    
translate([0,connector_length/2 + 5,-2.5]){
    rotate([0,90,0]) {
        difference(){
            union(){
                cylinder(5,5,5);
                translate([-5,-5.5,0]){
                    cube([5,5,light_height]);
                }
            }
            cylinder(5,2.5,2.5);
            
        }
    }
}
     
//translate([0,connector_length/2 - 2,-2.5]){
//    cube([5,5,light_height]);
//}