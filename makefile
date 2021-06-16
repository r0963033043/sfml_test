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
#LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system
LINK_OPTS = -lsfml-graphics -lsfml-window -lsfml-system -ldl


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
#SRCS = $(wildcard $(SRC)/*.cpp $(SRC)/*.c)
#OBJS = $(OBJ)/foo1.o $(OBJ)/game.o $(OBJ)/glad.o
#OBJS = $(patsubst $(SRC)/%.cpp | $(SRC)/%.c, $(OBJ)/%.o, $(SRCS))
#OBJS = $(patsubst $(SRC)/%.cpp $(SRC)/%.c, $(OBJ)/%.o, $(SRCS))


# BUILD_TARGET
BUILD_UTIL1 = util1

BUILD_TEST1 = test1
BUILD_TEST2 = test2
BUILD_TEST3 = test3
BUILD_TEST4 = test4


# main source
UTIL1_SRC = $(UTIL)/util1

TEST1_SRC = test1.cpp
TEST2_SRC = test2.cpp
TEST3_SRC = test3.cpp
TEST4_SRC = test4.cpp


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



all: dir-tree \
	$(BUILD_UTIL1) \
	$(BUILD_TEST1) \
	$(BUILD_TEST2) \
	$(BUILD_TEST3) \
	$(BUILD_TEST4)


# target
.PHONY: all


# lib sample: .so file
# xxx-lib: $(xxx_OBJS)
#   @echo "[LIB] Build $@ Library"
#   @$(CXX) -shared -o $(LIB)/$(xxx_TARGET) $^


$(BUILD_UTIL1): $(OBJS) $(UTIL1_OBJS)
	@echo "[BUILD] util1"
	@echo "SRCS $(SRCS)"
	@echo "OBJS $(OBJS)"
	@echo "OBJSC $(OBJSC)"
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





