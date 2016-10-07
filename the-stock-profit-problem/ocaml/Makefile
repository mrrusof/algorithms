all: main.exe

run: main.exe
	time ./main.exe < ../1000000-32767-benchmark.txt

main.exe: main.ml
	ocamlc -o main.exe main.ml

clean:
	rm -rf main.exe main.cmi main.cmo

.PHONY: all run clean