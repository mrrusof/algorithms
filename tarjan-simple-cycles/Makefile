all: main.exe main-fixed-mem.exe

%.exe: %.c
	gcc -DONLINE_JUDGE -o $@ $<

run: main.exe
	./main.exe <example.in

run-fixed-mem: main-fixed-mem.exe
	./main-fixed-mem.exe <example.in

clean:
	rm -rf *.exe *~
