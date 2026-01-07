package main

import (
	"fmt"
	"time"
)

const N = 5

func philosopher(id int, left, right chan bool) {
	for {
		fmt.Println("Philosoph", id, "denkt")
		time.Sleep(500 * time.Millisecond)

		// Gabeln nehmen
		left <- true
		right <- true

		fmt.Println("Philosoph", id, "isst")
		time.Sleep(500 * time.Millisecond)

		// Gabeln zurücklegen
		<-left
		<-right
	}
}

func main() {
	forks := make([]chan bool, N)

	for i := 0; i < N; i++ {
		forks[i] = make(chan bool, 1)
	}

	for i := 0; i < N; i++ {
		left := forks[i]
		right := forks[(i+1)%N]
		go philosopher(i, left, right)
	}

	select {} // blockiert main dauerhaft
}
