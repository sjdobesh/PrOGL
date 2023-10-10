// uniform.pde
// samantha jane
// manages uniforms and updating
//------------------------------------------------------------------------------

/** interface to store lambda expression. */
import java.util.function.Function;

/** uniform underlying data type. */
public static enum uniform_type {
  INT,     /**< integer */
  FLOAT,   /**< float */
  BOOL,    /**< boolean */
  VEC2,    /**< 2D vector */
  VEC3,    /**< 3D vector */
  VEC4,    /**< 4D vector */
  TEXTURE, /**< 2D texture */
  MAT2,    /**< 2D matrix */
  MAT3,    /**< 3D matrix */
  MAT4     /**< 4D matrix */
}

/**
 * organizes information for a single Uniform, including
 * its underlying data type and update behavior.
 */
class Uniform<T> {

  String name;                             /**< name used to reference uniform */
  T val;                                   /**< data value */
  uniform_type type;                       /**< data type of the val member */
  Function<T, T> update_function = t -> t; /**< a pass by value update function*/
  boolean update_flag;                     /**< wether to update or not */

  /**
   * constant Uniform constructor.
   * this constructor will initialize the uniform and set update_flag to false.
   *
   * @param name the Uniform name as referenced in the glsl shader code
   * @param val the value to initialize the Uniform with
   * @param type the data type of val
   */
  Uniform(String name, T val, uniform_type type) {
    this.name = name;
    this.val = val;
    this.type = type;
    this.update_flag = false;
  }

  /**
   * updatable Uniform constructor.
   * this constructor will initialize the uniform with an update_function, 
   * setting update_flag to true.
   *
   * @param name the Uniform name as referenced in the glsl shader code
   * @param val the value to initialize the Uniform with
   * @param type the data type of val
   * @param update_function a lambda function, taking, updating, and returning
   * the data type of this Uniform.
   */
  Uniform(String name, T val, uniform_type type, Function<T, T> update_function) {
    this.name = name;
    this.val = val;
    this.type = type;
    this.update_function = update_function;
    this.update_flag = true;
  }

  /**
   * update a uniforms value if applicable, ie. `update_flag = true`.
   */
  void update() {
    if (update_flag) {
      val = update_function.apply(val); // update function must take what it returns
    } else {
      println("[ERROR!] tried to update without an update function");
    }
  }

  /**
   * set this uniform within a given program.
   */
  void set_uniform(PShader program) {
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
      case TEXTURE:
        Texture tex = (Texture)val;
        program.set(name, tex.img);
        break;
      // TODO implement mat2-4
      default:
        println("[ERROR!] unrecognized uniform data type\n");
        break;
    }
  }

  /**
   * print out data structure for debugging.
   */
  void print() {
    println("Uniform "+name+":");
    println("- val    : "+val);
    println("- type   : "+type);
    println("- update : "+update_flag);
    if (update_flag) {
      println("- func   : "+update_function);
    }
    println("----------------");
  }
}
