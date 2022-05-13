// uniform.pde
// samantha jane
// manages uniforms and updating
//------------------------------------------------------------------------------

// interface to store lambda expression
import java.util.function.Function;

// quickly check a uniforms type
public static enum uniform_type {
  INT,
  FLOAT,
  BOOL,
  VEC2,
  VEC3,
  VEC4,
  MAT2,
  MAT3
}

// a single uniform and whether or not it needs updating
class Uniform<T> {

  String name;
  T val;
  uniform_type type;
  Function<T, T> update_function = t -> t; // update function must take what it returns
  boolean update_flag;

  // constant uniform constructor
  Uniform(String name, T val, uniform_type type) {
    this.name = name;
    this.val = val;
    this.type = type;
    this.update_flag = false;
  }

  // or optionally with an update function
  Uniform(String name, T val, uniform_type type, Function<T, T> update_function) {
    this.name = name;
    this.val = val;
    this.type = type;
    this.update_function = update_function;
    this.update_flag = true;
  }

  // update uniform value
  void update() {
    if (update_flag) {
      val = update_function.apply(val); // update function must take what it returns
    } else {
      println("[ERROR!] tried to update without an update function");
    }
  }


  // set this uniform within a given program
  void set_uniform(PShader program) {
    println("Setting uniform: "+ name);
    println("val: "+ val);
    println("type: "+ type);
    switch (type) {
      case INT:
        program.set(name, (int)val);
        break;
      case FLOAT:
        program.set(name, (float)val);
        break;
      case VEC2:
        ArrayList<Float> v2val = (ArrayList<Float>)val;
        program.set(
          name,
          v2val.get(0),
          v2val.get(1)
        );
        break;
      case VEC3:
        ArrayList<Float> v3val = (ArrayList<Float>)val;
        program.set(
          name,
          v3val.get(0),
          v3val.get(1),
          v3val.get(2)
        );
        break;
      case VEC4:
        ArrayList<Float> v4val = (ArrayList<Float>)val;
        program.set(
          name,
          v4val.get(0),
          v4val.get(1),
          v4val.get(2),
          v4val.get(3)
        );
        break;
      default:
        println("[ERROR!] unrecognized uniform data type\n");
        break;
    }
  }
}
