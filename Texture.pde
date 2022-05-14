// texture.pde
// samantha jane
// texture wrapper code
//------------------------------------------------------------------------------

class Texture {
  PImage img;
  String name;

  public Texture(String name) {
    this.name = name;
    this.img = loadImage(name);
  }
}
