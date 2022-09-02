#pragma header

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

float lerp(float a, float b, float lerp) {
    return (a + ((b - a) * lerp));
}

void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    vec3 hsv = rgb2hsv(vec3(color.r, color.g, color.b));
    hsv.r = lerp(hsv.r, 0, sqrt(pow((openfl_TextureCoordv.x - 0.5) * 2, 2) + pow((openfl_TextureCoordv.y - 0.5) * 2, 2)));
    vec3 rgbColor = hsv2rgb(hsv);
    gl_FragColor = vec4(rgbColor.x, rgbColor.y, rgbColor.z, color.a);
}