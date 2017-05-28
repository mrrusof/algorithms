all:
	go build main.go
	go build main2.go

test: all
	cat ../example.in | ./main
	cat ../example.in | ./main2

clean:
	rm -rf main main2

.PHONY: all clean
