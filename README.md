# SFML_Test
[Tutorial](https://ithelp.ithome.com.tw/users/20130096/ironman/3531)  

## Source
libsfml-dev  
[SFML](https://www.sfml-dev.org/index.php)  
[imgui](https://github.com/ocornut/imgui)  
[imgui-sfml](https://github.com/eliasdaler/imgui-sfml)  

## Introduction
### makefile
Simple build
```bash
# Create Object file (*.o)
# Same group:
#   -c *.cpp
#   -o *.o

# Auto create obj as same name: test.o
g++ -c test.cpp

# Or create obj as different name: test2.o
g++ -c test.cpp -o test2.o
# Or
# g++ -o test2.o -c test.cpp



# Create Executable file (exe)
# Same group: -o (exe)

# Create exe, name test
g++ -o test test.o
# Or
# g++ test.o -o test


# Error build exe
# g++ -o test.o test
# g++ test.o test -o
# g++ test -o test.o
# g++ test test.o -o
```

Build with SFML library
```bash
# Create Object file (*.o)
g++ -o test.o -c test.cpp



# Create Executable file (exe)
# Same group:
#   -o (exe)
#   *.o -lsfml-*

g++ -o test test.o -lsfml-*
# Or
# g++ test.o -lsfml-* -o test.o


# Error build exe
# g++ -o test -lsfml-* test.o
# g++ -lsfml-* -o test test.o
```


Keyword  
`%`: 萬用配對字元  
`$@`: 代表目前的目標項目名稱/工作目標檔名  
`$<`: 代表第一個必要條件的檔名/目前的相依性項目  
`$^`: 代表所有必要條件的檔名，並以空格隔開這些檔名 (這份清單已移除重複的檔名)  
`$*`: 代表工作目標的主檔名/目前的相依性項目，但不含副檔名  
`$?`: 代表需要重建（被修改）的相依性項目  

函式  
`notdir`: 去除路徑    

`wildcard`:  
Format: `$(wildcard <src>)`  
Description: get `<src>` file  
Usage: `$(wildcard *.<file extension>)`  
Example:  
  `$(wildcard ./src/*.cpp)`: 獲取工作目錄`src`下的所有的`.cpp`檔案列表    

`patsubst`:  
Format: `$(patsubst <pattern>, <replacement>, <text>)`  
Description: check if `<test>` match `<pattern>`, and replace `<test>` file extension from `<pattern>` to `<replacement>`  
Usage: `$(patsubst %.cpp, %.o, $(dir))`  
Example:  
  `$(patsubst %.cpp, %.o, ./src/*.cpp)`: 把`src/*.cpp`中的變數符合字尾是`.cpp`的全部替換成`.o`    


Build Test1
```makefile
# Define
# Link library
LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system

## Source code
TEST1_SRC = test1.cpp

## Object Directory
OBJ = ./obj
TEST_OBJ = $(OBJ)/test-obj

TEST1_SRCS = $(wildcard $(TEST)/$(TEST1_SRC))
TEST1_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST1_SRCS))

## Target (Executable File)
BUILD_TEST1 = test1


# Build
$(BUILD_TEST1): $(OBJS) $(TEST1_OBJS)
	@echo "[BUILD] test1"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(TEST_OBJ)/%.o: $(TEST)/%.cpp
	@echo [COMPILE] $(notdir  $@)
	@$(CXX) $(CXXFLAGS) -o $@ -c $<
```

Build  
TEST_OBJ  
`$@`: 目前的目標項目名稱  
= $(TEST_OBJ)/%.o  
= ./obj/test-obj/test1.o && ./obj/test-obj/test2.o    

`$<`: 目前的相依性項目  
= $(TEST)/%.cpp  
= test/test1.cpp  && test/test2.cpp    

`$(CXX) $(CXXFLAGS) -o $@ -c $<`  
= g++ -g -std=c++11 -I./include -o obj/test-obj/test1.o -c test/test1.cpp    


BUILD_TEST1  
`$(BIN)/$@`  
= ./bin/test1    

`$^`: 代表所有必要條件的檔名，並以空格隔開這些檔名 (這份清單已移除重複的檔名)  
= obj/foo1.o obj/test-obj/test1.o    

`$(LINK_OPTS)`  
= -lsfml-graphics -lsfml-window -lsfml-system    

`$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)`  
= g++ -g -std=c++11 -I./include -o ./bin/test1 obj/foo1.o obj/test-obj/test1.o -lsfml-graphics -lsfml-window -lsfml-system    


### Source Code

`src` folder    : source `.cpp` or `.c` file  
`include` folder: source `.h` file  
`util` folder   : main project file  

`test` folder   : test partial function  
test1: draw circle, `sf::CircleShape`  
test2: load picture, move by keyboard, sprite/texture  
test3: same as test2, but write game class, include from ./src  
test4: OpenGL(glad), init imgui example  
test5: OpenGL, draw triangle, VBO, vertex/fragment shader  
test6: same as test5, but use VAO
test7: OpenGL, draw square, EBO



### Executable file
place in `bin` folder

### Config file
place in `cfg` folder

### Library
`lib` folder include `.so` file


## Run
### How to build?
```bash
make
```

### How to run?
```bash
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

My version  
Linux Mint = 20.1  
GCC = 9.3.0  
SFML = 2.5.1  
OpenGL(glad) = 4.6  
imgui = 1.83  
imgui-sfml = 2.3    

Download Link  
glad  
https://glad.dav1d.de/  


