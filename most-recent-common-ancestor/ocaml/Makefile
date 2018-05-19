run: main.exe
	time ./main.exe < ../example1.in

main.exe: main.ml
	ocamlc str.cma -o main.exe main.ml

clean:
	rm -rf main.exe main.cmi main.cmo

.PHONY: all run clean

