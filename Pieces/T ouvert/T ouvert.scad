longueur 		= 70;
epaisseur		= 3;
profile 		= 21;
fn				= 100;
taille_cadre 	= profile + (2 * epaisseur);
diam_axe_roues 	= 4;
diam_trou_vis 	= 4;

//boolean
3_hole_type 	= 1;
has_renfort 	= 1;

rotate(a=[180, 0, 90]){
	difference() {
		union(){
			//Base du té
			cube(size = [longueur, taille_cadre, taille_cadre], center = true, $fn = fn);
			translate([0, 0, taille_cadre]) {
				//Base
				cube(size = [taille_cadre, taille_cadre, taille_cadre], center = true, $fn = fn);
			}

			if(has_renfort == 1) {
				for(r = [0, 180]) {
					rotate([0, 0, r]) {
						for(y = [- (profile + epaisseur)/ 2, (profile + epaisseur)/ 2]) {
							translate([0, y, 0]) {
								polyhedron(points = [ 	[ longueur / 2, - epaisseur / 2, profile / 2 + epaisseur],
														[ longueur / 2,   epaisseur / 2, profile / 2 + epaisseur],
														[ taille_cadre / 2, - epaisseur / 2, profile / 2 + epaisseur],
														[ taille_cadre / 2,   epaisseur / 2, profile / 2 + epaisseur],
														[ taille_cadre / 2, - epaisseur / 2, profile / 2 + epaisseur + taille_cadre],
														[ taille_cadre / 2,   epaisseur / 2, profile / 2 + epaisseur + taille_cadre]
													],
											faces = [	[0, 4, 5, 1],
														[0, 1, 3, 2],
														[4, 2, 3, 5],
														[1, 5, 3],
														[0, 2, 4]
													]
											);
							}
						}	
					}
				}
			}
		}
		

		//Excavation pour le profilé
		translate([0, 0, -(epaisseur / 2) - 1 ]) {
			cube(size = [longueur + 2, profile, profile + epaisseur + 2], center = true, $fn = fn);
		}
		

		if(3_hole_type == 1)
		{
			//Trou axe roues
			for(i = [-1 ,1]) {
				translate([i * longueur / 3, taille_cadre / 2 + 1, 0]) {
					rotate(a=[90, 0, 0]) {
						cylinder(h = taille_cadre + 2, d = diam_axe_roues, $fn = fn);
					}
				}
			}
		}

		//Trou axe roues
		translate([0, taille_cadre / 2 + 1, 0]) {
			rotate(a=[90, 0, 0]) {
				cylinder(h = taille_cadre + 2, d = diam_axe_roues, $fn = fn);
			}
		}

		//trou T-nut 1
		translate([longueur / 3, 0, 0]) {
			rotate(a=[0, 0, 0]) {
				cylinder(h = taille_cadre, d = diam_trou_vis , $fn = fn);
			}
		}
		//Trou T-nut 2
		translate([-(longueur / 3), 0, 0]) {
			rotate(a=[0, 0, 0]) {
				cylinder(h = taille_cadre, d = diam_trou_vis , $fn = fn);
			}
		}

	//Bite du T
		translate([0, 0, taille_cadre]) {				
			//Excavation
			cube(size = [profile, profile, taille_cadre + epaisseur + 5], center = true, $fn = fn);

			//trou T-nut
			translate([-(taille_cadre / 2) - 1, 0, 0]) {
				rotate(a=[0, 90, 0]) {
					cylinder(h = taille_cadre + 2, d = diam_trou_vis , $fn = fn);
				}
			}
		}
	}

}
