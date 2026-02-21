# Dining Philosophers - Swift 6.2

## Implementierung

Swift verwendet Actors für die Gabeln. Jeder Philosoph läuft als Task.

## Actor-basierte Synchronisation

```swift
actor Fork {
    private var inUse = false

    func acquire() async {
        while inUse { await Task.yield() }
        inUse = true
    }

    func release() {
        inUse = false
    }
}
```

## Kompilieren und Ausführen

```bash
swift main.swift
```

## Ausgabe

```
=== Dining Philosophers: Swift 6.2 ===

Setup: 5 Philosophen, 5 Gabeln (Actors)
Deadlock-Vermeidung: Letzter Philosoph greift umgekehrt

--- Running ---
Philosoph 0: denkt
Philosoph 1: denkt
...
```

## Vergleich mit Pony

| Aspekt | Swift | Pony |
|--------|-------|------|
| Actor Model | Ja (seit Swift 5.5) | Ja (von Anfang an) |
| Strict Concurrency | Optional | Immer |
| Deadlock-Schutz | Manuell | Automatisch |
