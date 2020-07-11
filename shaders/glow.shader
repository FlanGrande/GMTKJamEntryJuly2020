shader_type canvas_item;

float Circle(vec2 uv, vec2 p, float r, float blur)
{
    float d = length(uv-p);
    float c = smoothstep(r, r-blur, d);
    
    return c;
}

void fragment(){
	vec2 coord = UV * 1.;
	vec2 p = vec2(0.5, 0.5);
	float circle = Circle(coord, p, 0.5, sin(TIME * .5) + 0.5 * 4.5416);
	
	vec3 color = vec3(1.0, 0.0, 0.0);
	
	COLOR = vec4(color, circle * 3.);
}