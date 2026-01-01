package main

import (
	"fmt"
	"sync"
	"time"
)

func example1() {
    var x int
    y := make(chan int, 1)

    acquire := func() {
        y <- 1
    }
    release := func() {
        <-y
    }

    // Thread T2
    go func() {
        acquire()
        x = 3 // P1
        release()
    }()

    // Thread T1 = Main Thread
    x = 4 // P2
    acquire()
    release()

    time.Sleep(1 * 1e9)
    fmt.Printf("%d \n", x)
}
