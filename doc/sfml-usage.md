# SFML usage
### include
```cpp
#include <SFML/Audio.hpp>
#include <SFML/Graphics.hpp>
```

### Create window
```cpp
sf::RenderWindow window(sf::VideoMode(200, 200), "SFML works!");
```

### Create Image
Create circle
```cpp
sf::CircleShape shape(100.f);
shape.setFillColor(sf::Color::Green);
```
Load picture
```cpp
sf::Texture texture;
texture.loadFromFile("cfg/f1.jpg");

sf::Sprite sprite;
sprite.setTexture(texture);
```

### Check window status
```cpp
while (window.isOpen()){
  ///// Get & Set event /////
  ///// Draw window /////
}
```

### Get event
While click close button or press esc, then close window
```cpp
sf::Event event;
while(window.pollEvent(event))
{
  // Click close button
  if(event.type == sf::Event::Closed){
    ///// Close window /////
  }

  // Press ESC to close
  if(event.type == sf::Event::KeyPressed
      && event.key.code == sf::Keyboard::Escape){
    ///// Close window /////
  }
  if(sf::Keyboard::isKeyPressed(sf::Keyboard::Escape))
    ///// Close window /////
  }
}
```

### Close window
```cpp
window.close();
```

### Set Picture status
Move object(picture) by keyboard
```cpp
if(sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
  sprite.move(-0.1, 0);
if(sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
  sprite.move(0.1, 0);
if(sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
  sprite.move(0, -0.1);
if(sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
  sprite.move(0, 0.1);
```

### Draw window
```cpp
window.clear();


// draw circle
window.draw(shape);

// draw picture
window.draw(sprite);


window.display();
```




