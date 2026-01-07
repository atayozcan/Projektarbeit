// Memory Leak Demonstration in Go 1.25.5
package main

import (
	"fmt"
	"runtime"
)

// Globaler Cache der nie geleert wird
var cache = make(map[string][]byte)

func leakMemory() {
	// LEAK: Daten werden zum Cache hinzugefügt aber nie entfernt
	for i := 0; i < 10000; i++ {
		data := make([]byte, 1024) // 1 KB pro Eintrag
		cache[fmt.Sprintf("key_%d", i)] = data
	}
}

func leakGoroutine() {
	// LEAK: Goroutine wartet ewig auf Channel der nie beschrieben wird
	ch := make(chan int)
	go func() {
		<-ch // Blockiert ewig
		fmt.Println("Never reached")
	}()
}

func printMemStats(label string) {
	var m runtime.MemStats
	runtime.ReadMemStats(&m)
	fmt.Printf("%s: Alloc = %d KB\n", label, m.Alloc/1024)
}

func main() {
	fmt.Println("=== Memory Leak Test: Go 1.25.5 ===")
	fmt.Println()

	fmt.Println("--- Test 1: Cache Leak ---")
	printMemStats("Before")

	leakMemory()

	printMemStats("After ")
	fmt.Println("Status: LEAK (10 MB in cache, never freed)")
	fmt.Println()

	fmt.Println("--- Test 2: Goroutine Leak ---")
	fmt.Printf("Goroutines before: %d\n", runtime.NumGoroutine())

	for i := 0; i < 100; i++ {
		leakGoroutine()
	}

	fmt.Printf("Goroutines after:  %d\n", runtime.NumGoroutine())
	fmt.Println("Status: LEAK (100 blocked goroutines)")
	fmt.Println()

	fmt.Println("--- Test 3: GC Cannot Help ---")
	runtime.GC() // Manuell GC auslösen
	printMemStats("After GC")
	fmt.Println("Cache-Referenzen existieren noch - GC kann nicht freigeben")
	fmt.Println()

	fmt.Println("--- Comparison ---")
	fmt.Println("Go:   GC vorhanden, aber Leaks durch Referenzen/Goroutines möglich")
	fmt.Println("Pony: ORCA GC, Actor-basiert, keine Goroutine-Leaks möglich")
}
