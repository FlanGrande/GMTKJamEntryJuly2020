shader_type canvas_item;

uniform float red = 24.0;
uniform float green = 24.0;
uniform float blue = 24.0;

void fragment()
{
	float r = red / 255.0 - sin(TIME*6.)-0.5;
	float g = green / 255.0 - sin(TIME*6.)-0.5;
	float b = blue / 255.0 - sin(TIME*6.)-0.5;
	
	COLOR = vec4(r, g, b, 1.);
}