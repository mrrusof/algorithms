all:
	go build main.go

test: all
	cat ../example.in | ./main

clean:
	rm -rf main

.PHONY: all clean
