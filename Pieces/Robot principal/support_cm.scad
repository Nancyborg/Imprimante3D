difference(){
    union(){
        cylinder(4, d=8, center=false);

        translate([0, -4, 0]){
            cube([40, 8, 4], center=false);
        }

        translate([40, 0, 0]){
            cylinder(4, d=8, center=false);
        }
    }
    
    union(){
        translate([0, 0, -1]){
            cylinder(6, d=4, center=false);
            
            translate([40, 0, 0]){
                cylinder(6, d=4, center=false);
            }
        }
    }
}