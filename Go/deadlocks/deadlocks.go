package main

func main() {
	ch := make(chan int)
	snd := func() {
		ch <- 1
	}
	// go snd() // S1 Thread - kein deadlock
	snd() // S2 Main Thread
}
