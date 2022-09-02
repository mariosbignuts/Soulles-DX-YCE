#pragma header

bool inRange(float n, float min, float max) {
    return n < max && n > min;
}

void main() {
    if (inRange(openfl_TextureCoordv.x, 0, 0.05) || inRange(openfl_TextureCoordv.x, 0.95, 1) || inRange(openfl_TextureCoordv.y, 0, 0.05) || inRange(openfl_TextureCoordv.y, 0.95, 1))
        gl_FragColor = vec4(1, 0, 0, 1);
    else
        gl_FragColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
}