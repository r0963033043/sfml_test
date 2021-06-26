/* Color define in array */
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>

#include <glad/glad.h>
#include <SFML/OpenGL.hpp>

// settings
const unsigned int SCR_WIDTH = 800;
const unsigned int SCR_HEIGHT = 600;


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

float vertices[] = {
    // 位置              // 顏色
     0.5f, -0.5f, 0.0f,  1.0f, 0.0f, 0.0f,   // 右下
    -0.5f, -0.5f, 0.0f,  0.0f, 1.0f, 0.0f,   // 左下
     0.0f,  0.5f, 0.0f,  0.0f, 0.0f, 1.0f    // 上方
};


int main(){
  printf("Test 9\n");

  printf("SFML\n");

  sf::RenderWindow window(sf::VideoMode(SCR_WIDTH, SCR_HEIGHT), "OpenGL", sf::Style::Default, sf::ContextSettings(24, 8, 4, 4, 4));
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



    //               index, size, type, normalize, stride, offset
    // Position
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6*sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    // Color
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6*sizeof(float), (void*)(3*sizeof(float)));
    glEnableVertexAttribArray(1);


//    // glBindAttribLocation(program, 0, "aPos");
//    uint32_t aPos_attrib_index = glGetAttribLocation(program, "aPos");
//    printf("aPos location = %d\n", aPos_attrib_index);
//    glVertexAttribPointer(aPos_attrib_index, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), nullptr);
//    glEnableVertexAttribArray(aPos_attrib_index);


    bool running = true;
    while (running)
    {
        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
                running = false;
            if(sf::Keyboard::isKeyPressed(sf::Keyboard::Escape))
                running = false;
        }

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUseProgram(program);

        glBindVertexArray(vao);
        glDrawArrays(GL_TRIANGLES, 0, 3);

        glBindVertexArray(0);

        window.display();
    }

    // release resources...
    glDeleteVertexArrays(1, &vao);
    glDeleteBuffers(1, &vbo);
    glDeleteProgram(program);



  return EXIT_SUCCESS;
}
