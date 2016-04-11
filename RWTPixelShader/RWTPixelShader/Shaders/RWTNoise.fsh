//
//  RWTNoise.fsh
//  RWTPixelShader
//
//  Created by Ricardo on 3/23/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

// Precision
precision highp float;
uniform vec2 uResolution;
uniform float uTime;

float randomNoise(vec2 p) {
    return fract(6791.*sin(47.*p.x+p.y*9973.));
}
void main(void) {
    
//    float t = uTime/2.;
////    t = 2.75
////    floor(t) = 2.00
////    t = t - floor(t) = 0.75
//    
//    t = fract(t);
//    if (t>1.) {
//        t -= floor(t);
//    }
//    
//    
//    
//    gl_FragColor = vec4(vec3(t), 1.);
    
    
//    
//    vec2 position = gl_FragCoord.xy/uResolution.xy;
//    
//    float pi = 3.14159265359;
////    float wave = sin(2.*pi*position.x);  正弦
////    float wave = sin(4.*2.*pi*(position.x+position.y));
////    float wave = fract(10000.*sin(16.*(position.x+position.y)));
//    float wave = fract(10000.*sin(128.*position.x+1024.*position.y));
//    wave = (wave+1.)/2.;
//    
//    gl_FragColor = vec4(vec3(wave), 1.);
    
    
    
    
    vec2 position = gl_FragCoord.xy/uResolution.xy;
    float n = randomNoise(position);
    gl_FragColor = vec4(vec3(n), 1.);
}

