// texture.pde
// samantha jane
// texture wrapper code
//------------------------------------------------------------------------------

/**
 * the Texture class serves a wrapper for a PImage and image path.
 */
class Texture {
  PImage img;  /**< image once loaded into memory */
  String name; /**< relative path to image file */

  /**
   * Texture constructor.
   * loads an image from the supplied path.
   */
  public Texture(String name) {
    this.name = name;
    this.img = loadImage(name);
  }
}
