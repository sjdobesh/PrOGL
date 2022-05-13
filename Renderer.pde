// renderer.pde
// samantha jane
// takes a shader and a surface and renders
//------------------------------------------------------------------------------
class Renderer {

  Shader sh;
  PGraphics surface;
  PVector pos;
  int w, h;

  // supply a shader and dimensions
  // s = new Shader("frag.glsl", width, height);
  Renderer(String path, int w, int h) {
    this.sh = new Shader(path, w, h);
    this.surface = createGraphics(w, h, P2D);
    this.pos = new PVector(0, 0);
    this.w = w;
    this.h = h;
  }
  // optionally offset the renderer position
  Renderer(String path, int w, int h, float x, float y) {
    this.sh = new Shader(path, w, h);
    this.surface = createGraphics(sh.w, sh.h, P2D);
    this.pos = new PVector(x, y);
  }
  // or u can use a pre built shader
  Renderer(Shader sh) {
    this.sh = sh;
    this.surface = createGraphics(sh.w, sh.h, P2D);
    this.pos = new PVector(0, 0);
  }
  // again, optionally offset the renderer position
  Renderer(Shader sh, float x, float y) {
    this.sh = sh;
    this.surface = createGraphics(sh.w, sh.h, P2D);
    this.pos = new PVector(x, y);
  }

  // draw the shader to the surface
  void render() {
    update();
    surface.beginDraw();
    surface.shader(sh.program);
    surface.rect(0, 0, surface.width, surface.height);
    surface.endDraw();
    image(surface, pos.x, pos.y);
  }

  void update() {
    sh.update_uniforms();
  }

  void print() {
    println("Renderer:");
    println("- shader   : " + sh);
    println("- surface  : " + surface);
    println("- dim(w,h) : " + w +", " + h);
    println("- pos(x,y) : " + pos.x + ", " + pos.y);
    println("----------------");
  }
}
