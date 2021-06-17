# OpenGL function define
Shader, Program, Buffer Object

## Shader
著色器  
Type: Vertex Shader, Fragment Shader  
Function: Create, Bind, Compile, (Debug)  

#### Create  
`glCreateShader` — Creates a shader object  
```cpp
GLuint glCreateShader( GLenum shaderType );
```
shaderType: `GL_VERTEX_SHADER`, `GL_FRAGMENT_SHADER`  
usage
```cpp
uint32_t shader;
// or
//GLuint shader;

GLenum type;
shader = glCreateShader(type);
```

#### Bind
`glShaderSource` — Replaces the source code in a shader object
```cpp
void glShaderSource(
  GLuint shader,
 	GLsizei count,
	const GLchar **string,
 	const GLint *length);
```
usage
```cpp
const char *src;
glShaderSource(shader, 1, &src, nullptr);
```

#### Compile
```cpp
void glCompileShader( GLuint shader );
```
usage
```cpp
glCompileShader(shader);
```

#### Debug
`glGetShaderiv` — Returns a parameter from a shader object
`glGetShaderInfoLog` — Returns the information log for a shader object
```cpp
int success;
char log[512];
glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
if(!success)
{
    glGetShaderInfoLog(shader, 512, nullptr, log);
    printf("Error Shader %s compile error\n%s\n",
        type == GL_VERTEX_SHADER ? "Vertex" : "Fragment", log);
}
```


### Vertex Shader  
頂點著色器  
source
```cpp
const char *vertexShaderSource = R"glsl(
#version 450 core
layout (location = 0) in vec3 aPos;

void main()
{
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
}
)glsl";
```
usage
```cpp
uint32_t vertexShader = glCreateShader(GL_VERTEX_SHADER);
glShaderSource(vertexShader, 1, &vertexShaderSource, nullptr);
glCompileShader(vertexShader);
```

### Fragment Shader  
片段著色器  
source
```cpp
const char* fragmentShaderSoucre = R"glsl(
#version 450 core
out vec4 FragColor;

void main()
{
    // RGBA
    //FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);
    FragColor = vec4(0.3f, 0.5f, 0.8f, 1.0f);
}
)glsl";
```
usage
```cpp
uint32_t fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
glCompileShader(fragmentShader);
```


## Program
Linking Shader Program
```cpp
uint32_t program;
program = glCreateProgram();

glAttachShader(program, vertexShader);
glAttachShader(program, fragmentShader);
glLinkProgram(program);

/* Loop Start */
glUseProgram(program);
/* Loop End */

glDeleteProgram(program);
```
Debug
```cpp
glGetProgramiv(program, GL_LINK_STATUS, &success);
if(!success){
    glGetProgramInfoLog(program, 512, nullptr, log);
    printf("Error Shader Linking error\n%s\n", log);
}
```


## Buffer Object
VBO, VAO, EBO  

#### Generate
Buffer:  
`glGenBuffers` — generate buffer object names
```cpp
void glGenBuffers(
  GLsizei n,
 	GLuint *buffers);
```
Array:  
`glGenVertexArrays` — generate vertex array object names
```cpp
void glGenVertexArrays(
  GLsizei n,
 	GLuint *arrays);
```

#### Bind
Buffer:  
`glBindBuffer` — bind a named buffer object
```cpp
void glBindBuffer(
  GLenum target,
 	GLuint buffer);
```
target: GL_ARRAY_BUFFER, GL_ELEMENT_ARRAY_BUFFER  

Array:  
`glBindVertexArray` — bind a vertex array object
```cpp
void glBindVertexArray( GLuint array );
```


#### Data
Buffer:  
`glBufferData` — creates and initializes a buffer object's data store
```cpp
void glBufferData(
  GLenum target,
 	GLsizeiptr size,
 	const void *data,
 	GLenum usage);
```
Array:  
設定頂點屬性  
`glVertexAttribPointer` — define an array of generic vertex attribute data
```cpp
void glVertexAttribPointer(
    GLuint index,
    GLint size,
    GLenum type,
    GLboolean normalized,
    GLsizei stride,
    const GLvoid * pointer);
```
stride: Specifies the byte offset between consecutive generic vertex attributes. If stride is 0, the generic vertex attributes are understood to be tightly packed in the array. The initial value is 0  
pointer: Specifies a offset of the first component of the first generic vertex attribute in the array in the data store of the buffer currently bound to the GL_ARRAY_BUFFER target. The initial value is 0  

`glEnableVertexAttribArray` — Enable or disable a generic vertex attribute array
```cpp
void glEnableVertexAttribArray(	GLuint index);
```


Vertex Input
```cpp
float vertices[] = {
     0.5f, 0.5f, 0.0f,    // 右上角
     0.5f, -0.5f, 0.0f,   // 右下角
    -0.5f, -0.5f, 0.0f,   // 左下角
    -0.5f, 0.5f, 0.0f     // 左上角
};

uint32_t indices[] = {
    {0, 1, 3}, // 第一個三角形
    {1, 2, 3}  // 第二個三角形
};
```

### VBO
Vertex Buffer Object 頂點緩衝物件
```cpp
uint32_t VBO;
glGenBuffer(1, &VBO);

glBindBuffer(GL_ARRAY_BUFFER, VBO);
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

///// 設定頂點屬性 /////
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);

// ...

/* Loop Start */
///// Use shader program /////
glUseProgram(shaderProgram);

// Draw
glDrawArrays(GL_TRIANGLES, 0, 3);
/* Loop End */

// Delete
glDeleteBuffers(1, &vbo);
///// delete program /////
```

### VAO
Vertex Array Object 頂點陣列物件
```cpp
uint32_t VAO;
glGenVertexArrays(1, &VAO);
glBindVertexArray(VAO);

///// VBO: Bind & Data /////

///// 設定頂點屬性 /////
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);

// ...

/* Loop Start */
///// Use shader program /////

// Draw
glBindVertexArray(VAO);

glDrawArrays(GL_TRIANGLES, 0, 3); // 三角形，從0開始，畫3個

glBindVertexArray(0);
/* Loop End */

// Delete
///// delete VBO, program /////
glDeleteVertexArrays(1, &vao);
```


### EBO
```cpp
///// VAO: Bind /////
///// VBO: Bind, Data /////

uint32_t EBO;
glGenBuffers(1, &EBO);

glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

///// 設定頂點屬性 /////
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);

// ...

/* Loop Start */
///// Use shader program /////
///// VAO Bind /////

glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);

// 三角形，畫6個，EBO的type，從0開始
glDrawElements(
    GL_TRIANGLES,  // 形狀
    6,               // 頂點數量
    GL_UNSIGNED_INT, // EBO 的 value type
    0                // offset
);
/* Loop End */

// Delete
///// delete VAO, VBO, program /////
glDeleteBuffers(1, &EBO);
```


