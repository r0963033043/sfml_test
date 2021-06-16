//#include <stdio.h>
#include <iostream>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>

#include <glad/glad.h>
#include <SFML/OpenGL.hpp>

//#include <imgui.h>
//#include <imgui-SFML.h>


int main(){
  printf("Test 4\n");

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



  return EXIT_SUCCESS;
}
