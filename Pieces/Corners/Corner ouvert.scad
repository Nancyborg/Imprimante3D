hauteur 		= 43;
epaisseur		= 3;
profile 		= 21;

fn				= 100;

taille_cadre 	= profile + (2 * epaisseur);

diam_trou_vis 	= 4;

//boolean
has_renfort 	= 1;

difference() {
	union(){
		cube([taille_cadre, taille_cadre, hauteur], center = true);

		for(i = [0, 90]) {
			rotate([0, 0, i]) {
				translate([0, taille_cadre / 2 + profile / 2, - (hauteur - profile - epaisseur) / 2]) {
					cube([taille_cadre, profile, profile + epaisseur], center = true);
				}

				for(n = [-1, 1]) {
					translate([n * (profile + epaisseur) / 2, profile / 2 + epaisseur, profile + epaisseur - hauteur / 2]) {
						polyhedron(points = [
												[- epaisseur / 2, 0, profile / 2],
												[  epaisseur / 2, 0, profile / 2],
												[- epaisseur / 2, 0, 0],
												[  epaisseur / 2, 0, 0],
												[- epaisseur / 2, profile / 2, 0],
												[  epaisseur / 2, profile / 2, 0]
											],
									faces = [
												[0, 4, 5, 1],
												[0, 1, 3, 2],
												[2, 3, 5, 4],
												[1, 5, 3],
												[0, 2, 4]
											]
									);
					}
				}
			}
		}



		translate([ - (profile / 2 + epaisseur), profile / 2 + epaisseur, - (hauteur - epaisseur) / 2]) {
			rotate([0, -90, 0]) {
				polyhedron(points = [
															[- epaisseur / 2, 0, profile / 2],
															[  epaisseur / 2, 0, profile / 2],
															[- epaisseur / 2, 0, 0],
															[  epaisseur / 2, 0, 0],
															[- epaisseur / 2, profile / 2, 0],
															[  epaisseur / 2, profile / 2, 0]
														],
												faces = [
															[0, 4, 5, 1],
															[0, 1, 3, 2],
															[2, 3, 5, 4],
															[1, 5, 3],
															[0, 2, 4]
														]
												);
			}
		}
	}

	
	//excavation centre
	cube([profile, profile, hauteur + 2], center = true);
 
	//excavation bords
	for(i = [0, 90]) {
		rotate([0, 0, i]) {
			translate([0, taille_cadre / 2 + profile / 2 + 0.1, - ((hauteur - profile) / 2 - epaisseur - 0.1)]) {
				cube([profile, profile + 0.2 , profile + 0.2 ], center = true);
				cylinder(h = hauteur, d = diam_trou_vis, center=true, $fn = fn);

			}
		}
	}

	for(i = [0, 90]){
		rotate([0, 0, i]) {
			translate([0, - (profile + epaisseur) / 2, (hauteur - profile) / 2]){
				rotate([90, 0, 0]) {
					cylinder(d = diam_trou_vis, h = epaisseur + 2, center = true, $fn = fn);
				}
			}
		}
	}
	
}
