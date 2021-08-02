.HELLO:.c.o
CC=
EXE=hello
CFLAGS = -g -Wall
ff= pkg-config --libs --static libavformat libavutil libavcodec
gl= pkg-config --libs --static gl glew glfw3

Source=

GREP=$(Source:.c=.o)
helo:$(GREP)
	$(CC) -o $(EXE) $(CFLAGS) $(GREP)
	@echo '--------------------------OK------------------------------'
.c.o:
	$(CC) -c -o $@ $<
clean:
	rm *.o
	rm $(EXE)
