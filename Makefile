CFLAGS += -O2 -g -std=c99 -Wall -Werror

hello: hello.c

test: hello
	test "`./hello`" = "Hello, World!"
	test "`./hello Test`" = "Hello, Test!"
	test "`./hello Test Test`" = "Hello, World!"

install: hello
	mkdir -p $(DESTDIR)/usr/bin
	install hello $(DESTDIR)/usr/bin

clean:
	$(RM) hello

.PHONY: test install clean
