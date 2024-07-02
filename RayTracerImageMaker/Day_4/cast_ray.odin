package rayTracer

import "core:fmt"
import "core:math"

// Casting the rays to the sphere
cast_ray :: proc(origin: Vec3f, direction : Vec3f, spheres : array_of_Sphere, lights : ^Lights) -> Vec3f {

	point : Vec3f;
	N : Vec3f;
	material : Material;


	if ( !scene_intersect(origin, direction, spheres, &point, &N, &material)) {
		// If ray doesnt intersect then we will paint the screen a backgrond color
		return Vec3f{0.2, 0.7, 0.8};
	}

	diffuse_light_intensity : f32  = 0.0;
	specular_light_intensity : f32 = 0.0;
	for light_rays in lights {
		lights_direction : Vec3f  = normalize((light_rays.position - point));
		diffuse_light_intensity += (light_rays.intensity * max(0.0, dot_product(lights_direction,N)));
		specular_light_intensity += math.pow_f32( max(0.0, dot_product(-reflect(-lights_direction, N),direction)), material.specular_exponent) * light_rays.intensity;
	}
	// If ray does intersect we will set the pixels to the material of the thing it is intersecting with
	return (material.diffuse_color*diffuse_light_intensity*material.albedo[0]) + (Vec3f{1, 1, 1}*specular_light_intensity*material.albedo[1]);
}

