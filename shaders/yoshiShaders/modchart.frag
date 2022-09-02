#pragma header

void main() {
    vec2 camPos = getCamPos(openfl_TextureCoordv);
    gl_FragColor = textureCam(bitmap, vec2(((camPos.x - 0.5) * (1 - sin(camPos.y * 3.14) * 0.5)) + 0.5, camPos.y));
}