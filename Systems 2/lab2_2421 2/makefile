CC=gcc
LD=ld
WARNS=-Wall -pedantic -Wextra
CFLAGS=-g3 -std=gnu11 ${WARNS}
LIBS=-lpthread -lrt

# main is an executable I want to build, the rest are handy things
all: tags headers main

# This builds visual symbol (.vs) files and the header files.
headers: *.c headers.sh
	./headers.sh

# Tags (for C code) are too handy not to keep up to date.
# This lets us use Control-] with vim (ctags command).
# Alternatively, we can use etags with emacs (etags command).
# Comment out the command that you're NOT using.
tags: *.c
	etags $^

# This is a link rule, we have a universal compile rule down below
# Output is the target of the rule : -o $@
# I want to link all of the dependencies: $^
main: main.o
	${CC} -g -o $@ $^ ${LIBS}

main.o: main.c
	${CC} -g -c $<

# This is our master compiler rule to generate .o files.
# It needs all 4 warnings (see WARNS variable defined above)
%.o: %.c *.h
	${CC} ${CFLAGS} -c $< -o $@

