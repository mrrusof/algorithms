
package main

import (
	"bufio"
	"os"
	"fmt"
	"strconv"
)

func e(l, r int, s string, e_n []string) ([]string) {
	if l > 0 {
		e_n = e(l - 1, r + 1, s + "(", e_n)
	}
	if r > 0 {
		e_n = e(l, r - 1, s + ")", e_n)
	}
	if l == 0 && r == 0 {
		e_n = append(e_n, s)
	}
	return e_n
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		n, err := strconv.Atoi(scanner.Text())
		if err != nil { break }
		o := e(n, 0, "", make([]string, 0, 1))
		for _, s := range o {
			fmt.Printf("%s\n", s)
		}
	}
}
