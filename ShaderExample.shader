shader_type canvas_item;

uniform float timeFactor = 0.1;
uniform vec2 amplitude = vec2(10.0, 5.0); 

void vertex() {
	VERTEX.x += cos(TIME * timeFactor + VERTEX.x + VERTEX.y) * amplitude.x;
	VERTEX.y += sin(TIME + VERTEX.y + VERTEX.x) * amplitude.y;
}