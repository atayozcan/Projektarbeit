package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Println("")
	fmt.Println("=== HTTP Server (Go) ===")
	fmt.Println("")

	// Define the handler function
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Server: Connection accepted.")
		fmt.Println("Server: Request received, sending response...")

		// Set response headers
		w.Header().Set("Content-Type", "text/plain")
		w.Header().Set("Connection", "close")

		// Write response body
		fmt.Fprintf(w, "Hello from Go!")

		fmt.Println("Server: Connection closed.")
	})

	// Start the server
	fmt.Println("Server: Listening on port 8080")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Printf("Server: Failed to listen on port 8080: %v\n", err)
	}
}
