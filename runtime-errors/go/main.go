// Out-of-Bounds-Zugriff in Go 1.25.5
package main

import "fmt"

func safeAccess[T any](slice []T, index int) (T, bool) {
	var zero T
	if index < 0 || index >= len(slice) {
		return zero, false
	}
	return slice[index], true
}

func main() {
	fmt.Println("=== Out-of-Bounds Test: Go 1.25.5 ===")
	fmt.Println()

	slice := []int{10, 20, 30}
	fmt.Printf("Array: %v\n", slice)
	fmt.Printf("Size:  %d\n", len(slice))
	fmt.Println()

	// Test 1: Ungültiger Index mit panic/recover
	fmt.Println("--- Test 1: Invalid Index (10) ---")
	func() {
		defer func() {
			if r := recover(); r != nil {
				fmt.Printf("Method: slice[10]\n")
				fmt.Printf("Result: PANIC - %v\n", r)
			}
		}()
		_ = slice[10]
	}()
	fmt.Println()

	// Test 2: Ungültiger Index mit sicherer Funktion
	fmt.Println("--- Test 2: Safe Access (10) ---")
	if value, ok := safeAccess(slice, 10); ok {
		fmt.Printf("Method: safeAccess(slice, 10)\n")
		fmt.Printf("Result: %d\n", value)
	} else {
		fmt.Printf("Method: safeAccess(slice, 10)\n")
		fmt.Printf("Result: false (index out of bounds)\n")
	}
	fmt.Println()

	// Test 3: Gültiger Index
	fmt.Println("--- Test 3: Valid Index (1) ---")
	if value, ok := safeAccess(slice, 1); ok {
		fmt.Printf("Method: safeAccess(slice, 1)\n")
		fmt.Printf("Result: %d\n", value)
	}
	fmt.Println()

	// Test 4: Standardwert
	fmt.Println("--- Test 4: Default Value ---")
	value, ok := safeAccess(slice, 10)
	if !ok {
		value = -1
	}
	fmt.Printf("Method: safeAccess with default\n")
	fmt.Printf("Result: %d\n", value)
	fmt.Println()

	// Test 5: Iterator
	fmt.Println("--- Test 5: Iterator ---")
	fmt.Println("Method: for i, v := range slice")
	for i, v := range slice {
		fmt.Printf("[%d] = %d\n", i, v)
	}
}
