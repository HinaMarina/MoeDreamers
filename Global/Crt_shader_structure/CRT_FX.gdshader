//---CRT Shader---
shader_type canvas_item;

uniform float chromatic_aberration_ratio = 1;
uniform bool chromatic_aberration = true;
uniform bool enable_grain = false;
uniform bool rgb_grid = true;
uniform bool vignette = true;
uniform float vignette_size: hint_range(0.1, 10.0, 0.1) = 0.2;
uniform float vignette_smoothness: hint_range(0.05, 5.0, 0.05) = 0.1;
uniform int rgb_grid_subdivision = 3;
uniform float scanline_count : hint_range(0, 1800) = 240.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

float filmGrainNoise(in float time, in vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233) * time)) * 43758.5453);
}

vec2 uv_curve(vec2 uv)
{

	return uv;
}


void fragment()

{

	float r = texture(SCREEN_TEXTURE, uv_curve(SCREEN_UV) + vec2(SCREEN_PIXEL_SIZE.x*chromatic_aberration_ratio), 0.0).r;
	float g = texture(SCREEN_TEXTURE, uv_curve(SCREEN_UV) + vec2(SCREEN_PIXEL_SIZE.x*chromatic_aberration_ratio), 0.0).g;
	float b = texture(SCREEN_TEXTURE, uv_curve(SCREEN_UV) + vec2(SCREEN_PIXEL_SIZE.x*-chromatic_aberration_ratio), 0.0).b;
	vec4 color = texture(screen_texture, SCREEN_UV);
	if (chromatic_aberration){
		color.rgb = vec3(r,g,b);
	}
	if(enable_grain)
	{
		color.rgb = mix(vec3(r,g,b) ,vec3(0.0), filmGrainNoise(TIME, SCREEN_UV) * 0.05 );
	}
	if(rgb_grid)
	{
		float a;
		float x;
		float y;
		int rgbIndex = int(FRAGCOORD.x) % rgb_grid_subdivision;
		if(rgbIndex == 0)
			a = 1.;
		else
			a = 0.7;
		if(rgbIndex == 1)
			x = 1.;
		else
			x = 0.7;
		if(rgbIndex == 2)
			y = 1. ;
		else
			y = 0.7;
		vec3 mask = vec3(a,x,y);
		color.rgb *= 1.4*mask;
		}
	float s = sin(uv_curve(SCREEN_UV).y * scanline_count * PI * 2.0);
	s = (s * 0.5 + 0.5) * 0.9 + 0.1;
	vec4 scan_line = vec4(vec3(pow(s, 0.25)), 1.0);

		if(vignette)
	{
		vec2 uv = SCREEN_UV;
		uv *=  1.0 - uv.yx;
		float vig = uv.x*uv.y / vignette_size * 1000.0;
		vig = pow(vig, 1.0/vignette_smoothness);
		color.rgb -= 1.0-(clamp(vig,0,1));
	}

	COLOR = vec4(color.r,color.g,color.b, 1.0) * scan_line;
}