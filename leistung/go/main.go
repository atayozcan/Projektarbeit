// Performance Benchmark in Go 1.25.5
package main

import (
	"fmt"
	"time"
)

const N = 10000000

func sumOfPrimes(limit int) int64 {
	sieve := make([]bool, limit+1)
	for i := range sieve {
		sieve[i] = true
	}
	sieve[0] = false
	sieve[1] = false

	for i := 2; i*i <= limit; i++ {
		if sieve[i] {
			for j := i * i; j <= limit; j += i {
				sieve[j] = false
			}
		}
	}

	var sum int64 = 0
	for i := 2; i <= limit; i++ {
		if sieve[i] {
			sum += int64(i)
		}
	}
	return sum
}

func main() {
	fmt.Println("=== Performance Test: Go 1.25.5 ===")
	fmt.Println()
	fmt.Printf("Benchmark: Sum of primes up to %d\n", N)
	fmt.Println()

	fmt.Println("--- Running Benchmark ---")
	start := time.Now()

	result := sumOfPrimes(N)

	duration := time.Since(start)

	fmt.Println("--- Result ---")
	fmt.Printf("Sum: %d\n", result)
	fmt.Printf("Time: %d ms\n", duration.Milliseconds())
}
