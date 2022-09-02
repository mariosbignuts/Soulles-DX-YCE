#pragma header
float diff = 3;

void main() {
    vec2 d = vec2(diff, diff) / openfl_TextureSize;

    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    float a = 1;

    vec4 c1 = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(d.x, 0));
    vec4 c2 = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(-d.x, 0));
    vec4 c3 = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(0, d.y));
    vec4 c4 = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(0, -d.y));
    if (a > c1.a) a = c1.a;
    if (a > c2.a) a = c2.a;
    if (a > c3.a) a = c3.a;
    if (a > c4.a) a = c4.a;

    gl_FragColor = vec4(color.r * a, color.g * a, color.b * a, color.a);
}