# Go 1.25.5: Data Race Demonstration

## Das Problem

```go
var counter = 0

func increment(wg *sync.WaitGroup) {
    defer wg.Done()
    for i := 0; i < 100000; i++ {
        counter++  // UNSICHER!
    }
}

go increment(&wg)
go increment(&wg)
```

Zwei Goroutines inkrementieren denselben Zähler ohne Synchronisation.

## Go Race Detector

Go hat einen eingebauten Race Detector:

```bash
go run -race main.go
```

Output:
```
WARNING: DATA RACE
Read at 0x... by goroutine 7:
  main.increment()
Previous write at 0x... by goroutine 6:
  main.increment()
```

## Lösungen in Go

### 1. `sync.Mutex`
```go
var mtx sync.Mutex
func increment() {
    for ... {
        mtx.Lock()
        counter++
        mtx.Unlock()
    }
}
```

### 2. `sync/atomic`
```go
var counter int64
func increment() {
    for ... {
        atomic.AddInt64(&counter, 1)
    }
}
```

### 3. Channels (Go-idiomatisch)
```go
func counter(ch chan int) {
    count := 0
    for delta := range ch {
        count += delta
    }
}
```

## Vergleich mit Pony

| Aspekt | Go 1.25.5 | Pony |
|--------|-----------|------|
| Shared Memory | Erlaubt | Verboten |
| Race Detector | Runtime-Tool | Nicht nötig |
| Channels | Opt-in | Actor Messages |
| Compiler-Schutz | Nein | Ja |

## Go's Philosophie

> "Don't communicate by sharing memory; share memory by communicating."

Go **empfiehlt** Channels, **erzwingt** sie aber nicht.

## Fazit

Go bietet gute Tools (Race Detector, Channels), aber Data Races sind weiterhin möglich wenn man Shared Memory verwendet.
