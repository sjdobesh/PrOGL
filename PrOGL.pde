// progl.pde
// samantha jane
// processing glsl interface
//------------------------------------------------------------------------------

/** global renderer object that renders to the entire size of the screen */
Renderer r;

/**
* setup is in charge of creating the window and initializing a Renderer object,
* along with any uniforms our shader requires.
*/
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

/**
* draw continuously calls render every frame,
* updating uniform values and progressing the shader.
*/
void draw() {
  r.render();
}
