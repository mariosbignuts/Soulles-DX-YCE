#pragma header

uniform float time;
uniform sampler2D donkey;
// CHANGE VALUE HERE!!!
int imageSize = 40;
void main() {

    float max = imageSize * 2;
    vec2 camPos = getCamPos(openfl_TextureCoordv);
    camPos.x = 1-camPos.x;
    camPos.y = 1-camPos.y;
    camPos.x -= 0.5;
    camPos.x = mix(camPos.x, camPos.x / sqrt(1 + (sin(time) * (1 - camPos.y))), 0.5 + (sin(time) * 0.5));
    camPos.x += 0.5;
    camPos -= vec2(0.5, 0.5);
    vec2 newPos = vec2(-sin(time) * camPos.x, cos(time) * camPos.x);
    newPos += vec2(-sin(time + (3.14 / 2)) * camPos.y, cos(time + (3.14 / 2)) * camPos.y);
    newPos += vec2(0.5, 0.5);
    newPos.x *= (imageSize + 1) + (sin(time) * imageSize);
    newPos.y *= (imageSize + 1) + (sin(time) * imageSize);
    newPos.y = newPos.y + (sin(time));
    newPos.x = newPos.x + (cos(time));
    float mulX = mod(floor(newPos.x) / max, 1);
    float mulY = mod(floor(newPos.y) / max, 1);
    newPos = vec2(1, 1) - mod(newPos, 1);
    gl_FragColor = textureCam(bitmap, newPos);
    float r = gl_FragColor.r;
    float g = gl_FragColor.g;
    float b = gl_FragColor.b;
    float a = gl_FragColor.a;
    gl_FragColor *= flixel_texture2D(donkey, abs(vec2(mulX, mulY)));
}
