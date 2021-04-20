precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform float seed;

void main() {
    vec2 coord = gl_FragCoord.xy / resolution;

    // Output RGB color in range from 0.0 to 1.0
    vec3 color = vec3(coord.x, coord.y, 0.0);
    color.z += abs(sin(time));

    // 1. Uncomment these lines to draw triangles
    vec2 squareCoord = 20.0 * gl_FragCoord.xy / resolution.y + vec2(time);
    vec2 loc = fract(squareCoord);

    // 2. Uncomment these lines to invert some of the triangles
    vec2 cell = squareCoord - loc;
    if (mod(2.0 * cell.x + cell.y, floor(seed * 20.0)) == 1.0) {
        color = vec3(smoothstep(-0.05, 0.05, sqrt(pow(loc.x - 0.5, 2.0) + pow(loc.y - 0.5, 2.0)) - 0.5));
    }
    else {
        color = vec3(smoothstep(-0.05, 0.05, loc.x - loc.y));
    }

    // 3. Uncomment these lines to produce interesting colors
    float r = mod(3.0 * cell.x + 2.0 * cell.y, 7.0) / 7.0;
    float g = mod(4.0 * cell.x + cell.y, 7.0) / 7.0;
    float b = mod(4.0 * cell.x + 6.0 * cell.y, 7.0) / 7.0;
    color = 1.0 - (1.0 - color) * vec3(r, g, b);

    // 4. Uncomment to lighten the colors
    color = sqrt(color);

    gl_FragColor = vec4(color, 1.0);
}
