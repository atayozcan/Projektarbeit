package main

import (
	"fmt"
	"net/http"
)

func main() {
	// Define the handler function
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Connection accepted.")

		// Set response headers (automatically handled by http package)
		w.Header().Set("Content-Type", "text/plain")
		w.Header().Set("Connection", "close")

		// Write response body
		fmt.Fprintf(w, "Hello from Go!")
		fmt.Println("Connection closed.")
	})
	// Start the server
	fmt.Println("Server listening on port 8080")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		fmt.Printf("Failed to listen on port 8080: %v\n", err)
	}
}
