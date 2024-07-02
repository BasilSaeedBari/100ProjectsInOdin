package rayTracer

width :: 1024;
height :: 768;


main :: proc() {

	//Making some materials
	ivory := Material{1, Vec4f{0.6, 0.3, 0.1, 0.0},Vec3f{0.4,0.4,0.3}, 50.0};
	glass := Material{1.5, Vec4f{0.0,  0.5, 0.1, 0.8}, Vec3f{}, 125.0}
	red_rubber := Material{1, Vec4f{0.9, 0.1, 0.0, 0.0},Vec3f{0.3,0.1,0.1}, 10.0};
	mirror := Material{1, Vec4f{0.0, 10.0, 0.8, 0.0}, Vec3f{1,1,1}, 1524.0};

	//Making a sphere instance
	sphere1 := Sphere{Vec3f{-3,    0,   -16}, 2, ivory     };
    sphere2 := Sphere{Vec3f{-1.0, -1.5, -12}, 2, glass     };
    sphere3 := Sphere{Vec3f{ 1.5, -0.5, -18}, 3, red_rubber};
    sphere4 := Sphere{Vec3f{ 7,    5,   -18}, 4, mirror    };
	
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