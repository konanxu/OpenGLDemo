//
//  RWTSphere.fsh
//  RWTPixelShader
//
//  Created by Ricardo on 3/23/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

// Precision
precision highp float;
uniform vec2 uResolution;

void main(void) {
    
    //  圆
    // 1
    vec2 center = vec2(uResolution.x/2., uResolution.y/2.);
    
    // 2
    float radius = uResolution.x/2.;
    
    // 3
    vec2 position = gl_FragCoord.xy - center;
    
    // 4
//    if (length(position) > radius) {
//        gl_FragColor = vec4(vec3(0.), 1.);
//    } else {
//        gl_FragColor = vec4(vec3(1.), 1.);
//    }
    
    float z = sqrt(radius*radius - position.x*position.x - position.y*position.y);
//    z /= radius;    3d
    vec3 normal = normalize(vec3(position.x, position.y, z));  //七彩
    
    if (length(position) > radius) {
        discard;
    }
    
//    gl_FragColor = vec4(vec3(z), 1.);   3d
    gl_FragColor = vec4((normal+1.)/2., 1.);   // 七彩
    
    
    
    
    
    
    /*
    // 圆环
    vec2 center = vec2(uResolution.x/2., uResolution.y/2.);
    float radius = uResolution.x/2.;
    vec2 position = gl_FragCoord.xy - center;
    float thickness = radius/50.;
    
    if ((length(position) > radius) || (length(position) < radius-thickness)) {
        gl_FragColor = vec4(vec3(0.), 1.);
    } else {
        gl_FragColor = vec4(vec3(1.), 1.);
    }
    */
    
    
}
