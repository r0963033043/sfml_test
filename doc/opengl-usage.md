# OpenGL usage
GLSL: OpenGL 的 Shader 語言  
Shader, Program, Buffer Object

## Shader
著色器  
Type: Vertex Shader, Fragment Shader  
Function: Create, Bind, Compile, (Debug)  

### Vertex Shader  
頂點著色器  
source
```cpp
const char *vertexShaderSource = R"glsl(
#version 450 core
layout (location = 0) in vec3 aPos;

void main(){
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
    // or
    // gl_Position = vec4(aPos, 1.0);
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
    FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);
}
)glsl";
```
usage
```cpp
uint32_t fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
glCompileShader(fragmentShader);
```

### 輸入與輸出
`in`, `out`  
上個 Shader 所指定的 `out` 會對應到下個 Shader 所指定的 `in` 變數，名稱要相同
```cpp
// Vertex Shader
const char *vertexShaderSource = R"glsl(
#version 450 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;

out vec3 ourColor; // 輸出到 Fragment Shader

void main(){
    gl_Position = vec4(aPos, 1.0);
    ourColor = aColor;
}
)glsl";

// Fragment Shader
const char* fragmentShaderSoucre = R"glsl(
#version 450 core
out vec4 FragColor;

in vec3 ourColor;   // 從 Vertex Shader 輸入的顏色，名稱要一樣

void main(){
    FragColor = vec4(ourColor, 1.0);
}
)glsl";
```



## Program
Linking Shader Program
```cpp
uint32_t program;
program = glCreateProgram();

glAttachShader(program, vertexShader);
glAttachShader(program, fragmentShader);
glLinkProgram(program);

glUseProgram(program);
glDeleteShader(vertexShader);
glDeleteShader(fragmentShader);


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


## Vertex Input
### Position
Trangle
```cpp
float vertices[] = {
    -0.5f, -0.5f, 0.0f,   // 左下角
     0.5f, -0.5f, 0.0f,   // 右下角
     0.0f,  0.5f, 0.0f
};
```
Square
```cpp
float vertices[] = {
     0.5f, 0.5f, 0.0f,    // 右上角
     0.5f, -0.5f, 0.0f,   // 右下角
    -0.5f, -0.5f, 0.0f,   // 左下角
    -0.5f, 0.5f, 0.0f     // 左上角
};

uint32_t indices[] = {
    0, 1, 3, // 第一個三角形
    1, 2, 3  // 第二個三角形
};
```
### Position & Color
Trangle
```cpp
float vertices[] = {
    // 位置              // 顏色
     0.5f, -0.5f, 0.0f,  1.0f, 0.0f, 0.0f,   // 右下
    -0.5f, -0.5f, 0.0f,  0.0f, 1.0f, 0.0f,   // 左下
     0.0f,  0.5f, 0.0f,  0.0f, 0.0f, 1.0f    // 上方
};
```

## Buffer Object
VBO, VAO, EBO  

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
Element Buffer Object (EBO)  
或 Index Buffer Object (IBO)
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
glDrawElements( GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0 );
/* Loop End */

// Delete
///// delete VAO, VBO, program /////
glDeleteBuffers(1, &EBO);
```


