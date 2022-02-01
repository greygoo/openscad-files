$fn=32;

dim_case_top        = [190,141];
dim_case_bottom     = [180,131];
height_case         = 78;
mki_case_top        = 8;
mki_case_bottom     = 4;

wide_caseframe      = 10;


module rd_square(dimension,minkowski_value){
    translate([minkowski_value,minkowski_value,0]){
        minkowski() {
                square(dimension-2*[minkowski_value,minkowski_value]);
                circle(minkowski_value);
        }
    }
}

difference(){
    caseshape();
    frame_cutout();
}


module frame_cutout(){
    // top/bottom cutout
    translate([wide_caseframe,wide_caseframe,0]){
        resize(newsize=[dim_case_top[0]-2*wide_caseframe,
                         dim_case_top[1]-2*wide_caseframe,
                         height_case+mki_case_bottom]) frame1();
    }

    // x cutout
    translate([-wide_caseframe,wide_caseframe,wide_caseframe]){
        resize(newsize=[dim_case_top[0]+2*wide_caseframe,
                         dim_case_top[1]-2*wide_caseframe,
                         height_case-2*wide_caseframe]) frame1();
    }

    // y cutout
    translate([wide_caseframe,-wide_caseframe,wide_caseframe]){
        resize(newsize=[dim_case_top[0]-2*wide_caseframe,
                         dim_case_top[1]+2*wide_caseframe,
                         height_case-2*wide_caseframe]) frame1();
    }
}

module frame1() {
    hull(){
        //top square
        linear_extrude(0.1)
            rd_square(dim_case_top,mki_case_top);

        //bottom_square
        translate([(dim_case_top[0]-dim_case_bottom[0])/2,
                   (dim_case_top[1]-dim_case_bottom[1])/2,
                   height_case-0.1])
            linear_extrude(0.1)
                rd_square(dim_case_bottom,mki_case_bottom);    
    }
}

module caseshape(){
    hull(){

        resize(newsize=[0,0,height_case-mki_case_bottom]) frame1();
        // bottom minkowsi
        translate([(dim_case_top[0]-dim_case_bottom[0])/2+mki_case_bottom,
                   (dim_case_top[1]-dim_case_bottom[1])/2+mki_case_bottom,
                   height_case-mki_case_bottom-0.1]){
            minkowski(){
                linear_extrude(0.1){                
                    rd_square(dim_case_bottom-2*[mki_case_bottom,mki_case_bottom],
                              mki_case_bottom);
                }
                sphere(mki_case_bottom);
            }
        }
    }   
}