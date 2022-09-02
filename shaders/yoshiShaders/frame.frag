#pragma header

void main() {
    float dist = openfl_TextureCoordv.x;
    if (openfl_TextureCoordv.y > dist) dist = openfl_TextureCoordv.y;

    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    gl_FragColor = vec4(color.r * dist, color.g * dist, color.b * dist, color.a);
}