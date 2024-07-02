package rayTracer

// A sphere has 2 properties, one is a Vec3f, which stores the center coordinate of the sphere and the radius 
Sphere :: struct {
	center : Vec3f,
	radius : f32,
	material : Material,
}


// A dynamic array that is holding sphere instances
array_of_Sphere :: [dynamic]Sphere;