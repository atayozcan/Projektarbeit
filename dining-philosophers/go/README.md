# Dining Philosophers - Go 1.25.5

## Implementierung

Go verwendet buffered Channels für die Gabeln und Goroutines für die Philosophen.

## Synchronisation

```go
func philosopher(id int, left, right chan bool) {
    for {
        left <- true   // Gabel nehmen
        right <- true
        // Essen...
        <-left         // Gabel zurücklegen
        <-right
    }
}
```

## Kompilieren und Ausführen

```bash
go run main.go
```

## Ausgabe

```
=== Dining Philosophers: Go 1.25.5 ===

Setup: 5 Philosophen, 5 Gabeln (Channels)
Deadlock-Vermeidung: Buffered channels

--- Running ---
Philosoph 0: denkt
Philosoph 1: denkt
...
```

## Vergleich mit Pony

| Aspekt | Go | Pony |
|--------|-----|------|
| Modell | CSP (Channels) | Actor Model |
| Deadlock-Erkennung | Runtime | Compile-Zeit (unmöglich) |
| Speichermodell | Shared Memory | Keine Sharing |
