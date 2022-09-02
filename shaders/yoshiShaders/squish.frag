#pragma header

void main() {
    gl_FragColor = flixel_texture2D(bitmap, vec2(0.5 - ((openfl_TextureCoordv.x - 0.5) / -abs(((openfl_TextureCoordv.y * 2.5) - 0.5)) * 0.5), openfl_TextureCoordv.y));
}