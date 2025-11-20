package main

import (
	"fmt"
	"net"
)

func starting() {
	printLine()
	fmt.Println("server.go is running")
	printLine()
}

func printLine() {
	fmt.Println("----------------------------------------")
}

func handleConnection(conn net.Conn) {
	defer conn.Close()

	buffer := make([]byte, 1024)

	for {
		n, err := conn.Read(buffer)
		if err != nil {
			if err.Error() == "EOF" {
				fmt.Println("Connection closed by remote peer")
			} else {
				fmt.Println("Read error:", err)
			}
			return
		}

		received := buffer[:n]
		fmt.Printf("Received: %s\n", received)
		printLine()

		// ----- Send response back to client -----
		response := []byte("Server received: " + string(received))
		_, writeErr := conn.Write(response)
		if writeErr != nil {
			fmt.Println("Write error:", writeErr)
			return
		}
	}
}

func main() {
	starting()

	// Start listening for TCP connections on localhost:8080
	listener, err := net.Listen("tcp", "localhost:8080")
	if err != nil {
		fmt.Println("Error starting server:", err)
		return
	}
	defer func(listener net.Listener) {
		err := listener.Close()
		if err != nil {

		}
	}(listener)
	fmt.Println("Server is listening on localhost:8080")
	printLine()

	// Continuously accept connections
	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}
		// Handle each connection in a new goroutine
		go handleConnection(conn)

	}
}

/*
type MVar[T any] chan T

func newMVar[T any]() MVar[T] {
	return make(chan T, 1)
}

func takeMVar[T any](m MVar[T]) T {
	return <-m
}

func putMVar[T any](m MVar[T], x T) {
	takeMVar(m)
}

func tryTakeMVar[T any](m MVar[T]) (r T, b bool) {
	var gg = make(chan T, 1)
	select {
	case <-m:
		return <-m, true
	default:
		return <-gg, false
	}
}

func tryPutMVar[T any](m MVar[T], x T) bool {
	select {
	case m <- takeMVar(m):
		return true
	default:
		return false
	}
}

func test() {
	m := newMVar[string]()

	go func() {
		putMVar(m, "A")
		fmt.Printf("putMVar A  ")
	}()

	go func() {
		b := tryPutMVar(m, "B")
		fmt.Printf("tryPutMVar B = %t  ", b)
	}()

	go func() {
		x := takeMVar(m)
		fmt.Printf("takeMVar %s  ", x)
	}()

	go func() {
		x, b := tryTakeMVar(m)
		if b {
			fmt.Printf("tryTakeMVar %s  ", x)
		} else {
			fmt.Printf("tryTakeMVar no luck  ")
		}
	}()

	time.Sleep(time.Second)
}

func main() {
	test()
}


Aufgabe 2

func ex1() {
	ch := make(chan string)

	hi := func() {
		ch <- "hi"
	}

	ho := func() {
		ch <- "ho"
	}

	producer := func() {
		n := rand.Intn(20)
		fmt.Printf("\nProducer: %d\n", n)
		for i := 0; i < n; i++ {
			if rand.Intn(30) > 15 {
				hi()
			} else {
				ho()
			}
		}
	}

	consumer := func() {
		n := rand.Intn(20)
		fmt.Printf("\nConsumer: %d\n", n)
		for i := 0; i < n; i++ {
			x := <-ch
			fmt.Printf("%s", x)
		}
	}

	go producer()
	consumer()
}

func ex2() {
	ch := make(chan string)

	hi := func() {
		ch <- "hi"
	}

	ho := func() {
		ch <- "ho"
	}

	producer := func() {
		n := rand.Intn(20)
		fmt.Printf("\nProducer: %d\n", n)
		for i := 0; i < n; i++ {
			if rand.Intn(30) > 15 {
				hi()
			} else {
				ho()
			}
		}
	}

	consumer := func() {
		n := rand.Intn(20)
		fmt.Printf("\nConsumer: %d\n", n)
		for i := 0; i < n; i++ {
			x := <-ch
			fmt.Printf("%s", x)
		}
	}

	// Unterschied zu ex1!
	go producer()
	go consumer()
	time.Sleep(2 * time.Second)
}

func ex3() {
	ch := make(chan string, 50) // Kanal mit Puffer!

	hi := func() {
		ch <- "hi"
	}

	ho := func() {
		ch <- "ho"
	}

	producer := func() {
		n := rand.Intn(20)
		fmt.Printf("\nProducer: %d\n", n)
		for i := 0; i < n; i++ {
			if rand.Intn(30) > 15 {
				hi()
			} else {
				ho()
			}
		}
	}

	consumer := func() {
		n := rand.Intn(20)
		fmt.Printf("\nConsumer: %d\n", n)
		for i := 0; i < n; i++ {
			x := <-ch
			fmt.Printf("%s", x)
		}
	}

	// Consumer nebenlaeufig. Producer im main thread!
	go consumer()
	producer()
	time.Sleep(2 * time.Second)
	// Ohne sleep ist der producer "zu schnell"
}

func main() {
	//Wenn consumer>producer -> deadlock
	//ex1()
	//keine deadlocks beide laufen in eigenen thread und nicht im main thread
	//ex2()
	//Consumer im eigenen Thread und blockiert nicht Main, falls consumer>producer ist.
	ex3()
}


Aufgabe 1

func thread(s string) {
	for {
		fmt.Print(s)
		time.Sleep(1 * 1e9)
	}
}

	Ausgabe: CBABCACBA
	Main.Running
	--> (Main.Running, A.Waiting)
	--> (Main.Running, A.Waiting, B.Waiting)
	--> (Main.Blocked, A.Waiting, B.Waiting)
	--> (Main.Blocked, A.Waiting, B.Running)
	--> (Main.Waiting, A.Waiting, B.Blocked)
	--> (Main.Waiting, A.Running, B.Waiting)
	--> (Main.Waiting, A.Waiting, B.Running)
	--> (Main.Running, A.Waiting, B.Blocked)

	Aufgabe 2
	A, B und C haben jeweils 3 Zustände: Running, Waiting, Blocked
	3^3

	Aufgabe 3
	Welche go tools gibt es um das Programmverhalten (Zustände und Ausführungspfade) darzustellen?
*/
