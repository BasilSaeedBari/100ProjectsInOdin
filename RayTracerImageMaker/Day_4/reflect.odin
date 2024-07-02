package rayTracer



reflect :: proc(Incidenct : Vec3f, Normal : Vec3f) -> Vec3f {
	return Incidenct - (Normal*2.0* dot_product(Incidenct,Normal));
}