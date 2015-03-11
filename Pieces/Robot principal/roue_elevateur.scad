d_axe 				= 2;  // diametre de broche AX12
d_roue_1			= 20 ; 
d_roue_2			= 15 ;
epaisseur_roue		= 5;
diam_axes			= 8;


difference(){
	union() {
		cylinder(h = epaisseur_roue / 2, r1 = d_roue_1, r2 = d_roue_2,$fn=100);
		translate([0,0,epaisseur_roue /2])
			cylinder(h = epaisseur_roue / 2, r1 = d_roue_2, r2 = d_roue_1, $fn=100);

	}
	union(){
		translate([0,0,-1]){
			cylinder (h = epaisseur_roue + 2, r=d_axe, $fn=100);

			translate([diam_axes, 0, 0])
				cylinder(h = epaisseur_roue + 2, r=d_axe, $fn=100);
			translate([0, diam_axes, 0])
				cylinder(h = epaisseur_roue + 2, r=d_axe, $fn=100);
			translate([-diam_axes, 0, 0])
				cylinder(h = epaisseur_roue + 2, r=d_axe, $fn=100);
			translate([0, -diam_axes, 0])
				cylinder(h = epaisseur_roue + 2, r=d_axe, $fn=100);
		}
	}
}