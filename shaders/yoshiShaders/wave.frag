#pragma header

void main() {
    gl_FragColor = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(cos(openfl_TextureCoordv.x * 200) * 0.005, sin(openfl_TextureCoordv.x * 100) * 0.005));
}