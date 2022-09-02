#pragma header

void main() {
    vec2 camPos = getCamPos(openfl_TextureCoordv);
    gl_FragColor = textureCam(bitmap, vec2(((camPos.x - 0.5) * (1.5 * (1 - camPos.y))) + 0.5, camPos.y));
}
