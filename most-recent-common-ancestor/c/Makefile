run: main.exe
	time ./main.exe < ../example1.in

main.exe: main.c
	gcc -o main.exe main.c

clean:
	rm -rf main.exe

.PHONY: all run clean
