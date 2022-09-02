#pragma header

float multiplier = 0.5;
void main() {
    
    // vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);

    float dist = abs(openfl_TextureCoordv.x - 0.5);
    if (abs(openfl_TextureCoordv.y - 0.5) < abs(openfl_TextureCoordv.y - 0.5))
        dist = abs(openfl_TextureCoordv.y - 0.5);
    
    float angle = atan(openfl_TextureCoordv.y - 0.5, openfl_TextureCoordv.x - 0.5);

    gl_FragColor = flixel_texture2D(bitmap, vec2(0.5 + cos(angle) * dist * 3, 0.5 + sin(angle) * dist * 3));
}