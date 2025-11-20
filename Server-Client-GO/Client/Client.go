package main

import (
	"fmt"
	"net"
)

func main() {
	// Connect to the server at localhost:8080
	conn, err := net.Dial("tcp", "localhost:8080")
	if err != nil {
		fmt.Println("Error connecting to server:", err)
		return
	}
	defer func(conn net.Conn) {
		err := conn.Close()
		if err != nil {

		}
	}(conn)

	// Send data to the server
	data := []byte("Hello, Server!")
	_, err = conn.Write(data)
	if err != nil {
		fmt.Println("Write error:", err)
		return
	}

	// Buffer to receive server response
	buffer := make([]byte, 1024)

	// Read response from server
	n, err := conn.Read(buffer)
	if err != nil {
		fmt.Println("Read error:", err)
		return
	}

	fmt.Println("Server replied:", string(buffer[:n]))
}
