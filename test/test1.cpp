#include <stdio.h>

#include <SFML/Audio.hpp>
#include <SFML/Graphics.hpp>

int main(){
  printf("Test 1\n");

  printf("SFML\n");

  sf::RenderWindow window(sf::VideoMode(200, 200), "SFML works!");

  // Create circle
  sf::CircleShape shape(100.f);
  shape.setFillColor(sf::Color::Green);

  while (window.isOpen()){
    sf::Event event;

    while (window.pollEvent(event)){

      switch(event.type){
        // While click close button
        // or press any key
        // then close window
        case sf::Event::Closed:
        case sf::Event::KeyPressed:
          window.close();
          break;

        default:
          break;
      }

    }

    window.clear();
    window.draw(shape);
    window.display();
  }


  return 0;
}
