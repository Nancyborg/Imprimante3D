longeur 		= 106;
largeur 		= 24;
epaisseur 		= 4.5;
shift 			= 8;
profile 		= 20;
AX12_lgth 		= 37;

diam_tnut 		= 4;
diam_trou_vis 	= 2;

fn 				= 100;


union() {
	difference() {
		union() {
			//Patte de base
			cube([longeur, largeur, epaisseur + shift], center = true, $fn = fn);

			//arrondi bord
			for (i = [ -1, 1 ]) {
				translate([0, i * largeur / 2, -shift / 2]) {
					rotate([0, 90, 0]) {
						cylinder(d = epaisseur, h = longeur, center = true, $fn = fn);
					}
				}
			}
			
		}
		

		//Trou fixation T-nut
		for(i = [-6, 6]) {
			translate([0, i, 0]){
				cylinder(h = epaisseur + shift +  2, d = diam_tnut, center = true, $fn = fn);
			}
		}


		for(i = [0, 180]) {
			rotate([0, 0, i]){
				//extraction pour shift
				translate([(longeur - (longeur - profile)/ 2)/ 2 + 1, 0, epaisseur / 2 + 1]) {
					cube([(longeur - profile)/ 2 + 2, largeur + 2, shift + 2], center = true, $fn = fn);
				}

				//trou fixation AX12
				translate([(longeur / 2) - 25, 0, -shift / 2]) {
					for(y = [-1 : 1]) {
						for(x = [0 : 2]) {
							translate([x * 8, y * 8, 0]) {
								cylinder(h = epaisseur + 2, d = diam_trou_vis, center = true, $fn = fn);
							}
						}
					}
				}
			}
		}
	}

	//Pente
	for(i = [0, 180]) {
		rotate([0, 0, i]) {
			polyhedron(points = [
									[profile / 2, -largeur / 2, (shift + epaisseur) / 2],
									[profile / 2,  largeur / 2, (shift + epaisseur) / 2],
									[profile / 2, -largeur / 2, (epaisseur - shift) / 2],
									[profile / 2,  largeur / 2, (epaisseur - shift) / 2],
									[( (longeur / 2) - AX12_lgth), -largeur / 2, (epaisseur - shift) / 2],
									[( (longeur / 2) - AX12_lgth),  largeur / 2, (epaisseur - shift) / 2]
								],
						faces = [
									//coté
									[0, 4, 2], 
									[1, 3, 5], 
									//back
									[0, 2, 3, 1],
									//face
									[0, 1, 5, 4],
									//Sous
									[2, 4, 5, 3]
								]
						);
		}
	}
}
