#define PROCESSING_COLOR_SHADER
#ifdef GL_ES
precision highp float;
#endif

// uniforms
uniform float time;
uniform vec3 mouse;
uniform vec2 resolution;
uniform sampler2D tex;

const float scale = 3.1;
const float time_scale = 0.5;


void main() {
  // normalize
  vec3 m = vec3((mouse.xy/resolution.xy), mouse.z);
  vec2 p = gl_FragCoord.xy/resolution.xy;
  p.y = (p.y * -1) + 1;
  float t = time * time_scale;

  float d = abs(distance(m.xy, p));
  // vec3 color = vec3(abs(sin(8*(d+time))), abs(cos(-10*(d+time))), abs(tan(2*m.z + time)));
  vec4 txtr = texture(tex, p);
  //vec2 txtr = texture(tex, gl_FragCoord.xy).xy;

  // out
  gl_FragColor = txtr;
}
