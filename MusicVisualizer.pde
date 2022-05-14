// glvisualizer.pde
// samantha jane
// processing audio visualizer using glsl
//------------------------------------------------------------------------------

Renderer r;

void setup() {
  size(800, 800, P2D);
  // to pass in a texture we can define it here
  Uniform tex = new Uniform(
    "tex",
    new Texture("texture.jpg"),
    uniform_type.TEXTURE
  );

  r = new Renderer("frag.glsl", width, height, tex);
}

void draw() {
  r.render();
}
