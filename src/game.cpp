#include "game.h"

#include <stdio.h>

Game::Game() {

    window.create(sf::VideoMode(800, 600), "SFML Window");

    if(!texture.loadFromFile("cfg/f1.jpg"))
        printf("Error loading file\n");

    sprite.setTexture(texture);
    //sprite.setPosition(sf::Vector2f(400.f, 260.f));
    //sprite.setScale(sf::Vector2f(0.1f, 0.1f));
}

//Game::~Game(){
//}

void Game::run() {

    while(window.isOpen()) {

        processInput();

        update();

        render();
    }
}

void Game::processInput() {

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
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::A))
        sprite.move(-0.1, 0);
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::D))
        sprite.move(0.1, 0);
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::W))
        sprite.move(0, -0.1);
    if(sf::Keyboard::isKeyPressed(sf::Keyboard::S))
        sprite.move(0, 0.1);
}

void Game::render() {

    window.clear();

    window.draw(sprite);

    window.display();
}

void Game::update() {
}
