# Go 1.25.5: Memory Leak Demonstration

## Das Problem

Go hat Garbage Collection, aber Leaks sind trotzdem möglich!

### 1. Cache ohne Limit
```go
var cache = make(map[string][]byte)

func addToCache(key string, data []byte) {
    cache[key] = data  // Wächst unbegrenzt!
}
```

### 2. Goroutine Leaks
```go
func leaky() {
    ch := make(chan int)
    go func() {
        <-ch  // Wartet ewig - Goroutine stirbt nie
    }()
}
```

## Typische Ausgabe

```
=== Memory Leak Test: Go 1.25.5 ===

--- Test 1: Cache Leak ---
Before: Alloc = 100 KB
After:  Alloc = 10340 KB
Status: LEAK (10 MB in cache, never freed)

--- Test 2: Goroutine Leak ---
Goroutines before: 1
Goroutines after:  101
Status: LEAK (100 blocked goroutines)
```

## Arten von Leaks in Go

| Art | Ursache | Lösung |
|-----|---------|--------|
| Cache Leak | Unbegrenztes Wachstum | LRU Cache, Expiration |
| Goroutine Leak | Blockierte Channels | Context, Timeouts |
| Slice Leak | Große Slice-Referenz | Copy statt Slice |
| CGo Leak | C.malloc ohne C.free | Immer C.free aufrufen |

## Lösungen

### 1. Cache mit Limit
```go
// LRU Cache mit maximaler Größe
cache := lru.New(1000)
```

### 2. Goroutines mit Context
```go
func worker(ctx context.Context) {
    select {
    case <-ctx.Done():
        return  // Sauber beenden
    case data := <-ch:
        process(data)
    }
}
```

### 3. Pprof für Debugging
```go
import _ "net/http/pprof"
// Dann: go tool pprof http://localhost:6060/debug/pprof/heap
```

## Vergleich mit Pony

| Aspekt | Go 1.25.5 | Pony |
|--------|-----------|------|
| GC | Ja (Stop-the-World) | Ja (ORCA, kein StW) |
| Goroutine Leaks | Möglich | Nicht möglich* |
| Reference Leaks | Möglich | Nicht möglich* |
| Concurrency Model | Goroutines + Channels | Actors |

*Pony Actors werden automatisch beendet wenn keine Nachrichten mehr kommen

## Fazit

Go's GC verhindert klassische Leaks (vergessenes `free`), aber:
- Unbegrenzte Caches wachsen ewig
- Blockierte Goroutines sterben nie
- Referenz-Leaks sind weiterhin möglich

Pony's Actor-Model verhindert Goroutine-Leaks strukturell.
