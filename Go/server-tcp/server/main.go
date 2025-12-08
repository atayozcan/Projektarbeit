package main

import (
	"fmt"
	"net"
)

func starting() {
	fmt.Println("")
	fmt.Println("=== TCP Server (Go) ===")
	fmt.Println("")
}

func handleConnection(conn net.Conn) {
	defer conn.Close()

	buffer := make([]byte, 1024)

	for {
		n, err := conn.Read(buffer)
		if err != nil {
			if err.Error() == "EOF" {
				fmt.Println("Server: Connection closed.")
			} else {
				fmt.Println("Server: Read error:", err)
			}
			return
		}

		received := buffer[:n]
		fmt.Printf("Server: Received: %s\n", received)

		// Send response back to client
		fmt.Println("Server: Sending response...")
		response := []byte("Server received: " + string(received))
		_, writeErr := conn.Write(response)
		if writeErr != nil {
			fmt.Println("Server: Write error:", writeErr)
			return
		}
	}
}

func main() {
	starting()

	// Start listening for TCP connections on localhost:8080
	listener, err := net.Listen("tcp", "localhost:8080")
	if err != nil {
		fmt.Println("Server: Error starting:", err)
		return
	}
	defer func(listener net.Listener) {
		err := listener.Close()
		if err != nil {

		}
	}(listener)
	fmt.Println("Server: Listening on port 8080")

	// Continuously accept connections
	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Server: Error accepting connection:", err)
			continue
		}
		fmt.Println("Server: Connection accepted.")
		// Handle each connection in a new goroutine
		go handleConnection(conn)
	}
}
