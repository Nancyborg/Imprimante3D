nb_dents 					= 16;

angle_attaque 				= 36.25;
longueur_dent 				= 8.9;	
espace_inter_dent 			= 5.9;
profondeur_dent 			= 3;
epaisseur_dent_extremite 	= 6;
epaisseur_dent_base 		= 10;
epaisseur_centre 			= 4;

profondeur_anneau 			= 2;

epaisseur_roue_min 			= 4;
epaisseur_roue_max 			= 6;
hauteur_roue 				= 25;

diametre_axe 				= 4;
epaisseur_axe		 		= 3;
//longueur de l'axe pour le tige
hauteur_support_axe 		= 12;

nb_trous 					= 6;

fn 							= 300;

perimetre_externe  			= nb_dents * (longueur_dent + espace_inter_dent);
diametre_externe 			= perimetre_externe / PI;
diametre_interne 			= diametre_externe - (2 * profondeur_dent);
diametre_anneau 			= diametre_interne;
diametre_roue	 			= diametre_interne - (2 * profondeur_anneau);
diametre_excavation_max 	= diametre_roue - (2 * epaisseur_roue_min);
diametre_excavation_min 	= diametre_roue - (2* epaisseur_roue_max);
demi_delta_epaisseur_dent 	= (epaisseur_dent_base - epaisseur_dent_extremite) / 2;
decalage_angle 				= profondeur_dent / tan(90 - angle_attaque);
hauteur_bord 				= (hauteur_roue - epaisseur_dent_base) / 2 ;
diametre_trous 				= (diametre_excavation_min - diametre_axe)/ 4;

//Roue - trous axe ..
difference () {
	//Roue
	union() {
		//Roue excavée
		difference()  {
			//Dents + roue
			union() {
				//dents
				difference(){
					union(){
						//Centre
						cylinder(d = diametre_externe, h = epaisseur_dent_extremite, center = true, $fn = fn);
						//Biais des cotés
						translate([0, 0, (epaisseur_dent_extremite + demi_delta_epaisseur_dent)/ 2]) {
							cylinder(d1 = diametre_externe, d2 = diametre_roue, h = demi_delta_epaisseur_dent, center = true, $fn = fn);
						}
						translate([0, 0, - (epaisseur_dent_extremite + demi_delta_epaisseur_dent)/ 2]) {
							cylinder(d1 = diametre_roue, d2 = diametre_externe, h = demi_delta_epaisseur_dent, center = true, $fn = fn);
						}
					}

					//création des dents par extraction de matière
					for(i = [0 : nb_dents - 1]) {
						rotate([0, 0, i * 360 / nb_dents]) {
							translate ([0, diametre_interne / 2, 0]) {
								//Forme du retrait des dents
								polyhedron(	points = [
														[- espace_inter_dent / 2, profondeur_dent,   hauteur_bord],
														[  espace_inter_dent / 2, profondeur_dent,   hauteur_bord],
														[- espace_inter_dent / 2, profondeur_dent, - hauteur_bord],
														[  espace_inter_dent / 2, profondeur_dent, - hauteur_bord],
														[- espace_inter_dent / 2 + decalage_angle, 0,   hauteur_bord],
														[  espace_inter_dent / 2 - decalage_angle, 0,   hauteur_bord],
														[- espace_inter_dent / 2 + decalage_angle, 0, - hauteur_bord],
														[  espace_inter_dent / 2 - decalage_angle, 0, - hauteur_bord],
														[- espace_inter_dent / 2, profondeur_dent + profondeur_dent,   hauteur_bord],
														[  espace_inter_dent / 2, profondeur_dent + profondeur_dent,   hauteur_bord],
														[- espace_inter_dent / 2, profondeur_dent + profondeur_dent, - hauteur_bord],
														[  espace_inter_dent / 2, profondeur_dent + profondeur_dent, - hauteur_bord]
													],
											faces = [
													 	[0 , 1 , 5 , 4 ],
													 	[2 , 6 , 7 , 3 ],
													 	[1 , 3 , 7 , 5 ],
													 	[4 , 5 , 7 , 6 ],
													 	[0 , 4 , 6 , 2 ],
													 	[0 , 8 , 9 , 1 ],
													 	[0 , 2 , 10, 8 ],
													 	[9 , 8 , 10, 11],
													 	[10, 2 , 3 , 11],
													 	[1 , 9 , 11, 3 ]
													]
											);
							}
						}
					}
				}

				//Bord de la roue
				cylinder(d = diametre_roue, h = hauteur_roue, center = true, $fn = fn);

			}

			
			// excavation de la roue
			translate([0, 0, epaisseur_centre / 2 + 0.1]) {
				cylinder(d1 = diametre_excavation_min, d2 = diametre_excavation_max, h = hauteur_roue - epaisseur_centre + 0.2, center = true, $fn =fn);
			}
		}
		
		//Support axe central
		translate([0, 0, - (hauteur_roue - hauteur_support_axe) / 2]) {
			cylinder(d = diametre_axe + 2 * epaisseur_axe, h = hauteur_support_axe, center = true, $fn = fn);
		}
	}

	//Trou axe
	cylinder(d = diametre_axe, h = hauteur_roue + 2, center = true, $fn =fn);

	//Trous pour gain matière
	for(i = [0 : nb_trous - 1]) {
		rotate([0, 0, i * (360 / nb_trous)]) {
			translate([(diametre_excavation_min - diametre_axe) / 4 + epaisseur_axe / 2 + diametre_axe / 2, 0, 0]) {
				cylinder(d = diametre_trous, h = hauteur_roue + 2, center = true, $fn =fn);
			}
		}
	}
}
