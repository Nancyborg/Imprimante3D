marge_mecanique = 1;

largeur_profile = 20 + marge_mecanique;

support_moteur_largeur = 28;
support_moteur_epaisseur = 10;
support_moteur_hauteur = 40;

roue_jeu = 2;
roue_diametre = 72 + 2 * roue_jeu;
roue_largeur = 20 + 2 * roue_jeu;

decalage_centre_roue_support_moteur = 14;

codeuse_diametre = 28;
codeuse_profondeur = 21;
codeuse_roue_diametre = 54;
codeuse_roue_epaisseur = 12;
codeuse_distance_fixation_codeuse = 20;
codeuse_decalage_ressorts = 3;
codeuse_roulement_diametre = 8;
codeuse_roulement_hauteur = 12;
codeuse_distance_support = 28;
codeuse_axe_diametre = 4;
codeuse_support_cote = codeuse_roulement_diametre + 8;
codeuse_support_hauteur = 20;

plaque_epaisseur = 4;
plaque_largeur = 115;
plaque_longueur = roue_largeur + support_moteur_largeur + plaque_epaisseur + largeur_profile + codeuse_profondeur + codeuse_distance_fixation_codeuse + codeuse_roue_epaisseur; 

difference(){
	union(){
		//plaque
		cube([plaque_longueur, plaque_largeur, plaque_epaisseur]);

		//sur la plaque
		translate([0, 0, plaque_epaisseur]){
			//plaques de profile
			cube([plaque_epaisseur, plaque_largeur, largeur_profile]);
			translate([largeur_profile + plaque_epaisseur, 0, 0]){
				cube([plaque_epaisseur, plaque_largeur, largeur_profile]);
			}

			//support codeuse
			translate([
				largeur_profile + 3 * plaque_epaisseur + codeuse_roue_epaisseur + codeuse_distance_fixation_codeuse - codeuse_support_cote, 
				plaque_largeur / 2 - codeuse_distance_support - codeuse_support_cote / 2, 
				0
			]){
				cube([codeuse_support_cote, codeuse_support_cote, codeuse_support_hauteur]);
			
                translate([
				0, 
				2 * codeuse_distance_support + codeuse_support_cote / 2, 
				0
			]){
				cube([codeuse_support_cote, codeuse_support_cote, codeuse_support_hauteur]);
			}
              }

			translate([
				largeur_profile + 4 * plaque_epaisseur + codeuse_profondeur + codeuse_roue_epaisseur + roue_largeur + 1, 
				plaque_largeur / 2 - support_moteur_epaisseur -  decalage_centre_roue_support_moteur, 
				0
			]){
				cube([support_moteur_largeur, support_moteur_epaisseur, support_moteur_hauteur]);
			}

			//support cote
			polyhedron(
				points = [
			       [largeur_profile + 2 * plaque_epaisseur, 0, 0],
			       [largeur_profile + 2 * plaque_epaisseur, plaque_epaisseur, 0],
			       [largeur_profile + 2 * plaque_epaisseur, 0, largeur_profile],
			       [largeur_profile + 2 * plaque_epaisseur, plaque_epaisseur, largeur_profile],
			       [plaque_longueur - largeur_profile + 2 * plaque_epaisseur, 0, 0],
			       [plaque_longueur - largeur_profile + 2 * plaque_epaisseur, plaque_epaisseur, 0]
			    ], faces = [
					  [0,1,3,2], [4,5,1,0], [2,3,5,4], [0,2,4], [5,3,1]
				]
			);

			polyhedron(
				points = [
			       [largeur_profile + 2 * plaque_epaisseur, plaque_largeur - plaque_epaisseur + 0, 0],
			       [largeur_profile + 2 * plaque_epaisseur, plaque_largeur - plaque_epaisseur + plaque_epaisseur, 0],
			       [largeur_profile + 2 * plaque_epaisseur, plaque_largeur - plaque_epaisseur + 0, largeur_profile],
			       [largeur_profile + 2 * plaque_epaisseur, plaque_largeur - plaque_epaisseur + plaque_epaisseur, largeur_profile],
			       [plaque_longueur - largeur_profile + 2 * plaque_epaisseur, plaque_largeur - plaque_epaisseur + 0, 0],
			       [plaque_longueur - largeur_profile + 2 * plaque_epaisseur, plaque_largeur - plaque_epaisseur + plaque_epaisseur, 0]
			    ], faces = [
					  [0,1,3,2], [4,5,1,0], [2,3,5,4], [0,2,4], [5,3,1]
				]
			);
		}
	}

	union(){
		//retrais pour extrusion
		translate([0,0,-1]){
			//codeuse
			translate([largeur_profile + 3 * plaque_epaisseur + codeuse_roue_epaisseur, plaque_largeur / 2 - codeuse_diametre / 2 , 0]){
				cube([codeuse_profondeur, codeuse_diametre, plaque_epaisseur + 2]);
			}
			translate([largeur_profile + 3 * plaque_epaisseur + 1, plaque_largeur / 2 - codeuse_roue_diametre / 2 , 0]){
				cube([codeuse_roue_epaisseur, codeuse_roue_diametre, plaque_epaisseur + 2]);
			}
			//roulement codeuse
			translate([
				largeur_profile + 3 * plaque_epaisseur + codeuse_profondeur + codeuse_support_cote / 2 + codeuse_roue_epaisseur / 2 - codeuse_distance_fixation_codeuse - codeuse_support_cote / 2, 
				plaque_largeur / 2 - codeuse_distance_support, 
				0
			]){
				cylinder(d = codeuse_roulement_diametre, h = codeuse_roulement_hauteur + 1);
				cylinder(d = codeuse_axe_diametre, h = codeuse_support_hauteur + plaque_epaisseur + 2);
			}
			translate([
				largeur_profile + 3 * plaque_epaisseur + codeuse_profondeur + codeuse_support_cote / 2 + codeuse_roue_epaisseur / 2 - codeuse_distance_fixation_codeuse - codeuse_support_cote / 2, 
				plaque_largeur / 2 + codeuse_distance_support, 
				0
			]){
				cylinder(d = codeuse_roulement_diametre, h = codeuse_roulement_hauteur + 1);
				cylinder(d = codeuse_axe_diametre, h = codeuse_support_hauteur + plaque_epaisseur + 2);
			}

			//roue
			translate([largeur_profile + 4 * plaque_epaisseur + codeuse_profondeur + codeuse_roue_epaisseur, plaque_largeur / 2 - roue_diametre / 2 , 0]){
				cube([roue_largeur, roue_diametre, plaque_epaisseur + 2]);
			}
		}
	}
}