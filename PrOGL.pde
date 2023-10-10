// progl.pde
// samantha jane
// processing glsl host
//------------------------------------------------------------------------------

Renderer r;

void setup() {
  size(800, 800, P2D);
  // set custom uniforms as follows
  Uniform tex = new Uniform(
    "tex",
    new Texture("texture.jpg"),
    uniform_type.TEXTURE
  );

  // set renderer
  r = new Renderer("frag.glsl", width, height, tex);
}

void draw() {
  r.render();
}
