# SFML_Test

## Introduction

### Source Code
`src` folder    : source `.cpp` or `.c` file  
`include` folder: source `.h` file  
`util` folder   : main project file  
`test` folder   : test partial function  

### Executable file
place in `bin` folder

### Config file
place in `cfg` folder

### Library
`lib` folder include `.so` file


## Run
### How to build?
```
make
```

### How to run?
```
./bin/xxx
```


## SFML
dependence packages need to install
```bash
apt install -y libsfml-dev 
```
SFML default library path is here `/lib/x86_64-linux-gnu/libsfml-*`  
`libsfml-graphics.so`  
`libsfml-window.so`  
`libsfml-system.so`  

### Simple build
```bash
g++ -c test.cpp
g++ test.o -o test -lsfml-graphics -lsfml-window -lsfml-system
```

