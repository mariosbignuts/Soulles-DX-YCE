#pragma header

float quadInOut(float t)
{
    return t <= .5 ? t * t * 2 : 1 - (--t) * t * 2;
}

void main() {
    // gl_FragColor = flixel_texture2D(bitmap, sqrtNeg((openfl_TextureCoordv - vec2(0.5, 0.5)) * 2) / 2 + vec2(0.5, 0.5));
    gl_FragColor = flixel_texture2D(bitmap, vec2(quadInOut(openfl_TextureCoordv.x), quadInOut(openfl_TextureCoordv.y)));
}