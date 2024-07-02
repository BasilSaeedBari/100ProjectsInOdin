package rayTracer

import "core:math"

// Checking if the sphere intersects with a ray, if so it will return true, otherwise false.
ray_intersect :: proc(spheres : Sphere, origin : Vec3f, direction : Vec3f, IntersectionDistance : ^f32) -> bool {

	// Finding the center of the sphere in 3-Dimensional Space
	vecterToCenterOfSphere : Vec3f = spheres.center - origin;

	// Finding the shortest distance between Sphere center and ray Vector - THIS IS A DOT PRODUCT
	distanceToClosestPoint : f32 = dot_product(vecterToCenterOfSphere, direction);

	// Finding the squared distance between source of ray, and the center of the sphere, foot of the perpendicular squared - THE DOT PRODUCT OF THE SAME VECTOR IS EQUAL TO THE SQUARE MAGNITUDE OF THE SAME VECTOR
	squaredDistanceToCenter : f32 = dot_product(vecterToCenterOfSphere, vecterToCenterOfSphere) - distanceToClosestPoint*distanceToClosestPoint;

	// Checking if the distance from the foot of the perpendicular squared is greater than the squared radius of the spehre, to determine if the ray is intersecting with the sphere or not 
	if (squaredDistanceToCenter > spheres.radius * spheres.radius) {
		// If the distance is greater, it does not intersect
		return false;
	}

	// In the case of intersection, we will find the distance of the ray from the surface
	distanceToSurface := math.sqrt( (spheres.radius * spheres.radius) - squaredDistanceToCenter);

	// Finding the distance from the origin to the intersection point
	IntersectionDistance^ = distanceToClosestPoint - distanceToSurface;

	// In the case of having two intersections points, finding the alternative intersection point
	alternativeIntersectionDistance := distanceToClosestPoint + distanceToSurface;

	// In case Intersection distrance is less than one, meaning it is behind the rays origin, we will set it to the alternative point
	if IntersectionDistance^ < 0 {
		IntersectionDistance^ = alternativeIntersectionDistance;
	}

	// If the alternative intersection is also behind the rays origin, we will consider the ray is not intersecting the sphere
	if IntersectionDistance^ < 0 {
		return false;
	}

	// Else return true, meaning the ray does intersect on this point
	return true;

}
