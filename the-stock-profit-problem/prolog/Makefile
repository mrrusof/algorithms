all: main.exe

run: main.exe
	time ./main.exe < ../1000000-32767-benchmark.txt

main.exe: main.pl
	swipl --goal=main --stand_alone=true -o main.exe -c main.pl

clean:
	rm -rf main.exe

.PHONY: all run clean