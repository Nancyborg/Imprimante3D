// Taille de support sur le moteur
x_moteur = 19;
y_moteur = 22;
z_moteur = 4;

// Taille de support sur le plateau
x_plateau = x_moteur;
y_plateau = 5;
z_plateau = 20;

// Cylindre pour l'axe moteur
h_cylinder = 30;
diameter_cylinder = 12;

// Cylindre pour les fixations
h_vis = 30;
diameter_vis = 3;

$fn=100;

module fixation_moteur(){
difference(){
cube([x_moteur,y_moteur,z_moteur]);

translate([x_moteur/2,y_moteur/2,0]){
	cylinder(h_cylinder,d=diameter_cylinder);
}

translate([3,2,0]){
	cylinder(h_vis,d=diameter_vis);
}

translate([3,20,0]){
	cylinder(h_vis,d=diameter_vis);
}

translate([16,8,0]){
	cube([9,6,5]);
}

}

}// fin module fixation_moteur

union(){
	fixation_moteur();

	translate([0,y_moteur,0]){
		difference(){
			cube([x_plateau,y_plateau,z_plateau]);
			
			translate([5,5,12]){
				rotate([90,0,0]){
					cylinder(h_vis,d=diameter_vis);
				}
			}

			translate([15,5,12]){
				rotate([90,0,0]){
					cylinder(h_vis,d=diameter_vis);
				}
			}
		}
	}
}
