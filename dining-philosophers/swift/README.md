# Dining Philosophers - Swift 6.2

## Implementierung

Gabeln und Philosophen sind jeweils Actors. Deadlock-Vermeidung durch umgekehrte Gabel-Reihenfolge beim letzten Philosophen.

## Actor-basierte Lösung

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

actor Philosopher {
    let id: Int
    let firstFork: Fork
    let secondFork: Fork

    func dine() async {
        await firstFork.acquire()
        await secondFork.acquire()
        // isst...
        await firstFork.release()
        await secondFork.release()
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
Philosoph 2: denkt
Philosoph 3: denkt
Philosoph 4: denkt
Philosoph 0: isst
Philosoph 2: isst
...
```

## Vergleich mit Pony

| Aspekt | Swift | Pony |
|--------|-------|------|
| Actor Model | Ja (seit Swift 5.5) | Ja (von Anfang an) |
| Strict Concurrency | Optional | Immer |
| Deadlock-Schutz | Manuell | Automatisch |

## Fazit

Swift's Actor-Model ermöglicht Thread-sichere Synchronisation, aber Deadlock-Vermeidung muss manuell implementiert werden (Gabel-Reihenfolge). Pony's asynchrones Actor-Model verhindert Deadlocks strukturell.
