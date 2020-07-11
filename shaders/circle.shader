shader_type canvas_item;

const float pi = 3.1415926535897932384626433832795;

float Circle(vec2 uv, vec2 p, float r, float blur)
{
	float d = length(uv-p);
	float c = smoothstep(r, r-blur, d);
	
	return c;
}

float DashedCircle(vec2 uv, vec2 p, float r, float blur)
{
	vec2 x_axis = vec2(1.0, 0.0);
	float d = length(uv-p);
	float c = smoothstep(r, r-blur, d);
	
	vec2 point_angle_from_center = normalize(uv - p);
	int angle = int(acos(dot(x_axis, point_angle_from_center)));
	if(angle % 20 < 2) c=float(angle);
	//c=float(angle);
	return c;
}

void fragment(){
	vec2 coord = UV * 1.;
	vec2 p = vec2(0.5, 0.5);
	float circle = DashedCircle(coord, p, 0.48, 0.0);
	//float outline_circle = Circle(coord, p, 0.5, 0.0);
	//float dashed_circle = DashedCircle(coord, p, 0.5, 0.0);
	
	//circle = circle - outline_circle;
	
	vec3 color = vec3(1.0, 1.0, 1.0);
	
	COLOR = vec4(color, circle * 1.0);
}