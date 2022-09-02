#pragma header

float diff = 5;
uniform vec4 cuttingEdge = vec4(0, 0, 1, 1);

vec4 flixel_texture2D_safe(sampler2D bitmap, vec2 pos) {
    if (pos.x < 0. || pos.x > 1. || pos.y < 0. || pos.x < 0.)
        return vec4(0, 0, 0, 0);
    else
        return flixel_texture2D(bitmap, pos);
}

void main() {
    vec2 d = vec2(diff, diff) / openfl_TextureSize;

    vec2 newPos = vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y);
    newPos.x -= cuttingEdge.x + (cuttingEdge.z / 2);
    newPos.x *= 1 + d.x;
    newPos.y -= cuttingEdge.y + (cuttingEdge.w / 2);
    newPos.y *= 1 + d.y;
    newPos.x += cuttingEdge.x + (cuttingEdge.z / 2);
    newPos.y += cuttingEdge.y + (cuttingEdge.w / 2);

    vec4 color = flixel_texture2D_safe(bitmap, newPos);
    float a = 0;

    for(int x = -int(diff); x < int(diff); ++x) {
        for(int y = -int(diff); y < int(diff); ++y) {
            vec4 c1 = flixel_texture2D_safe(bitmap, newPos + vec2(x / openfl_TextureSize.x, y / openfl_TextureSize.y));
            if (a < c1.a) a = c1.a;
        }
    }

    gl_FragColor = vec4(color.r * a, color.g * a, color.b * a, a);
}