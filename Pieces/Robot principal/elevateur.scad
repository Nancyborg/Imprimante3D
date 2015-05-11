largeur_plaque=128;
longeur_plaque=20;
epaiseur_plaque=5;
hauteur_tube=20;
diam_int_tube=65;
diam_ext_tube=diam_int_tube + 4;
distance_trou_moteur=15;
diam_trou_moteur=2;

difference(){
    union(){
        //plaque
        cube([largeur_plaque, longeur_plaque, epaiseur_plaque], center=false);
        
        //cylindre
        translate([largeur_plaque /2, diam_ext_tube / 2 + longeur_plaque-2, epaiseur_plaque]){
            cylinder(h=longeur_plaque, d=diam_ext_tube, center=false);
        }

        //support roulement 1
        translate([0, longeur_plaque / 2 - (8+4) / 2, epaiseur_plaque]){
            cube([8+4, 8+4, 7], center=false);
        }

        //support roulement 1
        translate([largeur_plaque - (8+4), longeur_plaque / 2 - (8+4) / 2, epaiseur_plaque]){
            cube([8+4, 8+4, 7], center=false);
        }
            
        polyhedron(
            points = [
                [largeur_plaque / 2 - 1, 0, epaiseur_plaque - 1],
                [largeur_plaque / 2 + 1, 0, epaiseur_plaque - 1],
                [largeur_plaque / 2 - 1, longeur_plaque, epaiseur_plaque - 1],
                [largeur_plaque / 2 + 1, longeur_plaque, epaiseur_plaque - 1],
                [largeur_plaque / 2 - 1, longeur_plaque, epaiseur_plaque + hauteur_tube - 1],
                [largeur_plaque / 2 + 1, longeur_plaque, epaiseur_plaque + hauteur_tube - 1]
            ], faces = [
                  [1,0,4,5], [0, 1, 3, 2], [2, 3, 5, 4], [5,3,1], [0,2,4]
            ]
        );
    }
    union(){
        translate([0, 0, -1]){
            //trous moteur 1
            translate([16, 4, 0]){
                cylinder(h=epaiseur_plaque+2, d=diam_trou_moteur, center=false);
            }
            translate([distance_trou_moteur + 16, 4, 0]){
                cylinder(h=epaiseur_plaque+2, d=diam_trou_moteur, center=false);
            }
            
            //trous moteur 2
            translate([largeur_plaque - 16, 4, 0]){
                cylinder(h=epaiseur_plaque+2, d=diam_trou_moteur, center=false);
            }
            translate([largeur_plaque - (distance_trou_moteur + 16), 4, 0]){
                cylinder(h=epaiseur_plaque+2, d=diam_trou_moteur, center=false);
            }

            //trou roulement 1
            translate([2 + 8 / 2, longeur_plaque/2, 0]){
                cylinder(h=epaiseur_plaque+7+2, d=8, center=false);
            }

            //trou roulement 
            translate([largeur_plaque - (2 + 8 / 2), longeur_plaque/2, 0]){
                cylinder(h=epaiseur_plaque+7+2, d=8, center=false);
            }
            
            //trou cylindre
            translate([largeur_plaque /2, diam_ext_tube / 2 + longeur_plaque-2, epaiseur_plaque]){
                cylinder(h=hauteur_tube + 5, d=diam_int_tube, center=false);
            }
        
            // coupure cylindre
            translate([0, longeur_plaque + 5, 0]){
                cube([largeur_plaque, diam_ext_tube, longeur_plaque + 5 + 2], center=false);
            }
        }
    }
}