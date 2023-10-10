# PrOGL
*Processing Open-GL Interface*

PrOGL is an object oriented OpenGL rendering interface that provides utilities that handle
- compiling shaders
- setting and updating uniforms
- drawing multiple shaders to the screen

## usage
clone and run as a sketch with [Processing](https://processing.org/).


## example
running a fragment shader that requires no custom uniforms.
time, resolution, and mouse are default uniforms.

```java
void setup() {
  size(100, 100, P2D);
  r = new Renderer("frag.glsl", width, height);
}
void draw() {
  r.render();
}
```

## uniforms
declare additional uniforms as follows

### static uniforms
static uniforms are unchanging external data values 
that must be accessed by the shader script.
```java
Uniform tex = new Uniform(
  "tex",                      // uniform variable name
  new Texture("texture.jpg"), // data value
  uniform_type.TEXTURE        // data type
);
// pass the additional uniform with an overloaded constructor
r = new Renderer("frag.glsl", width, height, tex);
```

### dynamic uniforms
dynamic uniforms are data values that must
be updated every frame to a new value.
```java
Function<Int, Int> incriment_function = t -> t++;
Uniform u = new Uniform(
  "inc",             // uniform name (incriment variable)
  0,                 // starting value
  uniform_type.INT,  // data type
  incriment_function // self updating function
);
// constructor also takes array lists of uniforms
Uniform[] u_array = new Uniform[]{ tex, u };
ArrayList<Uniform> us = new ArrayList<Uniform>(Arrays.asList(u_array));
r = new Renderer("frag.glsl", width, height, us);
```

