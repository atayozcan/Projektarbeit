# Data Races - Swift 6.2

## Swift 6.2 Features verwendet

- **Strict Concurrency** - Compiler warnt bei potenziellen Data Races
- **Actors** - Thread-sichere Zustandsisolation
- **Structured Concurrency** - `withTaskGroup` für parallele Tasks

## Das Problem

```swift
// Swift 6.2 warnt hier!
var counter = 0  // Shared mutable state

Task { counter += 1 }  // Warning: Data race
Task { counter += 1 }  // Warning: Data race
```

## Die Lösung: Actors

```swift
actor SafeCounter {
    private var value = 0

    func increment() {
        value += 1  // Immer thread-safe!
    }

    func getValue() -> Int {
        return value
    }
}

// Verwendung
let counter = SafeCounter()
await counter.increment()  // Sicher!
```

Actors serialisieren den Zugriff auf ihren Zustand. Nur ein Task kann gleichzeitig auf den Actor zugreifen.

## Kompilieren und Ausführen

```bash
swift main.swift
```

## Ausgabe

```
=== Data Race Test: Swift 6.2 (Actor) ===

Setup: Two tasks incrementing an actor-protected counter
Each task: 100000 increments
Expected result: 200000

--- Running Test ---
Task 1: Starting...
Task 2: Starting...
Task 1: Finished
Task 2: Finished

--- Result ---
Counter: 200000
Status: NO RACE (Actor guarantees safety)
```

## Vergleich mit Pony

| Aspekt | Swift 6.2 | Pony |
|--------|-----------|------|
| Actor Model | Ja | Ja |
| Strict Checking | Default (Warnings) | Immer (Errors) |
| Blocking | `await` (synchron) | Nie (asynchron) |
| Data Races | Verhindert durch Actors | Unmöglich |

## Fazit

Swift 6.2 macht große Fortschritte bei Concurrency Safety:
- Strict Concurrency ist jetzt Standard
- Actors sind die empfohlene Lösung
- Compiler-Warnungen helfen beim Finden von Races
