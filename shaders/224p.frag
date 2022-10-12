#pragma header

void main() {
    vec2 pos = getCamPos(openfl_TextureCoordv);
    pos = floor(pos * vec2(320, 224)) / vec2(320, 224);
    gl_FragColor = textureCam(bitmap, pos);
}
