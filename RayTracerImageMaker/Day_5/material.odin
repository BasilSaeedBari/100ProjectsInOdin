package rayTracer


// A struct of property Vec3f, which stores the material of a object
Material :: struct {
	refractive_index : f32,
	albedo : Vec4f,
	diffuse_color : Vec3f,
	specular_exponent : f32,
}