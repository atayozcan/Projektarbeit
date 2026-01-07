// Data Race Demonstration in Go 1.25.5
package main

import (
	"fmt"
	"sync"
)

const ITERATIONS = 100000

var counter = 0

func increment(wg *sync.WaitGroup) {
	defer wg.Done()
	for i := 0; i < ITERATIONS; i++ {
		counter++ // UNSICHER: Keine Synchronisation
	}
}

func main() {
	fmt.Println("=== Data Race Test: Go 1.25.5 ===")
	fmt.Println()
	fmt.Println("Setup: Two goroutines incrementing a shared counter")
	fmt.Printf("Each goroutine: %d increments\n", ITERATIONS)
	fmt.Printf("Expected result: %d\n", ITERATIONS*2)
	fmt.Println()

	fmt.Println("--- Running Test ---")
	fmt.Println("Goroutine 1: Starting...")
	fmt.Println("Goroutine 2: Starting...")

	var wg sync.WaitGroup
	wg.Add(2)

	go increment(&wg)
	go increment(&wg)

	wg.Wait()

	fmt.Println("Goroutine 1: Finished")
	fmt.Println("Goroutine 2: Finished")
	fmt.Println()

	fmt.Println("--- Result ---")
	fmt.Printf("Counter: %d\n", counter)

	if counter == ITERATIONS*2 {
		fmt.Println("Status: NO RACE DETECTED (got lucky!)")
	} else {
		fmt.Printf("Status: RACE DETECTED (lost %d increments)\n", (ITERATIONS*2)-counter)
	}
}
