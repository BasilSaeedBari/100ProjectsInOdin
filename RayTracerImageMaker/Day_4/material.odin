package rayTracer


// A struct of property Vec3f, which stores the material of a object
Material :: struct {
	albedo : Vec2f,
	diffuse_color : Vec3f,
	specular_exponent : f32,
}