#pragma header

float r(float v) {
    // round
    return floor(v) + (mod(v, 1) >= 0.5 ? 1 : 0);
}
void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    color.r = r(color.r * 4.0) / 4.0;
    color.g = r(color.g * 4.0) / 4.0;
    color.b = r(color.b * 4.0) / 4.0;
    gl_FragColor = color;
}