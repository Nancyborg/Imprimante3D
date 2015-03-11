offsetx = -4.5;
offsety = -4.5;
diam = 16;
spacex = 18;
spacey = 9;
factor = 0.3;
corps_h = 0;
coeur_h = 3.2;
plaque_h = 2;

diameter = diam * factor;
space_x = spacex * factor + diameter;
space_y = spacey * factor + diameter;

plaque_x = (8 * diam + 8 * spacex) * factor;
plaque_y = (8 * diam + 7 * spacey + spacex) * factor;
plaque_z = plaque_h;

p=[
	[
		[1+offsetx, 4+offsety],
		[2+offsetx, 5+offsety]
	],
	[
		[3+offsetx, 1+offsety],
		[4+offsetx, 8+offsety]
	],
	[
		[5+offsetx, 3+offsety],
		[6+offsetx, 6+offsety]
	],
	[
		[7+offsetx, 2+offsety],
		[8+offsetx, 3+offsety]
	],
	[
		[7+offsetx, 6+offsety],
		[8+offsetx, 7+offsety]
	]
];

points = [[1+offsetx, 4+offsety],
[1+offsetx, 5+offsety],
[3+offsetx, 5+offsety],
[3+offsetx, 8+offsety],
[4+offsetx, 8+offsety],
[4+offsetx, 6+offsety],
[7+offsetx, 6+offsety],
[7+offsetx, 7+offsety],
[8+offsetx, 7+offsety],
[8+offsetx, 6+offsety],
[6+offsetx, 6+offsety],
[6+offsetx, 3+offsety],
[8+offsetx, 3+offsety],
[8+offsetx, 2+offsety],
[7+offsetx, 2+offsety],
[7+offsetx, 3+offsety],
[4+offsetx, 3+offsety],
[4+offsetx, 1+offsety],
[3+offsetx, 1+offsety],
[3+offsetx, 4+offsety]];


rotate([0, 0, -90])
union()
{
	/*translate([-(plaque_x / 2), -(plaque_y / 2), 0])
	cube([plaque_x, plaque_y, plaque_z]);*/
	for(carre = p)
	{
		for(x = [carre[0][0] : carre[1][0]])
		{
			for(y = [carre[0][1] : carre[1][1]])
			{
				translate([x*space_x, y*space_y, plaque_z])
				cylinder(
					$fn = 50,
					d = diameter,
					h = (x == 3+offsetx && y == 5+offsety) ? coeur_h : corps_h
				);
				translate([-x*space_x, -y*space_y, plaque_z])
				cylinder(
					$fn = 50,
					d = diameter,
					h = (x == 3+offsetx && y == 5+offsety) ? 0.01 : corps_h
				);
			}
		}
	}
}

