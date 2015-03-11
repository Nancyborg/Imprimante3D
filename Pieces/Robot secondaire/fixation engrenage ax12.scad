diametre_axe 				= 4;

diametre_trous_engrenage	= 6;
diametre_centre_engrenage 	= 8;
profondeur_centre_engrenage	= 2;
diametre_engrenage 			= 32;
biais_bord_engrenage 		= 1.5;
distance_trous_engrenage	= 10.25;

profondeur_engrenage 		= 1.5;
epaisseur_trou_engrenage	= 2.5;

diametre_vis_ax12 			= 2;
distance_trou_ax12 			= 8;

fn 							= 300;


difference () {
	//support de l'engrenage
	union() {
		cylinder(h = profondeur_engrenage, d1 = diametre_engrenage, d2 = (diametre_engrenage - 2 * biais_bord_engrenage), $fn = fn);


		//Pic fixation engrenage
		for(i = [0 : 3]) {
			rotate([0, 0, 90 * i]) {
				translate([distance_trous_engrenage, 0, profondeur_engrenage]) {
					cylinder(h = epaisseur_trou_engrenage, d = diametre_trous_engrenage, $fn = fn);
				}	
			}
		}


	}

	//Trou pour centre engrenage
	cylinder(d= diametre_centre_engrenage, h = 3 * profondeur_engrenage, center = true, $fn = fn);

	//Pic fixation engrenage
	for(i = [0 : 90 : 360]) {
		rotate([0, 0, i]) {
			translate([distance_trou_ax12, 0, -1]) {
				cylinder(h = profondeur_engrenage + epaisseur_trou_engrenage + 2, d = diametre_vis_ax12, $fn = fn);
			}	
		}
	}
}
