shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;

uniform float offset : hint_range(0,1,0.01) = 0.5;
uniform int pixel_size : hint_range(1, 64) = 4; // Pixel size
uniform vec2 screen_size = vec2(1920.0, 1080.0); // Screen size (set manually)

void fragment() {
	//Pixel coordinates in screen space
    float pixel_y = floor((FRAGCOORD.y+offset) / float(pixel_size)) * float(pixel_size) - offset;
    // Convert pixel coordinates to UVs for screen texture
    vec2 uv = vec2(FRAGCOORD.x, pixel_y) / screen_size;
    // Get color from texture screen
    COLOR = texture(SCREEN_TEXTURE, uv);
}
