package ignore_karo

import "core:fmt"
import "core:os"
import "core:io"
import "core:math"
import "core:strings"

render :: proc() {
	width : int : 1024; // Intialize the width of the photo
	height : int : 768; // Initialize the height of the photo 

	Vec3f :: [3]f32;

	framebuffer := make([]Vec3f, width*height); // Making an array of the vector 3 struct, of size width*height



	//Initializing values of the framebuffer
	for j in 0..<height  {
		for i in 0..<width {
			framebuffer[i+j*width] = Vec3f{f32(j)/f32(height), f32(i)/f32(width), f32(0)};
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
			data_to_append := u8(math.floor((255 * max(0.0, min(1.0, framebuffer[i][j])))));
			//fmt.printfln("%v", data_to_append);
			strings.write_byte(&builder, data_to_append);
		}
	}

	final_string := strings.to_string(builder); // build the buffer into one long string
	fmt.wprintf(writer, "%v", final_string); // Write the final string to the file
	os.close(outputfile); //Close the file
	io.destroy(stream); // Destroy the stream to save memory

}


main :: proc() {
	render();
}