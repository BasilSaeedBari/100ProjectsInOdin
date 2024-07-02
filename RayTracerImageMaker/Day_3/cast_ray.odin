package rayTracer



// Casting the rays to the sphere
cast_ray :: proc(origin: Vec3f, direction : Vec3f, spheres : array_of_Sphere) -> Vec3f {

	point : Vec3f;
	N : Vec3f;
	material : Material;


	if ( !scene_intersect(origin, direction, spheres, &point, &N, &material)) {
		// If ray doesnt intersect then we will paint the screen a backgrond color
		return Vec3f{0.2, 0.7, 0.8};
	}
	// If ray does intersect we will set the pixels to the material of the thing it is intersecting with
	return material.diffuse_color;
}

