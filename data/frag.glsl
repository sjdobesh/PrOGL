#define PROCESSING_COLOR_SHADER
#ifdef GL_ES
precision highp float;
#endif

// uniforms
uniform float time;
uniform vec3 mouse;
uniform vec2 resolution;

const float scale = 3.1;


void main() {
  // normalize
  float t = time;
  vec2 m = (mouse.xy/resolution.xy);
  vec2 p = (gl_FragCoord.xy/resolution.xy);
  vec3 color = vec3(distance(p, m));
  gl_FragColor = vec4(sin(color), 1.0);
}
