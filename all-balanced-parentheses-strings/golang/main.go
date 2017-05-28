package main

import (
	"bufio"
	"os"
	"fmt"
	"strconv"
)

var e_ map[int][]string

func e(n int) ([]string)  {
	if n == 0 {
		return []string{""}
	} else if _, exists := e_[n]; exists {
		return e_[n]
	}
	e_[n] = make([]string, 0, 1)
	i := 0
	j := n - 1
	for i < n {
		for _, a := range e(i) {
			for _, b := range e(j) {
				e_[n] = append(e_[n], "(" + a + ")" + b)
			}
		}
		i += 1
		j -= 1
	}
	return e_[n]
}

func main() {
	e_ = make(map[int][]string)
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		n, err := strconv.Atoi(scanner.Text())
		if err != nil { break }
		for _, s := range e(n) {
			fmt.Printf("%s\n", s)
		}
	}
}
