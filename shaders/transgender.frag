#pragma header

// most valid shader ever
void main() {
    vec2 pos = getCamPos(openfl_TextureCoordv);
    gl_FragColor = textureCam(bitmap, pos);
    vec4 markiplier = vec4(1, 1, 1, 1);
    if (pos.y < 0.2 || pos.y > 0.8) {
        markiplier = vec4(91.0 / 255.0, 206.0 / 255.0, 250.0 / 255.0, 1.0);
    } else if (pos.y < 0.4 || pos.y > 0.6) {
        markiplier = vec4(245.0 / 255.0, 169.0 / 255.0, 184.0 / 255.0, 1.0);
    }
    float grayanimates = gl_FragColor.r;
    if (gl_FragColor.g > grayanimates) grayanimates = gl_FragColor.g;
    if (gl_FragColor.b > grayanimates) grayanimates = gl_FragColor.b;
    grayanimates = mix(grayanimates, (gl_FragColor.r + gl_FragColor.g + gl_FragColor.b) / 3, 0.5);
    gl_FragColor.r = (mix(gl_FragColor.r, grayanimates, 2.0 / 3.0) * markiplier.r);
    gl_FragColor.g = (mix(gl_FragColor.g, grayanimates, 2.0 / 3.0) * markiplier.g);
    gl_FragColor.b = (mix(gl_FragColor.b, grayanimates, 2.0 / 3.0) * markiplier.b);
}
