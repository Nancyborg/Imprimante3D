diam_axe 		= 4;
diam_trous 		= 6;
diam_centre 	= 10.25;
diam_centr_engr = 8;
prof_centre 	= 2;
prof_axe 		= 25;

diametre 		= 32;

bord_biais 		= 1;
dst_trou 		= 10;

epaisseur 		= 3;
ep_engre 		= 1.5;
ep_trou 		= 3;

fn 				= 100;


difference() {
	union(){

		cylinder(h = epaisseur - ep_engre, d2 = diametre, d1 = (diametre - 2* bord_biais), center = true, $fn = fn);

		translate([0, 0, epaisseur / 2 ]) {
			cylinder(h = ep_engre, d = diametre, center = true, $fn = fn);
		}

		for(i = [0 : 3]) {
			rotate([0, 0, 90 * i]) {
				translate([dst_trou, 0, - (ep_engre + ep_trou) / 2 ]) {
					cylinder(h = ep_trou, d = diam_trous, center = true, $fn = fn);
				}	
			}
		}
		
		translate([0, 0, (prof_axe + epaisseur + ep_engre) / 2]) {
			cylinder(d = diam_centre, h = prof_axe, center = true, $fn = fn);
		}
		
	}

	translate([0, 0, (prof_axe + ep_engre) / 2]) {
		cylinder(d = diam_axe, h = prof_axe + epaisseur + 2, center = true, $fn = fn);
	}
	
	translate([0, 0, (prof_centre - epaisseur + ep_engre - 1) / 2 ]) {
		cylinder(d= diam_centr_engr, h = prof_centre + 1, center = true, $fn = fn);
	}

}

