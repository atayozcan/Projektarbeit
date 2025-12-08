package main

import (
	"fmt"
	"net"
)

func main() {
	fmt.Println("")
	fmt.Println("=== TCP Client (Go) ===")
	fmt.Println("")

	fmt.Println("Client: Connecting to server...")

	// Connect to the server at localhost:8080
	conn, err := net.Dial("tcp", "localhost:8080")
	if err != nil {
		fmt.Println("Client: Connection failed:", err)
		return
	}
	defer func(conn net.Conn) {
		err := conn.Close()
		if err != nil {

		}
	}(conn)

	fmt.Println("Client: Connected.")

	// Send data to the server
	fmt.Println("Client: Sending request...")
	data := []byte("Hello, Server!")
	_, err = conn.Write(data)
	if err != nil {
		fmt.Println("Client: Write error:", err)
		return
	}

	// Buffer to receive server response
	buffer := make([]byte, 1024)

	// Read response from server
	n, err := conn.Read(buffer)
	if err != nil {
		fmt.Println("Client: Read error:", err)
		return
	}

	fmt.Println("Client: Response received:", string(buffer[:n]))
	fmt.Println("Client: Connection closed.")
}
