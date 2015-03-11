marge_mecanique 			= 1;

diam_vis_moteur				= 3;
diam_vis_fixation 			= 4;


distance_bord_vis_arrierre 	= 7;
distance_bord_vis_superieures = 6;

hauteur_moteur				= 47;
largeur_moteur 				= 44 + marge_mecanique;
profondeur_moteur 			= 22;

diam_moteur 				= 17 + marge_mecanique;
distance_bord_moteur 		= 18 - marge_mecanique;


equerre_gauche 				= 1;
renfort_gauche 				= 1;
equerre_droite 				= 1;
renfort_droit 				= 1;
equerre_arriere 			= 1;
renfort_arriere 			= 1;

epaisseur 					= 4;
profile 					= 20 + marge_mecanique;

espace_inter_profile 			= 100;
distance_bas_moteur_a_profile 	= 0;

fn 							= 300;


union() {
	translate ([- epaisseur - largeur_moteur / 2, - (epaisseur + profondeur_moteur) / 2, 0]) {
		//Corps de maintient du moteur
		difference() {
			cube([largeur_moteur + 2 * epaisseur, profondeur_moteur + epaisseur, hauteur_moteur + epaisseur]);

			//place moteur
			translate([epaisseur, epaisseur, epaisseur]){
				cube([largeur_moteur, profondeur_moteur + 0.1, hauteur_moteur + 0.1]);
			}

			//trou arrière
			translate([epaisseur + largeur_moteur / 2, epaisseur / 2, epaisseur +  distance_bord_vis_arrierre]){
				rotate([90, 0, 0]) {
					cylinder(d = diam_vis_moteur, h = epaisseur + 0.2, center = true, $fn = fn);
				}
			}

			//trous pour supérieur
			for (i = [ distance_bord_vis_superieures, largeur_moteur - distance_bord_vis_superieures]) {
				translate([epaisseur + i, epaisseur + profondeur_moteur - distance_bord_vis_superieures, - 0.1]) {
					cylinder(d = diam_vis_moteur, h = epaisseur + 0.2, $fn = fn);
				}
			}
			translate([epaisseur + largeur_moteur / 2, epaisseur + distance_bord_vis_superieures, - 0.1]) {
				cylinder(d = diam_vis_moteur, h = epaisseur + 0.2, $fn = fn);
			}

			//trou pour moteur
			translate([epaisseur + largeur_moteur / 2, - 0.1, epaisseur + distance_bord_moteur + diam_moteur / 2]) {
				rotate([-90, 0, 0]) {
					cylinder(d = diam_moteur, h = epaisseur + 0.2, $fn = fn);
				}
			}
			//rainure pour moteur
			translate([epaisseur + largeur_moteur / 2 - diam_moteur / 2, - 0.1, distance_bord_moteur + diam_moteur / 2  + epaisseur]) {
				cube([diam_moteur, epaisseur + 0.2, hauteur_moteur - distance_bord_moteur - diam_moteur / 2 + 0.1]);
			}
		}
	}

	for (i = [0, 180]) {
		rotate([0, 0, i]){
			difference() {
				union() {
					//pate maintient
					translate([largeur_moteur / 2 + epaisseur, - (epaisseur + profondeur_moteur) / 2, hauteur_moteur - profile]) {
						cube([(espace_inter_profile - largeur_moteur) / 2 + profile, epaisseur + profondeur_moteur, epaisseur]);
					}

					//fixation sur profile
					translate([espace_inter_profile / 2 - epaisseur,  - (epaisseur + profondeur_moteur) / 2, hauteur_moteur - profile + epaisseur]) {
						difference() {
							cube([profile + 2 * epaisseur, epaisseur + profondeur_moteur, profile]);
							translate([epaisseur, -0.1, 0])
							cube([profile, epaisseur + profondeur_moteur + 0.2, profile + 0.1]);
						}
					}
				}

				//trou T-nut haut
				translate([(espace_inter_profile + profile) / 2, 0, hauteur_moteur - profile - 0.1]) {
					cylinder(d = diam_vis_fixation, h = epaisseur + 0.2, $fn = fn);
				}

				//trou T-nut coté
				translate([espace_inter_profile / 2 + profile - 0.1, 0, hauteur_moteur + epaisseur - profile / 2]) {
					rotate([0, 90, 0]) {
						cylinder(d = diam_vis_fixation, h = epaisseur + 0.2, $fn = fn);
					}
				}

			}


			//renforts haut
			translate([largeur_moteur / 2 + epaisseur, - epaisseur / 2, hauteur_moteur - profile + epaisseur]) {
				

				for(j = [ - (profondeur_moteur) / 2, profondeur_moteur / 2]) {
					translate([0, j, 0]) {
						polyhedron(points = [ [0, 0, 0], 
											  [(espace_inter_profile - largeur_moteur) / 2 - 2 * epaisseur, 0, 0],
											  [0, 0, profile], 
											  [0, epaisseur, 0],
											  [(espace_inter_profile - largeur_moteur) / 2 - 2 * epaisseur, epaisseur, 0],
											  [0, epaisseur, profile]
											],
									faces = [ [0, 2, 1],
											  [3, 4, 5],
											  [2, 0, 3, 5],
											  [0, 1, 4, 3],
											  [2, 5, 4, 1]
									]);
					}
				}

				translate ([- (largeur_moteur + espace_inter_profile) / 2 - 0.1, 0, 0]) {
					polyhedron(points = [ [0, 0, 0],  
										  [(espace_inter_profile - largeur_moteur) / 2 - 2 * epaisseur, 0, 0],
										  [0, 0, profile], 
										  [0, epaisseur, 0],
										  [(espace_inter_profile - largeur_moteur) / 2 - 2 * epaisseur, epaisseur, 0],
										  [0, epaisseur, profile]
										],
								faces = [ [0, 2, 1],
										  [3, 4, 5],
										  [2, 0, 3, 5],
										  [0, 1, 4, 3],
										  [2, 5, 4, 1]
								]);
				}
			}


			//renfort bas
			translate([]) {
				for(y = [ - (profondeur_moteur + epaisseur) / 2, (profondeur_moteur - epaisseur)/ 2]) {
					translate([largeur_moteur / 2 + epaisseur, y, 0]) {
						polyhedron(points = [ [0, 0, hauteur_moteur - profile],
											  [0, 0, 0],
											  [(espace_inter_profile - largeur_moteur) / 2 + profile, 0, hauteur_moteur - profile],
											  [0, epaisseur, hauteur_moteur - profile],
											  [0, epaisseur, 0],
											  [(espace_inter_profile - largeur_moteur) / 2 + profile, epaisseur, hauteur_moteur - profile]
											],
									faces = [ [0, 2, 1],
											  [3, 4, 5],
											  [0, 3, 5, 2],
											  [0, 1, 4, 3],
											  [1, 2, 5, 4]
									]);
					}
				}
			}
		}
	}
}