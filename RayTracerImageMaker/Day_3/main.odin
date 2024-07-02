package rayTracer

width :: 1024;
height :: 768;


main :: proc() {

	//Making some materials
	ivory := Material{Vec3f{0.4,0.4,0.3}};
	red_rubber := Material{Vec3f{0.3,0.1,0.1}};

	//Making a sphere instance
	sphere1 := Sphere{Vec3f{-3,    0,   -16}, 2, ivory     };
    sphere2 := Sphere{Vec3f{-1.0, -1.5, -12}, 2, red_rubber};
    sphere3 := Sphere{Vec3f{ 1.5, -0.5, -18}, 3, red_rubber};
    sphere4 := Sphere{Vec3f{ 7,    5,   -18}, 4, ivory     };
	
	spheres_array : array_of_Sphere;
	append(&spheres_array, sphere1);
	append(&spheres_array, sphere2);
	append(&spheres_array, sphere3);
	append(&spheres_array, sphere4);

	framebuffer := render(spheres_array);

	write_to_file(framebuffer);
}