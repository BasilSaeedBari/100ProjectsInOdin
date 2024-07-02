package rayTracer

import "core:math"


render :: proc(sphere_instances : array_of_Sphere, lights : ^Lights) -> []Vec3f {
	fov : f32 = f32(math.PI / 3.0); // Setting the Fov

	framebuffer := make([]Vec3f, width*height); // Making an array of the vector 3 struct, of size width*height

	Origin : Vec3f = Vec3f{0,0,0}; // Setting the origin 

	// Understand this part
	for j in 0..<height {
		for i in 0..<width {
			x : f32 = (2*(f32(i) + 0.5)/f32(width)  - 1)* math.tan(fov/2.)* f32(width)/f32(height);
			y : f32 = -(2*(f32(j) + 0.5)/f32(height) - 1)* math.tan(fov/2.);
			dir : Vec3f = normalize(Vec3f{x, y, -1});
			framebuffer[i+j*width] = cast_ray(Origin, dir, sphere_instances, lights, 0);
		}
	}
	return framebuffer;
}
