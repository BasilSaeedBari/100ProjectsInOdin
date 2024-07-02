package rayTracer

width :: 1024;
height :: 768;


main :: proc() {

	//Making some materials
	ivory := Material{Vec2f{0.6,0.3},Vec3f{0.4,0.4,0.3}, 50.0};
	red_rubber := Material{Vec2f{0.9,0.1},Vec3f{0.3,0.1,0.1}, 10.0};

	//Making a sphere instance
	sphere1 := Sphere{Vec3f{-3,    0,   -16}, 2, ivory     };
    sphere2 := Sphere{Vec3f{-1.0, -1.5, -12}, 2, red_rubber};
    sphere3 := Sphere{Vec3f{ 1.5, -0.5, -18}, 3, red_rubber};
    sphere4 := Sphere{Vec3f{ 7,    5,   -18}, 4, ivory     };
	
	//Array of Sphere objects
	spheres_array : array_of_Sphere;
	append(&spheres_array, sphere1);
	append(&spheres_array, sphere2);
	append(&spheres_array, sphere3);
	append(&spheres_array, sphere4);


	//Light scoures
	lights_array : Lights;
	append(&lights_array, Light{Vec3f{-20, 20, 20}, 1.5});
	append(&lights_array, Light{Vec3f{30, 50, -25}, 1.8});
	append(&lights_array, Light{Vec3f{30, 20, 30}, 1.7});

	framebuffer := render(spheres_array, &lights_array);

	write_to_file(framebuffer);
}