package rayTracer

import "core:math"

Vec4f :: [4]f32;
Vec3f :: [3]f32;
Vec2f :: [2]f32;

dot_product :: proc (firstVector : Vec3f, secondVector : Vec3f) -> f32 {
	return (firstVector[0]*secondVector[0] + firstVector[1]*secondVector[1] + firstVector[2]*secondVector[2] ); 
}

normalize :: proc (vector : Vec3f) -> Vec3f {
	// The dot product of the same vector gives the square of the magnitude
	// math.sqrt gives the magnitude
	magnitude := math.sqrt(dot_product(vector, vector));

	return vector/magnitude;
}

norm :: proc(vector : Vec3f) -> f32 {

	return math.pow(dot_product(vector, vector), 0.5);

}