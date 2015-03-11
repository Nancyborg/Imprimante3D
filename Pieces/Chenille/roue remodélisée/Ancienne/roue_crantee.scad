nb_pics = 9;
delta_diam_rondelle = 5.5;
profondeur_pic = 2;
//diam = nb_pics * 13 / (2 * PI) - delta_diam_rondelle / 2;
diam = nb_pics * 13 / (2 * PI) - 2 * profondeur_pic;
wheel_height = 28;
center_height = 9;
diam_axe_center = 5;
fn=30 * nb_pics;


difference(){	
	union(){
		//gros cylindre
		cylinder(h = wheel_height, r = diam, $fn=fn);
		//troncature inférieure
		translate([0, 0, (wheel_height - center_height) / 2])
			cylinder(h = center_height / 6, r1 = diam, r2 = diam + delta_diam_rondelle, $fn=fn);
		//milieu
		translate([0, 0, (wheel_height - center_height) / 2 + center_height / 6])
			cylinder(h = 2 * center_height / 3, r = diam + delta_diam_rondelle, $fn=fn);
		//troncature supérieure
		translate([0, 0, (wheel_height - center_height) / 2 + 5 * center_height / 6])
			cylinder(h = center_height / 6, r1 = diam + delta_diam_rondelle, r2 = diam, $fn=fn);
			translate([-20, 0, 0])
			cube([9,9,9], center = true);
	}
	//génération des crans
	for(i = [1 : nb_pics]) {
		rotate([0, 0, i * 360 / nb_pics])
			//cran
			translate([diam + delta_diam_rondelle, 0, wheel_height/2])
				rotate([0, 0, 45])
					cube(size = [delta_diam_rondelle * 1.4, delta_diam_rondelle * 1.4, wheel_height], center = true);
	}

	translate([0, 0, wheel_height / 2])
		cylinder(h = wheel_height / 2 + 0.1, r = 0.8 * diam, $fn=fn);

	translate([0,0,0]);
	cylinder(d=diam_axe_center,h=wheel_height*2,$fn=fn);
}
