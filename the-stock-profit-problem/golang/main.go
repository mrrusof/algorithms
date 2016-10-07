package main

import "fmt"

const MAX_LEN = 1000000

func algG(A []int) int {
	if len(A) == 0 {
		return 0
	}
	min := A[0]
	max := 0
	for i := 0; i < len(A); i++ {
		if A[i] < min {
			min = A[i]
		} else if A[i] - min > max {
			max = A[i] - min
		}
	}
	return max
}

func main() {
	A := make([]int, 0, MAX_LEN)
	var n int
	_, err := fmt.Scanf("%d", &n)
	for err == nil {
		A = append(A, n)
		_, err = fmt.Scanf("%d", &n)
	}
	fmt.Println(algG(A))
}
