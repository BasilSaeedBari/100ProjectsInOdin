package rayTracer

import "core:fmt"
import "core:os"
import "core:io"
import "core:math"
import "core:strings"

render :: proc(sphere_instance : Sphere) {
	width : int : 1024; // Intialize the width of the photo
	height : int : 768; // Initialize the height of the photo 
	fov : f32 = f32(math.PI / 3.0); // Setting the Fov

	framebuffer := make([]Vec3f, width*height); // Making an array of the vector 3 struct, of size width*height

	Origin : Vec3f = Vec3f{0,0,0}; // Setting the origin 

	// Understand this part
	for j in 0..<height {
		for i in 0..<width {
			x : f32 = (2*(f32(i) + 0.5)/f32(width)  - 1)* math.tan(fov/2.)* f32(width)/f32(height);
			y : f32 = -(2*(f32(j) + 0.5)/f32(height) - 1)* math.tan(fov/2.);
			dir : Vec3f = normalize(Vec3f{x, y, -1});
			framebuffer[i+j*width] = cast_ray(Origin, dir, sphere_instance);
		}
	}

	//Creating a new file
	outputfile, error := os.open("image.ppm", os.O_CREATE); // file name = image.ppm, mode = os.O_CREATE, this means that it will create a new file in case no file is found 
	fmt.printfln("Error: %v", error); // Checking if any Error was made
	stream := os.stream_from_handle(outputfile) //Changing the handle into a stream
	writer := io.Writer(stream) // casting that stream into a writer
	fmt.wprintf(writer, "P6\n%v %v\n255\n", width, height);
	
	builder := strings.builder_make(); // Making a stirng buffer that will increase in size  
	
	// Clamping all the values between 0 and 1, then scalling all the values to 0 and 255
	for i in 0..<height*width {
		for j in 0..<3 {

			//Converting the new calculauted value to a byte, so it can be written in byte format
			data_to_append := u8(math.floor((255 * framebuffer[i][j])));
			strings.write_byte(&builder, data_to_append);
		}
	}

	final_string := strings.to_string(builder); // build the buffer into one long string
	fmt.wprintf(writer, "%v", final_string); // Write the final string to the file
	os.close(outputfile); //Close the file
	io.destroy(stream); // Destroy the stream to save memory

}


// Casting the rays to the sphere
cast_ray :: proc(origin: Vec3f, direction : Vec3f, spheres : Sphere) -> Vec3f {
	sphere_distance : f32 = max(f32); // Dont know what this line does
	if ( !ray_intersect(spheres, origin, direction, &sphere_distance)) {
		// If ray doesnt intersect then we will paint the screen blue
		return Vec3f{0.2, 0.7, 0.8};
	}
	// If ray does intersect we will set the pixels to greenish colour
	return Vec3f{0.4, 0.4, 0.3};
}


main :: proc() {
	//Making a sphere instance 
	sphere1 : Sphere;
	sphere1.center = Vec3f{-3, 0, -16};
	sphere1.radius = 2.0;
	render(sphere1);
}