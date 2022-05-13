
#define PROCESSING_COLOR_SHADER
#ifdef GL_ES
precision highp float;
#endif

// uniforms
uniform vec2 resolution;
uniform float time;
const float scale = 3.1;

void main() {
  // normalize
  vec2 p = (gl_FragCoord.xy/resolution.xy);
  gl_FragColor = vec4(abs(sin((p.x + time) * scale)), abs(cos((p.y + time) * scale)), abs(tan((p.x+p.y+time) * scale)), 1.0);
}
