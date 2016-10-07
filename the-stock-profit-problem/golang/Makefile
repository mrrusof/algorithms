all: main.exe

run: main.exe
	time ./main.exe < ../1000000-32767-benchmark.txt

main.exe: main.go
	go build -o main.exe main.go

clean:
	rm -rf main.exe

.PHONY: all run clean