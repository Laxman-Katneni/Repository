WARNS=-pedantic -Wall -Wextra
CFLAGS=-g3 -std=gnu11 ${WARNS}
LIBS=-lpthread -lrt

CC=gcc


all: tags headers matrix


headers: *.c tags
	./headers.sh

matrix: matrix.c
	${CC} ${CFLAGS} -o $@ $< ${LIBS}