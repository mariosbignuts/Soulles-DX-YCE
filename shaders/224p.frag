#pragma header

void main() {
    vec2 pos = getCamPos(openfl_TextureCoordv);
    pos = floor(pos * vec2(192, 144)) / vec2(192, 144);
    gl_FragColor = textureCam(bitmap, pos);
}
