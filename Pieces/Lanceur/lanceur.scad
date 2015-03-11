module init()
{
	disk_diameter = 120;
	disk_thickness = 1.4;
	sphere_diameter = 43;
	ball_shift = 10;
	support_length = (sphere_diameter / 2) + ball_shift - 8;
	support_thickness = 2;
	support_max_dist_from_center = 62;
	hole_diameter = 28;
	sphere_dist_from_center = 44;
	side_ball_lock_distance = sphere_dist_from_center + 30;
	side_ball_lock_thickness = -2;
	sphere_number = 6;

	lanceur_bis(disk_diameter, disk_thickness, hole_diameter, sphere_number, sphere_diameter, sphere_dist_from_center, support_length, support_thickness, support_max_dist_from_center, side_ball_lock_distance, side_ball_lock_thickness, ball_shift);
	//boules(sphere_number, sphere_diameter, sphere_dist_from_center, ball_shift);
}

module lanceur_bis(disk_diameter, disk_thickness, hole_diameter, sphere_number, sphere_diameter, sphere_dist_from_center, support_length, support_thickness, support_max_dist_from_center, side_ball_lock_distance, side_ball_lock_thickness, ball_shift)
{
	union() {
		difference() {
			cylinder(
				d = support_max_dist_from_center,
				h = support_length
			);

			for(i = [0 : sphere_number])
			{
				rotate(i * 360 / sphere_number, [0, 0, 1])
				translate([sphere_dist_from_center, 0, -0.1])
				cylinder(
					d = sphere_diameter,
					h = support_length + 0.2
				);
			}

			difference() {
				cylinder(
					d = support_max_dist_from_center - support_thickness,
					h = support_length + 0.1
				);

				for(i = [0 : sphere_number])
				{
					rotate(i * 360 / sphere_number, [0, 0, 1])
					translate([1 + sphere_dist_from_center - support_thickness, 0, -0.1])
					cylinder(
						d = sphere_diameter,
						h = support_length + 0.2
					);
				}
			}
		}

		difference() {
			cylinder(
				d = disk_diameter,
				h = support_length
			);

			for(i = [0 : 3])
			{
				rotate(i * 360 / 4, [0, 0, 1])
				translate([10, 0, -0.1])
				cylinder(
					d = 1,
					h = disk_thickness + 0.2
				);
			}

			for(i = [0 : sphere_number])
			{
				//rotate(i * 360 / sphere_number, [0, 0, 1])
				//translate([sphere_dist_from_center, 0, 0])
				//sphere(r = hole_diameter);

				rotate(i * 360 / sphere_number, [0, 0, 1])
				translate([sphere_dist_from_center, 0, -0.1])
				cylinder(
					d = hole_diameter,
					h = support_length + 0.2
				);
			}

			difference()
			{
				translate([0, 0, disk_thickness])
				cylinder(
					d = disk_diameter + 0.2,
					h = support_length
				);

				difference()
				{
					translate([0, 0, disk_thickness])
					cylinder(
						r = support_max_dist_from_center,
						h = support_length
					);

					difference()
					{
						translate([0, 0, disk_thickness])
						cylinder(
							r = support_max_dist_from_center,
							h = support_length
						);

						/*for(i = [0 : sphere_number])
						{
							//rotate(i * 360 / sphere_number, [0, 0, 1])
							//translate([sphere_dist_from_center - 5, 0, 0])
							//sphere(r = hole_diameter);

							rotate(i * 360 / sphere_number, [0, 0, 1])
							translate([sphere_dist_from_center - support_thickness, 0, -0.1])
							cylinder(
								d = hole_diameter,
								h = support_length + 0.2
							);
						}*/
					}
				}

				translate([0, 0, disk_thickness])
				difference()
				{
					cylinder(
						d = side_ball_lock_distance,
						h = support_length
					);

					translate([0, 0, -0.1])
					cylinder(
						d = side_ball_lock_distance - side_ball_lock_thickness,
						h = support_length + 0.2
					);
				}
			}

			/*translate([0, 0, disk_thickness])
			cylinder(
				r = sphere_dist_from_center - hole_diameter - 5,
				h = support_length
			);*/

			translate([0, 0, -0.1])
			cylinder(
				d = 2,
				h = support_length + 0.2
			);

			for(i = [0 : sphere_number])
			{
				rotate(i * 360 / sphere_number, [0, 0, 1])
				translate([sphere_dist_from_center, 0, ball_shift])
				sphere(d = sphere_diameter);
			}
		}
	}
}

/*module lanceur(disk_diameter, disk_thickness, hole_diameter, sphere_number, sphere_diameter, sphere_dist_from_center, support_length, support_thickness, support_max_dist_from_center, side_ball_lock_distance, side_ball_lock_thickness, ball_shift)
{
	hole_thickness = disk_thickness + 0.2;
	sphere_diameter = hole_diameter + 3;

	union() {
		difference() {
			cylinder(
				d = disk_diameter,
				h = disk_thickness,
				center = true
			);
			
			for(i = [0 : sphere_number])
			{
				rotate(i * 360 / sphere_number, [0, 0, 1])
				translate([sphere_dist_from_center, 0, -(hole_thickness / 2)])
				cylinder(
					d = hole_diameter,
					h = hole_thickness
				);
			}
		}

		for(i = [0 : sphere_number])
		{
			difference() {
				rotate(i * 360 / sphere_number, [0, 0, 1])
				translate([sphere_dist_from_center, 0, 0])
				cylinder(
					d = hole_diameter + support_thickness,
					h = support_length
				);

				rotate(i * 360 / sphere_number, [0, 0, 1])
				translate([sphere_dist_from_center, 0, -0.1])
				cylinder(
					d = hole_diameter,
					h = support_length + 0.2
				);

				difference() {
					cylinder(
						d = disk_diameter + support_thickness,
						h = support_length,
						center = true
					);

					cylinder(
						d = support_max_dist_from_center,
						h = support_length,
						center = true
					);
				}
			}
		}
	}
}*/

module boules(number, diameter, dist_from_center, shift)
{
	for(i = [0 : number])
	{
		rotate(i * 360 / number, [0, 0, 1])
		translate([dist_from_center, 0, shift])
		sphere(d = diameter);
	}
}

init();
