package pathtracer

import lg "core:math/linalg"
import "core:io"
import "core:fmt"

Vec3 :: [3]f64;

vec3_zero :: proc() -> Vec3 {
	return Vec3{0,0,0}
}

unit_vec :: proc(vector : Vec3) -> Vec3 {
	return vector / lg.vector_length(vector);
}

// lg.vector_cross3, lg.vector_dot, 
