package main

import (
	"fmt"
	"sync"
	"time"
)

// Two mutexes that will be used to create a deadlock
var mutex1, mutex2 sync.Mutex

func thread1Function() {
	fmt.Println("Thread 1: Starting...")

	// Thread 1 locks mutex1 first
	mutex1.Lock()
	fmt.Println("Thread 1: Locked mutex1")

	// Small delay to ensure both threads have acquired their first lock
	time.Sleep(100 * time.Millisecond)

	fmt.Println("Thread 1: Trying to lock mutex2...")
	// Thread 1 then tries to lock mutex2 (but thread2 has it)
	mutex2.Lock()
	fmt.Println("Thread 1: Locked mutex2")

	// This code will never be reached due to deadlock
	fmt.Println("Thread 1: Completed successfully!")
	mutex2.Unlock()
	mutex1.Unlock()
}

func thread2Function() {
	fmt.Println("Thread 2: Starting...")

	// Thread 2 locks mutex2 first (opposite order from thread1)
	mutex2.Lock()
	fmt.Println("Thread 2: Locked mutex2")

	// Small delay to ensure both threads have acquired their first lock
	time.Sleep(100 * time.Millisecond)

	fmt.Println("Thread 2: Trying to lock mutex1...")
	// Thread 2 then tries to lock mutex1 (but thread1 has it)
	mutex1.Lock()
	fmt.Println("Thread 2: Locked mutex1")

	// This code will never be reached due to deadlock
	fmt.Println("Thread 2: Completed successfully!")
	mutex1.Unlock()
	mutex2.Unlock()
}

func main() {
	fmt.Println(`
=== Deadlock Example ===
This program will intentionally deadlock.
You'll need to forcefully terminate it (Ctrl+C).
`)

	// Create two goroutines
	go thread1Function()
	go thread2Function()

	// Wait forever (threads will deadlock)
	select {}
}
