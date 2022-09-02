#pragma header

void main() {
    gl_FragColor = texture2D(bitmap, openfl_TextureCoordv);
    if (gl_FragColor.a > 0.0 && gl_FragColor.a < 1.0) {
        gl_FragColor = vec4(
            mix(1.0, gl_FragColor.r, gl_FragColor.a),
            mix(1.0, gl_FragColor.g, gl_FragColor.a),
            mix(1.0, gl_FragColor.b, gl_FragColor.a),
            1);
    }
}