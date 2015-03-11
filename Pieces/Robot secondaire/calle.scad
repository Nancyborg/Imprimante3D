diam_tnut 			= 4;
longueur 			= 20;
largeur 			= 24;

hauteur_calle 		= 17;

fn 					= 100;


difference(){
	cube([longueur, largeur, hauteur_calle], center = true, $fn = fn);
	for(i = [-6 , 6]){
		translate([0, i, 0]){
			cylinder(d = diam_tnut, h = hauteur_calle + 2, center = true, $fn = fn);
		}
	}
	
}