package pathtracer

Ray :: struct {
	origin : Vec3,
	direction : Vec3, 
}

ray_at :: proc(ray : Ray, t : f64) -> Vec3{
	return ray.origin + (t * ray.direction);
}

ray_color :: proc (ray : Ray) -> Vec3 {
	unit_directon := unit_vec(ray.direction);
	a := 0.5 * (unit_directon.y + 1);
	return (1.0 - a) * Vec3{1,1,1} + a*Vec3{0.5,0.7,1}; 

}