// shader.pde
// samantha jane
// shader wrapper code to organize uniform creation and updating
//------------------------------------------------------------------------------

// interface to store lambda expression
import java.util.function.Function;
import java.util.Collections;

// enums for unforms and shader type
public static enum shader_type {
  VERT,
  FRAG
}

// shader class holding type and uniform information
class Shader {
  PShader program;
  shader_type type;
  ArrayList<Uniform> uniforms = new ArrayList<Uniform>();
  int w, h;

  Shader(String path, int w, int h) {
    this.w = w;
    this.h = h;
    program = loadShader(path);
    println("Shader loaded...");
    make_default_uniforms(w, h);
    // make optional uniforms here
    set_uniforms();
  }

  // just defaults
  void make_default_uniforms(int w, int h) {
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
    ArrayList<Float> mouse_pos =  new ArrayList<Float>();
    mouse_pos.add((float)mouseX);
    mouse_pos.add((float)mouseY);
    mouse_pos.add(mousePressed ? 1.0 : -1.0);
    Function<ArrayList<Float>, ArrayList<Float>> update_mouse = t -> {
      t.set(0, (float)mouseX);
      t.set(1, (float)mouseY);
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

  // add a list of custom defined uniforms
  void add_uniforms(ArrayList<Uniform> custom_uniforms) {
    uniforms.addAll(custom_uniforms);
  }

  // add a single uniform
  void add_uniform(Uniform custom_uniform) {
    uniforms.add(custom_uniform);
  }

  // set uniforms in shader
  void set_uniforms() {
    for (Uniform u: uniforms) {
      u.set_uniform(program);
    }
  }

  // update uniforms with an update function
  void update_uniforms() {
    for (Uniform u: uniforms) {
      if (u.update_flag) {
        u.update();
        u.set_uniform(program);
      }
    }
  }

  // print function for debugging
  void print() {
    println("Shader:");
    println("- program  : " + program);
    println("- type     : " + type);
    println("- uniforms : " + uniforms);
    println("- dim(w,h) : " + w + ", " + h);
    println("----------------");
  }
}
