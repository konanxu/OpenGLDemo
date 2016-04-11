precision highp float;
uniform vec2 uResolution;
uniform float uTime;

float randomNoise(vec2 p) {
    return fract(6791.*sin(47.*p.x+p.y*9973.));
}


//float smoothNoise(vec2 p) {
//    vec2 nn = vec2(p.x, p.y+1.);
//    vec2 ne = vec2(p.x+1., p.y+1.);
//    vec2 ee = vec2(p.x+1., p.y);
//    vec2 se = vec2(p.x+1., p.y-1.);
//    vec2 ss = vec2(p.x, p.y-1.);
//    vec2 sw = vec2(p.x-1., p.y-1.);
//    vec2 ww = vec2(p.x-1., p.y);
//    vec2 nw = vec2(p.x-1., p.y+1.);
//    vec2 cc = vec2(p.x, p.y);
//    
//    float sum = 0.;
//    sum += randomNoise(nn);
//    sum += randomNoise(ne);
//    sum += randomNoise(ee);
//    sum += randomNoise(se);
//    sum += randomNoise(ss);
//    sum += randomNoise(sw);
//    sum += randomNoise(ww);
//    sum += randomNoise(nw);
//    sum += randomNoise(cc);
//    sum /= 9.;
//    
//    return sum;
//}
float smoothNoise(vec2 p) {
    vec2 nn = vec2(p.x, p.y+1.);
    vec2 ee = vec2(p.x+1., p.y);
    vec2 ss = vec2(p.x, p.y-1.);
    vec2 ww = vec2(p.x-1., p.y);
    vec2 cc = vec2(p.x, p.y);
    
    float sum = 0.;
    sum += randomNoise(nn)/8.;
    sum += randomNoise(ee)/8.;
    sum += randomNoise(ss)/8.;
    sum += randomNoise(ww)/8.;
    sum += randomNoise(cc)/2.;
    
    return sum;
}

void main(void) {
    
    
    
//    vec2 position = gl_FragCoord.xy/uResolution.xx;
////    float n = randomNoise(position);
//    
//    
//    float tiles = 128.;
//    position = floor(position*tiles);
//    
//    float n = randomNoise(position-1.);
////    float n = randomNoise(position+1.);
//    if ((position.x>128.) || (position.y>128.)) {
//        discard;
//    }
//    gl_FragColor = vec4(vec3(n), 1.);
    
    vec2 position = gl_FragCoord.xy/uResolution.xx;
    float tiles = 8.;
    position = floor(position*tiles);
    float n = smoothNoise(position);
    gl_FragColor = vec4(vec3(n), 1.);
    
}
