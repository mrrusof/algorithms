all: main.class

run: main.class
	time java main < ../1000000-32767-benchmark.txt

main.class: main.java
	javac main.java

clean:
	rm -rf main.class

.PHONY: all run clean