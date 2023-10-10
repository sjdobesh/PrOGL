// renderer.pde
// samantha jane
// takes a shader and a surface and renders
//------------------------------------------------------------------------------

/**
 * PrOGL renderer.
 * A self contained surface renderer.
 */
class Renderer {

  Shader sh;         /**< shader object */
  PGraphics surface; /**< surface to render to */
  PVector pos;       /**< position within the window */
  int w;             /**< width to render the surface as */
  int h;             /**< height to render the surface as */

  /**
   * Renderer Constructor without Uniforms.
   * This constructs the internal Shader object with only the default uniforms 
   * time, resolution, and mouse.
   *
   * @param path relative path to shader file
   * @param w width of surface in pixels
   * @param h height of surface in pixels
   */
  Renderer(String path, int w, int h) {
    this.sh = new Shader(path, w, h);
    this.surface = createGraphics(w, h, P2D);
    this.pos = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }
  /**
   * Renderer Constructor with Uniform.
   * This constructs the internal Shader object with the default uniforms
   * along with whatever we add.
   *
   * @param path relative path to shader file
   * @param w width of surface in pixels
   * @param h height of surface in pixels
   * @param uniform uniform object to initialize with shader 
   */
  Renderer(String path, int w, int h, Uniform uniform) {
    this.sh = new Shader(path, w, h, uniform);
    this.surface = createGraphics(w, h, P2D);
    this.pos = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }
  /**
   * Renderer Constructor with Uniforms.
   * This constructs the internal Shader object with default uniforms
   * and a list of other user defined Uniforms.
   *
   * @param path relative path to shader file
   * @param w width of surface in pixels
   * @param h height of surface in pixels
   * @param uniforms an ArrayList of uniform objects to initialize
   */
  Renderer(String path, int w, int h, ArrayList<Uniform> uniforms) {
    this.sh = new Shader(path, w, h, uniforms);
    this.surface = createGraphics(w, h, P2D);
    this.pos = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }

  /**
   * renders the shader and then draws it to the surface.
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
   * attempts to update all updatable internal Uniforms.
   */
  void update() {
    sh.update_uniforms();
  }

  /**
   * print Renderer class data for debugging purposes.
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
