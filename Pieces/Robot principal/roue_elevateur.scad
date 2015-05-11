d_axe_central		= 12;  // diametre de broche AX12
d_roue_centre		= 30 ;
epaisseur_roue		= 6;

nb_vis	 			= 6;
diam_axes_vis		= 3;
ecart_centre_vis	= 9.5;

fn 					= 100 ;


_d_roue_extern		= d_roue_centre + epaisseur_roue;

difference(){
	// Roue
	union() {
		for (i = [0, 1]) {
			rotate([0, i * 180, 0]) {
				translate ([0, 0, - i * epaisseur_roue ]) {
					cylinder(h = epaisseur_roue / 2, d1 = _d_roue_extern, d2 = d_roue_centre, $fn=fn);
				}
			}
		}
	}

	//Trou central
	translate([0, 0, -0.1]) {
		cylinder(h = epaisseur_roue + 0.2, d = d_axe_central, $fn = fn);
	}
	
	//Trous vis
	for (angle = [0 : 360/nb_vis : 360]) {
		rotate([0, 0, angle]) {
			translate([ecart_centre_vis, 0, -0.1]) {
				cylinder(h = epaisseur_roue + 0.2, d = diam_axes_vis, $fn = fn);
			}
		}
		
	}
}