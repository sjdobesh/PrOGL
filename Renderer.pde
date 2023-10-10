// renderer.pde
// samantha jane
// takes a shader and a surface and renders
//------------------------------------------------------------------------------

/**
 * PrOGL renderer.
 * A self contained surface renderer.
 */
class Renderer {

  /** shader object */
  Shader sh;
  /** surface to render to */
  PGraphics surface;
  /** position withing the window */
  PVector pos;
  /** width and height to render the surface as*/
  int w, h;

  // supply a shader and dimensions
  // s = new Shader("frag.glsl", width, height);
  /**
  * Renderer Constructor
  *
  * @param path relative path to shader file
  * @param w width of surface in pixels
  * @param h height of surface in pixels
  * @return a Renderer object
  */
  Renderer(String path, int w, int h) {
    this.sh = new Shader(path, w, h);
    this.surface = createGraphics(w, h, P2D);
    this.pos = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }
  // optionally include uniform(s) to pass to shader
  /**
  * Renderer Constructor
  *
  * @param path relative path to shader file
  * @param w width of surface in pixels
  * @param h height of surface in pixels
  * @param uniform uniform object to initialize with shader 
  * @return a Renderer object
  */
  Renderer(String path, int w, int h, Uniform uniform) {
    this.sh = new Shader(path, w, h, uniform);
    this.surface = createGraphics(w, h, P2D);
    this.pos = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }
  /**
  * Renderer Constructor
  *
  * @param path relative path to shader file
  * @param w width of surface in pixels
  * @param h height of surface in pixels
  * @param uniforms an ArrayList of uniform objects to initialize
  * @return a Renderer object
  */
  Renderer(String path, int w, int h, ArrayList<Uniform> uniforms) {
    this.sh = new Shader(path, w, h, uniforms);
    this.surface = createGraphics(w, h, P2D);
    this.pos = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }

  // draw the shader to the surface
  /**
  * renders the shader to the surface
  */
  void render() {
    update();
    surface.beginDraw();
    surface.shader(sh.program);
    surface.rect(0, 0, surface.width, surface.height);
    surface.endDraw();
    image(surface, pos.x, pos.y);
  }

  /**
  * self update uniforms 
  */
  void update() {
    sh.update_uniforms();
  }

  /**
  * print shader data 
  */
  void print() {
    println("Renderer:");
    println("- shader   : " + sh);
    println("- surface  : " + surface);
    println("- dim(w,h) : " + w +", " + h);
    println("- pos(x,y) : " + pos.x + ", " + pos.y);
    println("----------------");
  }
}
