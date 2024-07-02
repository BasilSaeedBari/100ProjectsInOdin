package rayTracer

import "core:fmt"
import "core:math"

// Casting the rays to the sphere
cast_ray :: proc(origin: Vec3f, direction : Vec3f, spheres : array_of_Sphere, lights : ^Lights, depth : int) -> Vec3f {

	point : Vec3f;
	N : Vec3f;
	material : Material;


	if ( depth > 6 || !scene_intersect(origin, direction, spheres, &point, &N, &material)) {
		// If ray doesnt intersect then we will paint the screen a backgrond color
		return Vec3f{0.2, 0.7, 0.8};
	}

	//Calculating Reflections
	reflect_dir : Vec3f = normalize(reflect(direction, N));
	refract_dir : Vec3f = normalize(refract(direction, N, material.refractive_index));

	reflect_origin : Vec3f = dot_product(reflect_dir, N) < 0 ? (point - N* 1e-3) : (point + N*1e-3);
	refract_orig : Vec3f = dot_product(refract_dir,N) < 0 ? point - N*1e-3 : point + N*1e-3;


	reflect_color := cast_ray(reflect_origin, reflect_dir, spheres, lights, depth + 1);
	refract_color := cast_ray(refract_orig, refract_dir, spheres, lights, depth + 1);


	//Calculating Refractions


	shadow_origin : Vec3f;
	diffuse_light_intensity : f32  = 0.0;
	specular_light_intensity : f32 = 0.0;
	for light_rays in lights {
		lights_direction : Vec3f  = normalize((light_rays.position - point));
		
		light_distance : f32 = norm(light_rays.position - point);

		if dot_product(lights_direction, N) < 0 {
			shadow_origin = (point - (N * 0.0001));
		} else {
			shadow_origin = (point + (N* 0.0001));
		}


		shadow_pt : Vec3f;
		shadow_N : Vec3f;
		tmpmaterial : Material;
		if (scene_intersect(shadow_origin, lights_direction, spheres, &shadow_pt, &shadow_N, &tmpmaterial)) {
			if norm(shadow_pt-shadow_origin) < light_distance {
				continue;
			}

		}

		diffuse_light_intensity += (light_rays.intensity * max(0.0, dot_product(lights_direction,N)));
		specular_light_intensity += math.pow_f32( max(0.0, dot_product(-reflect(-lights_direction, N),direction)), material.specular_exponent) * light_rays.intensity;
	}
	// If ray does intersect we will set the pixels to the material of the thing it is intersecting with
	return (material.diffuse_color*diffuse_light_intensity*material.albedo[0]) + (Vec3f{1, 1, 1}*specular_light_intensity*material.albedo[1]) + reflect_color*material.albedo[2] + refract_color*material.albedo[3];
}

