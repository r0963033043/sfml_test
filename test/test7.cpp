/* Draw square */
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>

#include <glad/glad.h>
#include <SFML/OpenGL.hpp>

// Vertex Shader
const char *vertexShaderSource = R"glsl(
#version 450 core
layout (location = 0) in vec3 aPos;

void main()
{
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
}
)glsl";
// Fragment Shader
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

uint32_t LoadShader(GLenum type, const char* src)
{
    uint32_t shader;
    shader = glCreateShader(type);
    glShaderSource(shader, 1, &src, nullptr);
    glCompileShader(shader);

    /* Debug Start */
    int success;
    char log[512];
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if(!success){
        glGetShaderInfoLog(shader, 512, nullptr, log);
        printf("Error Shader %s compile error\n%s\n", type == GL_VERTEX_SHADER ? "Vertex" : "Fragment", log);
        return 0;
    }
    /* Debug End */
    return shader;
}

uint32_t LinkShaderProgram(uint32_t vertex, uint32_t fragment)
{
    uint32_t program = glCreateProgram();
    glAttachShader(program, vertex);
    glAttachShader(program, fragment);
    glLinkProgram(program);

    /* Debug Start */
    int success;
    char log[512];
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if(!success)
    {
        glGetProgramInfoLog(program, 512, nullptr, log);
        printf("Error Shader Linking error\n%s\n", log);
        return 0;
    }
    /* Debug End */
    return program;
}

//float vertices[] = {
//    // 第一個三角形
//    0.5f, 0.5f, 0.0f,   // 右上角
//    0.5f, -0.5f, 0.0f,  // 右下角
//    -0.5f, 0.5f, 0.0f,  // 左上角
//    // 第二個三角形
//    0.5f, -0.5f, 0.0f,  // 右下角
//    -0.5f, -0.5f, 0.0f, // 左下角
//    -0.5f, 0.5f, 0.0f   // 左上角
//};

float vertices[] = {
     0.5f, 0.5f, 0.0f,    // 右上角
     0.5f, -0.5f, 0.0f,   // 右下角
    -0.5f, -0.5f, 0.0f,  // 左下角
    -0.5f, 0.5f, 0.0f    // 左上角
};

uint32_t indices[] = {
    //{0, 1, 3}, // 第一個三角形
    //{1, 2, 3}  // 第二個三角形
    0, 1, 3, // 第一個三角形
    1, 2, 3  // 第二個三角形
};


int main(){
  printf("Test 7\n");

  printf("SFML\n");

  sf::RenderWindow window(sf::VideoMode(800, 600), "OpenGL", sf::Style::Default, sf::ContextSettings(
        24, // depthBits
        8,  // stencilBits
        4,  // antialiasingLevel
        4,  // majorVersion
        4   // minorVersion
    ));
    window.setVerticalSyncEnabled(true);
    // Load OpenGL functions using glad
    if (!gladLoadGL())
    {
        printf("Something went wrong!\n");
        exit(-1);
    }
    printf("OpenGL %s, GLSL %s\n", glGetString(GL_VERSION), glGetString(GL_SHADING_LANGUAGE_VERSION));
    window.setActive(true);

    // Load shader
    uint32_t vertexShader = LoadShader(GL_VERTEX_SHADER, vertexShaderSource);
    uint32_t fragmentShader = LoadShader(GL_FRAGMENT_SHADER, fragmentShaderSoucre);
    uint32_t program;
    if(vertexShader && fragmentShader)
    {
        program = LinkShaderProgram(vertexShader, fragmentShader);
        glUseProgram(program);
        glDeleteShader(vertexShader);
        glDeleteShader(fragmentShader);
    }
    else
    {
        return 1;
    }
    // Load vertices
    // VAO
    uint32_t vao;
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    // VBO
    uint32_t vbo;
    glGenBuffers(1, &vbo);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    // glBindAttribLocation(program, 0, "aPos");
    uint32_t aPos_attrib_index = glGetAttribLocation(program, "aPos");
    printf("aPos location = %d\n", aPos_attrib_index);
    glVertexAttribPointer(
        aPos_attrib_index, // Location
        3,                 // size
        GL_FLOAT,          // type
        GL_FALSE,          // normalize?
        3 * sizeof(float), // stride
        nullptr            // offsets
    );
    glEnableVertexAttribArray(aPos_attrib_index);

    // EBO
    uint32_t ebo;
    //ebo = glGenBuffers(1, &ebo);
    glGenBuffers(1, &ebo);
    // 綁定
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

    bool running = true;
    while (running)
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
                running = false;
        }

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUseProgram(program);
        glBindVertexArray(vao);

        // Draw EBO
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

        glBindVertexArray(0);

        window.display();
    }

    // release resources...
    glDeleteVertexArrays(1, &vao);
    glDeleteBuffers(1, &vbo);
    glDeleteBuffers(1, &ebo);
    glDeleteProgram(program);



  return EXIT_SUCCESS;
}
