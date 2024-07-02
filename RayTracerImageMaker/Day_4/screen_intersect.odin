package rayTracer

scene_intersect :: proc(Origin : Vec3f, ray_direction : Vec3f, array_of_spheres : array_of_Sphere, hit : ^Vec3f, Normal_Vector : ^Vec3f, material: ^Material) -> bool {
	
	// Hit variable stores the point in 3D spcae where the ray of light interects with the spheres
	// Whenever a intersection is found, the hit variable is updated to the new position of intersection
	// The normal vector is just a vector that is telling us normal to the hit vector, this can be used in the future to find the reflection, the amount of light reflected

	spheres_distance := max(f32);
	for spheres in array_of_spheres {
		dist_i : f32;
		if (ray_intersect(spheres, Origin, ray_direction, &dist_i)) && dist_i < spheres_distance {
			spheres_distance = dist_i;
			hit^ = Origin + ray_direction * dist_i;
			Normal_Vector^ = normalize(hit^ - spheres.center);
			material^ = spheres.material; 
		}
	}
	// 1000 is just an arbritrary value that makes sure that we dont trevese to far in the scene, changing this is like changing the view distane.
	return spheres_distance < 1000;
}