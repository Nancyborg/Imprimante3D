diam_cercle = 80;
epaisseur_cercle = 14;
hauteur_cercle = 10;
diam_cercle_ext = diam_cercle + epaisseur_cercle;
extrusion = 20;
depassement_arriere = 15;
tronc_arriere = 15;
longueur_attache = 60;
profondeur_attache = 8;
diam_trou = 2;
pos_trou_X = 20;
pos_trou_Y = 20;
demi_hauteur = hauteur_cercle / 2;



union(){
	difference(){
		difference() {
			cylinder(d = diam_cercle_ext, h = hauteur_cercle);
			cylinder(d = diam_cercle, h = hauteur_cercle);
		}	
			translate([-diam_cercle_ext/2,0,0]){
			cube([diam_cercle_ext,diam_cercle_ext,hauteur_cercle+1]);
		}
	}
	translate([-diam_cercle_ext/2,0,0]){
		cube([epaisseur_cercle/2,extrusion, hauteur_cercle]);
		}
	translate([diam_cercle/2,0,0]){
		cube([epaisseur_cercle/2,extrusion, hauteur_cercle]);
		}
	translate([tronc_arriere/2,-diam_cercle_ext/2 + 3,0]){
		rotate([0,0,180]){
			cube([tronc_arriere,depassement_arriere,hauteur_cercle]);
		}
	}
	translate([longueur_attache/2,-diam_cercle_ext/2 - depassement_arriere + 3,0]){
		rotate([0,0,180]){
			difference(){
				cube([longueur_attache,profondeur_attache,hauteur_cercle]);
				rotate([-90,0,0]) {
					union() {
/*						translate([longueur_attache/ 2 - pos_trou_X,demi_hauteur - pos_trou_Y,0]){
							cylinder(d= diam_trou, h = profondeur_attache + 1);
						}
						translate([longueur_attache/ 2 + pos_trou_X,demi_hauteur ,0]){
							cylinder(d= diam_trou, h = profondeur_attache + 1);
						}
						translate([longueur_attache/ 2 - pos_trou_X,hauteur_cercle/ 2 ,0]){
							cylinder(d= diam_trou, h = profondeur_attache + 1);
						}
						translate([longueur_attache/ 2 + pos_trou_X,hauteur_cercle/ 2 ,0]){
							cylinder(d= diam_trou, h = profondeur_attache + 1);
						}
*/
					}
				}
			}
		}
	}

}

