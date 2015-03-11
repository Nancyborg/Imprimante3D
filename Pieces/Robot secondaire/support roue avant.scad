diam_tnut 			= 4;
diam_axe_roue 		= 4;
diam_conteneur_axe 	= 8;
profile				= 21;

epaisseur 			= 3;
longueur 			= 30;

nb_couche_support 	= 3;

largeur 			= profile + 2 * epaisseur;

fn 					= 100;

difference() {
	union(){
		cube([longueur, largeur, profile + epaisseur], center = true, $fn = fn);

		translate([0, 0, -(profile + epaisseur + diam_conteneur_axe) /2]) {
			rotate([90, 0, 0]) {
				cylinder(d = diam_conteneur_axe, h = largeur, center = true, $fn = fn);
			}
		}

		for(i = [0 : nb_couche_support - 1]) {
			translate([0, - (profile + epaisseur) / 2 + i * (profile + epaisseur) / (nb_couche_support - 1), - (largeur + diam_conteneur_axe) / 2]) {
				cube([longueur, epaisseur, diam_conteneur_axe + epaisseur], center = true, $fn = fn);
			}

		}

	}

	translate([0, 0, epaisseur / 2 + 1]) {
		cube([longueur + 2, profile, profile + 2], center = true, $fn = fn);
	}

	translate([0, 0, epaisseur / 2]) {
		rotate([90, 0, 0]) {
			cylinder(d = diam_tnut, h = largeur + 2, center = true, $fn = fn);
		}
	}

	translate([0, 0, -(profile + epaisseur + diam_conteneur_axe) /2]) {
		rotate([90, 0, 0]) {
			cylinder(d = diam_axe_roue, h = largeur + 2, center = true, $fn = fn);
		}
	}
}	