$fn=32;

wall            = 0.8;

fin_number      = 3;

rocket_diameter = 30;
rocket_length   = 78;

engine_diameter = 17.75;
engine_length   = 69.6;
engine_wall     = 2.4;

fin_angle       = 20;
fin_length      = 20;
fin_width       = 1.8;
fin_height      = 70;

guide_diameter  = 3.6;


engine_case();
rocket_case();
create_fins() fin();

module fin(fl=fin_length,
           fa=fin_angle,
           fw=fin_width,
           fh=fin_height,
           gd=guide_diameter)
{
    fh1=fl/tan(fa);
    
    difference(){
        union(){
            //guidance pipes
            cylinder(h=fh-0.5,d=gd+fw);
            translate([-(gd+fw)/2,-(gd+fw)/2,0])
                cube([(gd+fw)/2,gd+fw,fh-0.5]);
            translate([0,fw/2,0]){
                rotate([90,0,0]){
                    // top triangle of fin
                    linear_extrude(height = fw){
                        translate([0,max(fh-fh1,0),0])
                        polygon(points = [[0,0],[fl,0],[0,min(fh,fh1)]],
                                paths  = [[0,1,2]]);
                    }
                    
                    // bottom square of trangle
                    cube([fl,max(fh-fh1,0),fw]);
                }
            }
        }
        union(){
            rotate([90,0,0]){
                #linear_extrude(height = gd+2*fw, center=true){
                    translate([0,max(fh-fh1,0),0])
                        polygon(points = [[fl,0],[fl,min(fh,fh1)],[0,min(fh,fh1)]],
                                paths  = [[0,1,2]]);
                }
            }
            // hole for guidance
            cylinder(h=fh,d=gd);
        }
        
    }
}


module create_fins(rd=rocket_diameter,
                   fn=fin_number,
                   w=wall,
                   gd=guide_diameter)
{
    for (azimuth =[0:360/fn:359])
        rotate([0,0,azimuth])
            translate([(rd+gd)/2,0,0])
                children(0);
}


module rocket_case(rd=rocket_diameter,
                   rl=rocket_length)
{
    difference(){
        cylinder(h=rl,d=rd);
        cylinder(h=rl,d=rd-2*wall);
    }
}


module engine_case(ed=engine_diameter,
                   el=engine_length,
                   rd=rocket_diameter,
                   ew=engine_wall,
                   w=wall)
{
    // engine chamber
    difference(){
        union(){
            // main rocket engine chamber
            cylinder(h=el,d=ed+ew);
            // connectors to rocket
            translate([0,0,el/2]){
                rotate([0,0,90])
                    cube([rd,wall,el], center=true);
                cube([rd,wall,el], center=true);
            }
        }
        cylinder(h=el,d=ed);
    }

    // top lid
    translate([0,0,el]){
        difference(){
            cylinder(h=ew,d=rd);
            cylinder(h=ew,d=ed-ew);
        }
    }
}