#pragma header

vec2 sqrtNeg(vec2 e) {
    vec2 final = vec2(sqrt(abs(e.x)), sqrt(abs(e.y)));
    if (e.x < 0) final.x *= -1;
    if (e.y < 0) final.y *= -1;
    return final;
}

void main() {
    gl_FragColor = flixel_texture2D(bitmap, sqrtNeg((openfl_TextureCoordv - vec2(0.5, 0.5)) * 2) / 2 + vec2(0.5, 0.5));
}