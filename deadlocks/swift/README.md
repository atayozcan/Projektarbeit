# Swift 6: Deadlock Demonstration

## Das Problem

```swift
actor Resource1 {
    func acquire(by thread: String) async {
        // Hält Ressource
    }
}

func task1() async {
    await resource1.acquire(by: "Task 1")  // Holt resource1
    await Task.sleep(100_000_000)
    await resource2.acquire(by: "Task 1")  // Wartet auf resource2
}

func task2() async {
    await resource2.acquire(by: "Task 2")  // Holt resource2
    await Task.sleep(100_000_000)
    await resource1.acquire(by: "Task 2")  // Wartet auf resource1
}
```

Beide Tasks warten ewig aufeinander → **Deadlock**

## Wichtig: Swift Actors verhindern Deadlocks NICHT

Swift's Actor-Isolation verhindert **Data Races**, aber **nicht Deadlocks**!

- Actor-Zugriff ist serialisiert ✓
- Deadlocks durch `await` weiterhin möglich ✗

## Kompilieren und Ausführen

```bash
swift main.swift
```

## Typische Ausgabe

```
Thread 1: Starting...
Thread 1: Locked resource1
Thread 2: Starting...
Thread 2: Locked resource2
Thread 1: Trying to lock resource2...
Thread 2: Trying to lock resource1...
[Programm hängt - Ctrl+C zum Beenden]
```

## Warum Deadlock trotz Actors?

Swift Actors verwenden `await` für synchrone Aufrufe:

```swift
await resource.acquire()  // Blockiert bis fertig
```

Im Gegensatz zu Pony, wo Nachrichten asynchron sind:

```pony
resource.acquire()  // Fire-and-forget, blockiert nicht
```

## Lösungen in Swift

### 1. Timeouts
```swift
try await Task.sleep(nanoseconds: 100_000_000)
// Abbruch nach Timeout
```

### 2. Nicht-blockierende Patterns
```swift
actor Resource {
    func tryAcquire() -> Bool {
        // Sofortige Rückgabe ohne Warten
    }
}
```

### 3. Hierarchische Ressourcen
```swift
// Immer resource1 vor resource2 anfordern
```

## Vergleich mit Pony

| Aspekt | Swift 6 | Pony |
|--------|---------|------|
| Actor Model | Ja | Ja |
| Message Passing | Synchron (`await`) | Asynchron |
| Deadlock möglich | Ja | Nein |
| Blocking | Ja (`await`) | Nein |

## Der entscheidende Unterschied

**Swift**: `await actor.method()` - Wartet auf Antwort
**Pony**: `actor.behavior()` - Schickt Nachricht, wartet nicht

## Fazit

Swift's Actors schützen vor Data Races, aber das synchrone `await`-Pattern ermöglicht weiterhin Deadlocks. Pony's vollständig asynchrones Actor-Model verhindert Deadlocks strukturell.
