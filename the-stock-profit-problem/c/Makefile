all: main.exe

run: main.exe
	time ./main.exe < ../1000000-32767-benchmark.txt

main.exe: main.c
	gcc -o main.exe main.c

clean:
	rm -rf main.exe

.PHONY: all run clean