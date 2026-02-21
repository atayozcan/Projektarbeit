# Deadlocks - Go 1.25.5

## Das Problem

```go
var mutex1, mutex2 sync.Mutex

func goroutine1() {
    mutex1.Lock()      // Holt mutex1
    time.Sleep(100ms)
    mutex2.Lock()      // Wartet auf mutex2
}

func goroutine2() {
    mutex2.Lock()      // Holt mutex2
    time.Sleep(100ms)
    mutex1.Lock()      // Wartet auf mutex1
}
```

Beide Goroutines warten ewig aufeinander → **Deadlock**

## Go's Deadlock Detection

Go erkennt **manche** Deadlocks automatisch:

```
fatal error: all goroutines are asleep - deadlock!
```

Aber nur wenn **alle** Goroutines blockieren. Wenn andere Goroutines laufen, wird der Deadlock nicht erkannt.

## Lösungen in Go

### 1. Channels statt Mutexes
```go
ch := make(chan int)
go func() { ch <- 1 }()  // Non-blocking send
value := <-ch            // Receive
```

### 2. `sync.RWMutex` mit Timeout
```go
ctx, cancel := context.WithTimeout(ctx, time.Second)
defer cancel()
// Abbruch nach Timeout
```

### 3. Lock-Reihenfolge
```go
func safe1() { m1.Lock(); m2.Lock() }
func safe2() { m1.Lock(); m2.Lock() }  // Gleiche Reihenfolge!
```

## Kompilieren und Ausführen

```bash
go run main.go
```

## Ausgabe

```
Goroutine 1: Starting...
Goroutine 1: Locked mutex1
Goroutine 2: Starting...
Goroutine 2: Locked mutex2
Goroutine 1: Trying to lock mutex2...
Goroutine 2: Trying to lock mutex1...
[Programm hängt - Ctrl+C zum Beenden]
```

## Vergleich mit Pony

| Aspekt | Go 1.25.5 | Pony |
|--------|-----------|------|
| Locks | Ja (sync.Mutex) | Nein |
| Deadlock möglich | Ja | Nein |
| Detection | Teilweise (Runtime) | Nicht nötig |
| Channels | Opt-in | Actor Messages |

## Fazit

Go erkennt einige Deadlocks zur Laufzeit, aber nicht alle. Channels sind die idiomatische Alternative zu Mutexes.
