diameter_interne = 26;
diameter_externe = 32;
height_boule_plateau = 10;
height_max = 47;
$fn = 100;

height = height_max - height_boule_plateau;

module support(){
	difference(){
		cylinder(height,d=diameter_externe);
		translate([0,0,-10]){
			cylinder(height+20,d=diameter_interne);
		}
	}
}

module serre_bille(){
	difference(){
		cube([17,9,8]);
		translate([4,3,1]){
			cube([8,3,8]);
		}

		translate([8,12,5]){
			rotate([90,0]){
				cylinder(h=22,d=3);
			}
		}
	}
}


union(){
	difference(){
		support();
		translate([-6,7,0]){
			translate([6,10,5]){
				rotate([90,0]){
					cylinder(h=20,d=3);
				}
			}
		}
	}

	translate([-8,13,0]){
		serre_bille();
	}
}