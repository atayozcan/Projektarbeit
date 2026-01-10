// Dining Philosophers in Go 1.25.5
package main

import (
	"fmt"
	"time"
)

const N = 5

func philosopher(id int, left, right chan bool) {
	for {
		fmt.Printf("Philosoph %d: denkt\n", id)
		time.Sleep(500 * time.Millisecond)

		left <- true
		right <- true

		fmt.Printf("Philosoph %d: isst\n", id)
		time.Sleep(500 * time.Millisecond)

		<-left
		<-right
	}
}

func main() {
	fmt.Println("=== Dining Philosophers: Go 1.25.5 ===")
	fmt.Println()
	fmt.Println("Setup: 5 Philosophen, 5 Gabeln (Channels)")
	fmt.Println("Deadlock-Vermeidung: Buffered channels")
	fmt.Println()
	fmt.Println("--- Running ---")

	forks := make([]chan bool, N)
	for i := 0; i < N; i++ {
		forks[i] = make(chan bool, 1)
	}

	for i := 0; i < N; i++ {
		left := forks[i]
		right := forks[(i+1)%N]
		go philosopher(i, left, right)
	}

	select {}
}
