.PHONY: all clean

TARGET=poc

SOURCES = $(wildcard src/*.c)
HEADERS = $(wildcard inc/*.h)
OBJECTS = $(patsubst src/%.c,obj/%.o,$(SOURCES))

CFLAGS= -I./inc
LDFLAGS= -pthread -static

all: obj $(TARGET) get_root

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^
	strip $@

obj/%.o: src/%.c
	$(CC) -c $< -o $@ $(CFLAGS)

obj:
	mkdir obj

get_root: get_root_src/get_root.c
	$(CC) -o $@ $^

clean:
	rm -rf obj
	rm -f $(TARGET)
	rm -f get_root
