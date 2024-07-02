package rayTracer

import "core:math"

swap :: proc(x, y: f32) -> (f32, f32) {
	return y, x
}

refract :: proc(Incident : Vec3f, Normal : Vec3f, refrative_index : f32) -> Vec3f {
	cosi : f32 = -max(-1, min(1,dot_product(Incident,Normal)));
	etai : f32 = 1
	etat : f32 = refrative_index;
	n : Vec3f = Normal;
	if cosi < 0 {
		cosi = -cosi;
		etai , etat = swap(etai, etat);
		n = -Normal;
	}
	eta : f32 = etai / etat;
	k : f32 = 1 - eta*eta*(1 - cosi*cosi);
	return k < 0 ? Vec3f{0,0,0} : Incident*eta + n*(eta * cosi - math.sqrt_f32(k));
}