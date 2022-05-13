// glvisualizer.pde
// samantha jane
// processing audio visualizer using glsl
//------------------------------------------------------------------------------

Renderer r;

void setup() {
  size(800, 800, P2D);
  r = new Renderer("frag.glsl", width, height);
}

void draw() {
  r.render();
}
