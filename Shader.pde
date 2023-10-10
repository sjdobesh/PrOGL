// shader.pde
// samantha jane
// shader wrapper code to organize uniform creation and updating
//------------------------------------------------------------------------------

/** interface to store lambda expressions. */
import java.util.function.Function;
import java.util.Collections;

/**
 * shader type enum for Uniforms and Shader identification
 */
public static enum shader_type {
  VERT, /**< vertex shader */
  FRAG  /**< fragment shader */
}

/**
 * Shader object organizes a list of uniforms and a compiled PShader.
 */
class Shader {
  PShader program;  /**< OpenGL program binding */
  shader_type type; /**< Shader type (vertex or fragment) */
  ArrayList<Uniform> uniforms = new ArrayList<Uniform>(); /**< Uniform data */
  int w /**< width */;
  int h /**< height */;

  /** Shader Constructor without Uniforms.
   * loads the shader code and sets default uniforms.
   *
   * @param path relative path to shader text file
   * @param w width of shader 
   * @param h height of shader 
   * @return a Shader object
   */
  Shader(String path, int w, int h) {
    this.w = w;
    this.h = h;
    program = loadShader(path);
    make_default_uniforms();
    set_uniforms();
  }
  /** Shader Constructor with Uniform.
   * loads the shader code and sets default and one user supplied uniforms.
   *
   * @param path relative path to shader text file
   * @param w width of shader 
   * @param h height of shader 
   * @param u Uniform object to add to list 
   * @return a Shader object
   */
  Shader(String path, int w, int h, Uniform u) {
    this.w = w;
    this.h = h;
    program = loadShader(path);
    make_default_uniforms();
    add_uniform(u);
    set_uniforms();
  }
  /** Shader Constructor with Uniforms.
   * loads the shader code and sets default and additional uniforms.
   *
   * @param path relative path to shader text file
   * @param w width of shader 
   * @param h height of shader 
   * @param u an ArrayList of Uniform objects to add to the shader
   * @return a Shader object
   */
  Shader(String path, int w, int h, ArrayList<Uniform> u) {
    this.w = w;
    this.h = h;
    program = loadShader(path);
    make_default_uniforms();
    add_uniforms(u);
    set_uniforms();
  }

  /**
   * this creates three common uniforms as defaults.
   * they are time (updating float), resolution (vec2), and mouse (vec3). 
   */
  void make_default_uniforms() {
    // default time uniform
    Function<Float, Float> update_time = t -> (float)millis()/1000.0;
    uniforms.add(new Uniform(
      "time",
      update_time.apply(0.0),
      uniform_type.FLOAT,
      update_time
    ));
    // default resolution uniform
    ArrayList<Float> dimensions =  new ArrayList<Float>();
    dimensions.add((float)w);
    dimensions.add((float)h);
    uniforms.add(new Uniform(
      "resolution",
      dimensions,
      uniform_type.VEC2
    ));
    // default mouse uniform (2d position + 1d clicking)
    ArrayList<Float> mouse_pos =  new ArrayList<Float>();
    mouse_pos.add((float)mouseX);
    mouse_pos.add((float)(-1*mouseY + height));
    mouse_pos.add(mousePressed ? 1.0 : -1.0);
    Function<ArrayList<Float>, ArrayList<Float>> update_mouse = t -> {
      t.set(0, (float)mouseX);
      t.set(1, (float)(-1*mouseY + height));
      t.set(2, mousePressed ? 1.0 : -1.0);
      return t;
    };
    mouse_pos = update_mouse.apply(mouse_pos);
    uniforms.add(new Uniform(
      "mouse",
      mouse_pos,
      uniform_type.VEC3,
      update_mouse
    ));
  }

  /** add a list of custom defined uniforms. */
  void add_uniforms(ArrayList<Uniform> custom_uniforms) {
    uniforms.addAll(custom_uniforms);
  }

  /** add a single uniform. */
  void add_uniform(Uniform custom_uniform) {
    uniforms.add(custom_uniform);
  }

  /** set uniforms in shader. */
  void set_uniforms() {
    for (Uniform u: uniforms) {
      u.set_uniform(program);
    }
  }

  /** update uniforms with an update function. */
  void update_uniforms() {
    for (Uniform u: uniforms) {
      if (u.update_flag) {
        u.update();
        u.set_uniform(program);
      }
    }
  }

  /** print function for debugging. */
  void print() {
    println("Shader:");
    println("- program  : " + program);
    println("- type     : " + type);
    println("- uniforms : " + uniforms);
    println("- dim(w,h) : " + w + ", " + h);
    println("----------------");
  }
}
