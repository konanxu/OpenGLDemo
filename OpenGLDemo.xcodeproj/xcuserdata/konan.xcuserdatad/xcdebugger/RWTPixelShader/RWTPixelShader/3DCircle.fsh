



precision highp float;
uniform vec2 uResolution;
const vec3 cLight = normalize(vec3(.5, .5, 1.));
void main(void) {
    
    vec2 center = vec2(uResolution.x/2., uResolution.y/2.);
    
    // 2
    float radius = uResolution.x/2.;
    
    // 3
    vec2 position = gl_FragCoord.xy - center;
    
    float z = sqrt(radius*radius - position.x*position.x - position.y*position.y);
    vec3 normal = normalize(vec3(position.x, position.y, z));
    if (length(position) > radius) {
        discard;
    }
    
    float diffuse = max(0., dot(normal, cLight));
    
    gl_FragColor = vec4(vec3(diffuse), 1.);
   
    
}