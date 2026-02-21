# Data Races - Swift 6.2

## Swift 6.2 Features verwendet

- **Strict Concurrency** - Compiler warnt bei potenziellen Data Races
- **`nonisolated(unsafe)`** - Explizites Opt-out aus Sicherheitsprüfungen
- **Actors** - Thread-sichere Zustandsisolation
- **Structured Concurrency** - `withTaskGroup` für parallele Tasks

## Das Problem

```swift
// Swift 6.2 warnt hier!
var counter = 0  // Shared mutable state

Task { counter += 1 }  // Warning: Data race
Task { counter += 1 }  // Warning: Data race
```

## Swift 6.2 Concurrency Model

### `nonisolated(unsafe)` - Explizites Opt-out

```swift
// "Ich weiß was ich tue" - unterdrückt Warnungen
nonisolated(unsafe) var unsafeCounter = 0
```

Verwende dies **nur** für Demonstrationszwecke oder wenn du die Synchronisation selbst garantierst.

### Actors - Die sichere Alternative

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

## Strict Concurrency Checking

Swift 6.2 aktiviert standardmäßig strenge Concurrency-Checks:

```swift
// Diese Zeile erzeugt einen Compile-Time-Fehler/Warnung:
var shared = 0
Task { shared += 1 }  // Error: Mutation of captured var 'shared'
```

## Swift 6.2 vs. Frühere Versionen

| Feature | Swift 5 | Swift 6.0 | Swift 6.2 |
|---------|---------|-----------|-----------|
| Actor | Ja | Ja | Ja |
| Strict Concurrency | Opt-in | Default | Verbessert |
| `nonisolated(unsafe)` | Nein | Nein | Ja |
| MainActor by default | Nein | Nein | Optional |

## Der Unterschied: Warnings vs. Errors

### Swift 6.2
```swift
nonisolated(unsafe) var x = 0  // Kompiliert (mit Warnung)
```

### Pony
```pony
var x: U32 = 0  // Innerhalb Actor OK
// Sharing zwischen Actors: COMPILE ERROR
```

## Kompilieren und Ausführen

```bash
swift main.swift
```

## Ausgabe

### Unsicher (`nonisolated(unsafe)`)
```
Counter: 156789  (erwartet: 200000)
Status: RACE DETECTED (lost 43211 increments)
```

### Sicher (Actor)
```
Counter: 200000
Status: NO RACE (Actor guarantees safety)
```

## Vergleich mit Pony

| Aspekt | Swift 6.2 | Pony |
|--------|-----------|------|
| Actor Model | Ja | Ja |
| Strict Checking | Default (Warnings) | Immer (Errors) |
| Unsafe Escape | `nonisolated(unsafe)` | Nicht möglich |
| Blocking | `await` (synchron) | Nie (asynchron) |
| Data Races | Möglich (mit unsafe) | Unmöglich |

## Fazit

Swift 6.2 macht große Fortschritte bei Concurrency Safety:
- Strict Concurrency ist jetzt Standard
- Actors sind die empfohlene Lösung
- Compiler-Warnungen helfen beim Finden von Races

**Aber**: `nonisolated(unsafe)` erlaubt weiterhin unsicheren Code.
Pony hat keine solche Escape-Hatch.
