.HELLO:.c.o
CC=
EXE=hello
CFLAGS = -g -Wall
PKG= pkg-config --libs libavformat libavutil libavcodec
DPKG=

GREP=$(DPKG:.c=.o)
helo:$(GREP)
	$(CC) -o $(EXE) $(CFLAGS) $(GREP)
	@echo '--------------------------OK------------------------------'
.c.o:
	$(CC) -c -o $@ $<
clean:
	rm *.o
	rm hello
