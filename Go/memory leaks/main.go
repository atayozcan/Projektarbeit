package main

import (
	"fmt"
	"sync"
	"time"
	"C" // 3. C Code
)

// https://www.codingexplorations.com/blog/understanding-memory-leaks-in-go-and-how-to-avoid-them
// 1. Langlebige Referenzen
var cache = map[string][]byte{}

func cacheData(key string, data []byte) {
	cache[key] = data
}

// 2. Go Routinen
func leakyFunc(c chan int) {
	val := <-c
	fmt.Println(val)
}

func main() {
  // 1.
	for i := 0; i < 1000000; i++ {
		data := make([]byte, 1024) // 1 KB
		cacheData(fmt.Sprintf("%d", i), data)
	}

  // 2.
  for {
  		ch := make(chan int)
  		go leakyFunc(ch)
  	}

  // 3.
  mem := C.malloc(1000)

	// We've accumulated a lot of data in cache and never removed it
	select {} // Prevent exit
}
