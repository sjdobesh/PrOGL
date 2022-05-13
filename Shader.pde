// shader.pde
// samantha jane
// shader wrapper code to organize uniform creation and updating
//------------------------------------------------------------------------------

// interface to store lambda expression
import java.util.function.Function;

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
    make_uniforms(w, h);
    set_uniforms();
  }

  // just defaults
  void make_uniforms(int w, int h) {
    // default time uniform
    Function<Float, Float> update_time = t -> (float)millis()/1000.0;
    uniforms.add(new Uniform(
      "time",
      (float) millis()/1000.0,
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
  }

  // add a list of custom defined uniforms
  void make_uniforms(ArrayList<Uniform> custom_uniforms) {
    // make default uniforms for time and resolution
    Function<Float, Float> update_time = (t) -> (float)millis()/1000.0;
    uniforms.add(new Uniform(
      "time",
      new Float((float) millis()/1000.0),
      uniform_type.FLOAT,
      update_time
    ));
    ArrayList<Float> dimensions =  new ArrayList<Float>();
    dimensions.add((float)w);
    dimensions.add((float)h);
    uniforms.add(new Uniform(
      "resolution",
      dimensions,
      uniform_type.VEC2
    ));
    uniforms.addAll(custom_uniforms);
  }

  // add a single uniform
  void make_uniforms(Uniform custom_uniform) {
    Function<Float, Float> update_time = (t) -> (float)millis()/1000.0;
    // make default uniforms for time and resolution
    uniforms.add(new Uniform(
      "time",
      new Float((float) millis()/1000.0),
      uniform_type.FLOAT,
      update_time
    ));
    ArrayList<Float> dimensions =  new ArrayList<Float>();
    dimensions.add((float)w);
    dimensions.add((float)h);
    uniforms.add(new Uniform(
      "resolution",
      dimensions,
      uniform_type.VEC2
    ));
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
    println("updating uniforms");
    println("uniforms : " + uniforms.size());
    for (Uniform u: uniforms) {
      if (u.update_flag) {
        u.update();
        u.set_uniform(program);
      }
    }
  }
}
