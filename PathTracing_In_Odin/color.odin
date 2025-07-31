package pathtracer

import "core:fmt"
import "core:strings"

write_colour :: proc(string_builder : ^strings.Builder,pixel_color : Vec3) -> string {

	r := pixel_color.x;
	g := pixel_color.y;
	b := pixel_color.z;

	ir := int(255.999 * r);
	ig := int(255.999 * g);
	ib := int(255.999 * b);

	return fmt.sbprintf(string_builder,"%i %i %i \n", ir, ig, ib);
}