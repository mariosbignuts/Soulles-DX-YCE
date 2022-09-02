#pragma header

void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    gl_FragColor = vec4(color.r, color.g, color.b, 1.0 - color.a);
}