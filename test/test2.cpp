#include <stdio.h>

#include <SFML/Audio.hpp>
#include <SFML/Graphics.hpp>

int main(){
  printf("Test 2\n");

  printf("SFML\n");

  //sf::RenderWindow window(sf::VideoMode(1280, 720), "SFML works!");
  sf::RenderWindow window(sf::VideoMode(800, 600), "SFML works!");

  // Load picture
  sf::Texture texture;
  if(!texture.loadFromFile("cfg/f1.jpg")) {
  //if(!texture.loadFromFile("cfg/f2.jpg")) {
    return EXIT_FAILURE;
  }

  sf::Sprite sprite;
  sprite.setTexture(texture);
  // or
  //sf::Sprite sprite(texture);

  //sprite.setPosition(sf::Vector2f(400.f, 260.f));
  //sprite.setScale(sf::Vector2f(0.5f, 0.5f));
  //sprite.rotate(15.f);



  while (window.isOpen()){
    sf::Event event;

    while (window.pollEvent(event)){

      switch(event.type){
        // While click close button
        // or press esc
        // then close window
        case sf::Event::Closed:
          window.close();
          break;

        case sf::Event::KeyPressed:
          {
            if(event.key.code == sf::Keyboard::Escape){
              window.close();
            }
          }
          break;

        default:
          break;
      }  // End switch (event.type)

    }  // End while (window.pollEvent(event))


    // Move object(picture) by keyboard
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
      sprite.move(-0.1, 0);
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
      sprite.move(0.1, 0);
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
      sprite.move(0, -0.1);
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
      sprite.move(0, 0.1);


    window.clear();

    window.draw(sprite);

    window.display();
  }  // End while (window.isOpen())


  return EXIT_SUCCESS;
}
