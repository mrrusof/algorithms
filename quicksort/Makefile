all: main.cs.exe main.class

main.cs.exe: main.cs
	mcs -out:main.cs.exe main.cs

main.class: main.java
	javac main.java

java-run: main.class
	java main

clean:
	rm -f main.cs.exe *.class *~
