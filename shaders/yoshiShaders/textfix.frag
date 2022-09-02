#pragma header

int passes = 5;
float round(float v1, float v2) {
    
    return floor(v1) + ((mod(v1, 1.0) >= v2) ? 1 : 0);
}

void main() {
    vec2 dist = 0.5 / openfl_TextureSize;
    float r = 0;
    float g = 0;
    float b = 0;
    float a = 0;
    float am = 0;

    for(int i = -passes; i < passes; ++i) {
        for(int i2 = -passes; i2 < passes; ++i2) {
            vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(i / passes * dist.x, i2 / passes * dist.y));
            r += color.r * color.r;
            g += color.g * color.g;
            b += color.b * color.b;
            a += color.a * color.a;
            am += 0.25 + (pow((color.r + color.g + color.b) / 3, 2) * 0.75);
        }   
    }

    if (am == 0) {
        gl_FragColor = vec4(0, 0, 0, round(a, 0.25));
    } else {
        gl_FragColor = vec4(r / am, g / am, b / am, round(a / am, 0.25));
    }
}

