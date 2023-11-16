EXEC=tpc
CC=gcc
CFLAGS=-Wall -g
LDFLAGS= -ll -ly

BIN_DIR=bin/
OBJ_DIR=obj/
SRC_DIR=src/

SRC=$(addprefix $(SRC_DIR), lex.yy.c tpc.tab.c)
OBJ=$(addprefix $(OBJ_DIR), lex.yy.o tpc.tab.o)

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) -o $(EXEC) $(CFLAGS) $(OBJ) $(LDFLAGS)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(SRC_DIR)lex.yy.c: $(SRC_DIR)tpc.lex $(SRC_DIR)tpc.tab.h
	flex -o $@ $(SRC_DIR)tpc.lex

$(SRC_DIR)tpc.tab.c $(SRC_DIR)tpc.tab.h: $(SRC_DIR)tpc.y
	bison -d -o $(SRC_DIR)tpc.tab.c $(SRC_DIR)tpc.y

clean:
	rm -f $(EXEC) $(OBJ) $(SRC_DIR)lex.yy.c $(SRC_DIR)tpc.tab.c $(SRC_DIR)tpc.tab.h
	rm -d $(OBJ_DIR)
