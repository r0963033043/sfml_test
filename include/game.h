#ifndef GAME_H
#define GAME_H

#include <SFML/Audio.hpp>
#include <SFML/Graphics.hpp>

class Game {

    public:

        Game();
        ~Game() = default;
        //~Game();

        void run();

        void processInput();

        void update();

        void render();

    private:

        sf::RenderWindow window;

        sf::Texture texture;
        sf::Sprite sprite;
};

#endif
