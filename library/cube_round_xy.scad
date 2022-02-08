// Module for painting cube with rounded corners in xy directions

module cube_round_xy(dim,mki){
    translate([mki/2,mki/2,0]){
        linear_extrude(dim[2]){
            minkowski(){
                square([dim[0]-mki,dim[1]-mki]);
                circle(d=mki);
            }
        }
    }
}