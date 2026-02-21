// Deadlock Demonstration in Go 1.25.5
package main

import (
	"fmt"
	"sync"
	"time"
)

var mutex1, mutex2 sync.Mutex

func goroutine1Function() {
	fmt.Println("Goroutine 1: Starting...")
	mutex1.Lock()
	fmt.Println("Goroutine 1: Locked mutex1")

	time.Sleep(100 * time.Millisecond)

	fmt.Println("Goroutine 1: Trying to lock mutex2...")
	mutex2.Lock()
	fmt.Println("Goroutine 1: Locked mutex2")
	fmt.Println("Goroutine 1: Completed successfully!")
	mutex2.Unlock()
	mutex1.Unlock()
}

func goroutine2Function() {
	fmt.Println("Goroutine 2: Starting...")
	mutex2.Lock()
	fmt.Println("Goroutine 2: Locked mutex2")

	time.Sleep(100 * time.Millisecond)

	fmt.Println("Goroutine 2: Trying to lock mutex1...")
	mutex1.Lock()
	fmt.Println("Goroutine 2: Locked mutex1")
	fmt.Println("Goroutine 2: Completed successfully!")
	mutex1.Unlock()
	mutex2.Unlock()
}

func main() {
	fmt.Println("=== Deadlock Test: Go 1.25.5 ===")
	fmt.Println()
	fmt.Println("Setup: Two goroutines acquiring two mutexes in opposite order")
	fmt.Println("Goroutine 1: mutex1 -> mutex2")
	fmt.Println("Goroutine 2: mutex2 -> mutex1")
	fmt.Println()
	fmt.Println("--- Running Test ---")

	go goroutine1Function()
	go goroutine2Function()

	select {} // Blocks forever (deadlock)
}
