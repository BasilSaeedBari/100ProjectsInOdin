package pathtracer


import "core:fmt"
import "core:os"
import "core:strings"


main :: proc() {

	// Setting the aspect ratio
	aspect_ratio : f64 = 16.0/9.0;
	
	// Calculating the image height, and ensuring that its at least 1. Image width is set by us.
	image_width : int = 400;
	image_height : int = int(f64(image_width)/aspect_ratio);
	image_height = 1 if (image_height < 1) else image_height;


	// Camera
	focal_length : f64 = 1;
	viewport_height : f64 = 2;
	viewport_width : f64 = viewport_height * f64(image_width/image_height);
	camera_center := Vec3{0,0,0};

	// Calculate the vectors across the horizontal and down the vertical view-port edges
	viewport_u := Vec3{viewport_width, 0,0}; 
	viewport_v := Vec3{0, -viewport_height, 0};

	// Calculating the horizontal and vertical delta vectors from pixel to pixel. This will allow us to go from one pixels center to another pixels center.
	pixel_delta_u : Vec3 = viewport_u/f64(image_width);
	pixel_delta_v : Vec3 = viewport_v/f64(image_height);

	// Now as our Camera's perspective is starting from the bottom left corner of the screen in terms of Y axis, while in the code, we are going down the screen, to go upwards, our screen is inverted. So we need to figure out a way to find the upper left pixel, the starting pixel, from the perspective of the camera.
	viewport_upper_left := camera_center - Vec3{0,0,focal_length} - viewport_u/2 - viewport_v/2;
	pixel00_loc := viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v);

	// I need a buffer to store all the PPM data, that after once complete, ill just call it write to file. Hence 1 IO operation is done.
	string_builder : strings.Builder;
	
	// Rendering the PPM file.
	fmt.sbprintf(&string_builder,"P3\n%i %i\n255\n", image_width, image_height);

	for j : int = 0; j < image_height; j += 1 {
        fmt.printfln("Scan-lines remaining: %i", image_height - j);
		for i: int = 0; i < image_width; i += 1 {

			// Now we find the center of the pixel we are trying to render, and then find the direction of the ray from the center of our camera to the pixel center. Then we create a ray with those two elements
			pixel_center := pixel00_loc + (f64(i) * pixel_delta_u) + (f64(j) * pixel_delta_v);
			ray_direction := pixel_center - camera_center;

			r := Ray{camera_center, ray_direction}


			pixel_color := ray_color(r);
			// pixel_color := Vec3{
			// 	f64(i) / f64(image_width-1),
			// 	f64(j) / f64(image_width-1),
			// 	0.0,
			// };

			write_colour(&string_builder, pixel_color);
		}
	}
	fmt.println("Done !");
	// Type casting a builder to a string, and then changing that string to a series of bytes in u8 type and then writing to a new file. 
	// For those wondering what transmute is, its just a way of reinterpretation of memory, it has zero runtime cost, and its really effective. 
	writing_to_file_success := os.write_entire_file("image.ppm", transmute([]byte)(strings.to_string(string_builder)));
	_ = fmt.println("Error writing to file!") if !writing_to_file_success else fmt.println("Written to File without and errors !");
}