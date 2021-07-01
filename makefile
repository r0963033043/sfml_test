# Macros
SRC = ./src
INCLUDE = ./include
UTIL = ./util
TEST = ./test
BIN = ./bin
OBJ = ./obj
LIB = ./lib
#LOG = ./log

# Compilation
# Debug param
#MACROS = -DDEBUG
INC = -I$(INCLUDE)
CXX = g++
CXXFLAGS = -g -std=c++11 $(INC)
#LINK_OPTS = -L$(LIB) -lpthread -lboost_system
#LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system -ldl
#LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system -ldl -lglfw3 -lGL -lX11 -lpthread -lXrandr -lXi
#LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system -ldl -lglfw -lGL -lX11 -lpthread -lXrandr -lXi
LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system -ldl -lglfw -lGL -lX11 -lpthread -lXrandr
#LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system -ldl -lglfw


# Lib sample: object file
# xxx_SRC = $(SRC)/xxx
# xxx_OBJ = $(OBJ)/xxx
# xxx_SRCS = $(wildcard $(xxx_SRC)/*.cpp)
# xxx_OBJS = $(patsubst $(xxx_SRC)/%.cpp, $(xxx_OBJ)/%.o, $(xxx_SRCS))
# xxx_TARGET = libxxx.so


SRCS = $(wildcard $(SRC)/*.cpp)
OBJS = $(patsubst $(SRC)/%.cpp, $(OBJ)/%.o, $(SRCS))
SRCSC = $(wildcard $(SRC)/*.c)
OBJSC = $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SRCSC))


# BUILD_TARGET
BUILD_UTIL1 = util1

BUILD_TEST1 = circle
BUILD_TEST2 = move-pic
BUILD_TEST3 = move-pic-class
BUILD_TEST4 = opengl
#BUILD_TEST4 = imgui
BUILD_TEST5 = trangle-vbo
BUILD_TEST6 = trangle-vao
BUILD_TEST7 = square-ebo
BUILD_TEST8 = square-ebo-line
BUILD_TEST9 = change-color
BUILD_TEST10 = change-color2
BUILD_TEST11 = 3color
BUILD_TEST12 = test12
BUILD_TEST13 = test13


# main source
UTIL1_SRC = $(UTIL)/util1

TEST1_SRC = test1.cpp
TEST2_SRC = test2.cpp
TEST3_SRC = test3.cpp
TEST4_SRC = test4.cpp
TEST5_SRC = test5.cpp
TEST6_SRC = test6.cpp
TEST7_SRC = test7.cpp
TEST8_SRC = test8.cpp
TEST9_SRC = test9.cpp
TEST10_SRC = test10.cpp
TEST11_SRC = test11.cpp
TEST12_SRC = test12.cpp
TEST13_SRC = test13.cpp


UTIL1_OBJ = $(OBJ)/util1-obj
UTIL1_SRCS = $(wildcard $(UTIL1_SRC)/*.cpp)
UTIL1_OBJS = $(patsubst $(UTIL1_SRC)/%.cpp, $(UTIL1_OBJ)/%.o, $(UTIL1_SRCS))

TEST_OBJ = $(OBJ)/test-obj
TEST1_SRCS = $(wildcard $(TEST)/$(TEST1_SRC))
TEST1_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST1_SRCS))
TEST2_SRCS = $(wildcard $(TEST)/$(TEST2_SRC))
TEST2_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST2_SRCS))
TEST3_SRCS = $(wildcard $(TEST)/$(TEST3_SRC))
TEST3_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST3_SRCS))
TEST4_SRCS = $(wildcard $(TEST)/$(TEST4_SRC))
TEST4_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST4_SRCS))
TEST5_SRCS = $(wildcard $(TEST)/$(TEST5_SRC))
TEST5_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST5_SRCS))
TEST6_SRCS = $(wildcard $(TEST)/$(TEST6_SRC))
TEST6_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST6_SRCS))
TEST7_SRCS = $(wildcard $(TEST)/$(TEST7_SRC))
TEST7_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST7_SRCS))
TEST8_SRCS = $(wildcard $(TEST)/$(TEST8_SRC))
TEST8_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST8_SRCS))
TEST9_SRCS = $(wildcard $(TEST)/$(TEST9_SRC))
TEST9_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST9_SRCS))
TEST10_SRCS = $(wildcard $(TEST)/$(TEST10_SRC))
TEST10_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST10_SRCS))
TEST11_SRCS = $(wildcard $(TEST)/$(TEST11_SRC))
TEST11_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST11_SRCS))
TEST12_SRCS = $(wildcard $(TEST)/$(TEST12_SRC))
TEST12_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST12_SRCS))
TEST13_SRCS = $(wildcard $(TEST)/$(TEST13_SRC))
TEST13_OBJS = $(patsubst $(TEST)/%.cpp, $(TEST_OBJ)/%.o, $(TEST13_SRCS))



all: dir-tree \
	$(BUILD_TEST1) \
	$(BUILD_TEST2) \
	$(BUILD_TEST3) \
	$(BUILD_TEST4) \
	$(BUILD_TEST5) \
	$(BUILD_TEST6) \
	$(BUILD_TEST7) \
	$(BUILD_TEST8) \
	$(BUILD_TEST9) \
	$(BUILD_TEST10) \
	$(BUILD_TEST11) \
	$(BUILD_TEST12) \
	$(BUILD_TEST13) \
	$(BUILD_UTIL1)


# target
.PHONY: all


# lib sample: .so file
# xxx-lib: $(xxx_OBJS)
#   @echo "[LIB] Build $@ Library"
#   @$(CXX) -shared -o $(LIB)/$(xxx_TARGET) $^


$(BUILD_UTIL1): $(OBJS) $(UTIL1_OBJS)
	@echo "[BUILD] util1"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)


$(BUILD_TEST1): $(OBJS) $(TEST1_OBJS)
	@echo "[BUILD] test1"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST2): $(OBJS) $(TEST2_OBJS)
	@echo "[BUILD] test2"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST3): $(OBJS) $(TEST3_OBJS)
	@echo "[BUILD] test3"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST4): $(OBJS) $(OBJSC) $(TEST4_OBJS)
	@echo "[BUILD] test4"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST5): $(OBJS) $(OBJSC) $(TEST5_OBJS)
	@echo "[BUILD] test5"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST6): $(OBJS) $(OBJSC) $(TEST6_OBJS)
	@echo "[BUILD] test6"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST7): $(OBJS) $(OBJSC) $(TEST7_OBJS)
	@echo "[BUILD] test7"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST8): $(OBJS) $(OBJSC) $(TEST8_OBJS)
	@echo "[BUILD] test8"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST9): $(OBJS) $(OBJSC) $(TEST9_OBJS)
	@echo "[BUILD] test9"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST10): $(OBJS) $(OBJSC) $(TEST10_OBJS)
	@echo "[BUILD] test10"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST11): $(OBJS) $(OBJSC) $(TEST11_OBJS)
	@echo "[BUILD] test11"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST12): $(OBJS) $(OBJSC) $(TEST12_OBJS)
	@echo "[BUILD] test12"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)

$(BUILD_TEST13): $(OBJS) $(OBJSC) $(TEST13_OBJS)
	@echo "[BUILD] test13"
	@$(CXX) $(CXXFLAGS) -o $(BIN)/$@ $^ $(LINK_OPTS)


# lib sample: compile
# $(xxx_OBJ)/%.o: $(xxx_SRC)/%.cpp
#   @echo [COMPILE] $(notdir $@)
#   @$(CXX) $(CXXFLAGS) -fPIC -o $@ -c $<


$(OBJ)/%.o: $(SRC)/%.cpp
	@echo [COMPILE] $(notdir $@)
	@$(CXX) $(CXXFLAGS) -o $@ -c $<

$(OBJ)/%.o: $(SRC)/%.c
	@echo [COMPILE] $(notdir $@)
	@$(CXX) $(CXXFLAGS) -o $@ -c $<


$(UTIL1_OBJ)/%.o: $(UTIL1_SRC)/%.cpp
	@echo [COMPILE] $(notdir  $@)
	@$(CXX) $(CXXFLAGS) -o $@ -c $<


$(TEST_OBJ)/%.o: $(TEST)/%.cpp
	@echo [COMPILE] $(notdir  $@)
	@$(CXX) $(CXXFLAGS) -o $@ -c $<



dir-tree:
	@echo "[INIT] Create Binary Directory"
	@mkdir -p $(BIN)
	@echo "[INIT] Create Object Directory"
	@mkdir -p $(OBJ)
	@mkdir -p $(UTIL1_OBJ)
	@mkdir -p $(TEST_OBJ)
#	@echo "[INIT] Create Lib Object Directory"
#	@mkdir -p $(xxx_OBJ)
#	@echo "[INIT] Create Lib Directory"
#	@mkdir -p $(LIB)
#	@echo "[INIT] Create Log Directory"
#	@mkdir -p $(LOG)


.PHONY: clean

clean:
	@echo "[CLEAN] Clean Object Files"
	@rm -rf $(OBJ)
	@echo "[CLEAN] Clean Binary Files"
	@rm -f $(BIN)/*
#	@echo "[CLEAN] Clean Libs"
#	@rm -rf $(LIB)





