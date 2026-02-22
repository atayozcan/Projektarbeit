# Deadlocks - Swift 6.2

## Das Problem

```swift
// Gegenläufige Reihenfolge → Deadlock
func task1() async {
    await resource1.acquire(by: "Task 1")  // Holt resource1
    await resource2.acquire(by: "Task 1")  // Wartet auf resource2
}

func task2() async {
    await resource2.acquire(by: "Task 2")  // Holt resource2
    await resource1.acquire(by: "Task 2")  // Wartet auf resource1
}
```

Beide Tasks warten ewig aufeinander → **Deadlock**

## Wichtig: Swift Actors verhindern Deadlocks NICHT

Swift's Actor-Isolation verhindert **Data Races**, aber **nicht Deadlocks**!

- Actor-Zugriff ist serialisiert ✓
- Deadlocks durch `await` weiterhin möglich ✗

## Die Lösung: Konsistente Ressourcen-Reihenfolge

```swift
// Beide Tasks fordern Ressourcen in gleicher Reihenfolge an
// Task 1: resource1 -> resource2
// Task 2: resource1 -> resource2
// → Kein zirkuläres Warten möglich
```

## Der entscheidende Unterschied

**Swift**: `await actor.method()` - Wartet auf Antwort
**Pony**: `actor.behavior()` - Schickt Nachricht, wartet nicht

## Kompilieren und Ausführen

```bash
swift main.swift
```

## Ausgabe

```
=== Deadlock Test: Swift 6.2 (consistent resource ordering) ===

Setup: Two tasks acquiring two resources in same order
Task 1: resource1 -> resource2
Task 2: resource1 -> resource2

--- Running Test ---
Task 1: Starting...
Task 1: Locked resource1
Task 1: Trying to lock resource2...
Task 1: Locked resource2
Task 1: Completed!
Task 2: Starting...
Task 2: Locked resource1
Task 2: Trying to lock resource2...
Task 2: Locked resource2
Task 2: Completed!

--- Result ---
Status: NO DEADLOCK (consistent ordering prevents circular wait)
```

## Vergleich mit Pony

| Aspekt | Swift 6.2 | Pony |
|--------|-----------|------|
| Actor Model | Ja | Ja |
| Message Passing | Synchron (`await`) | Asynchron |
| Deadlock möglich | Ja (ohne Disziplin) | Nein |
| Blocking | Ja (`await`) | Nein |

## Fazit

Swift's Actors schützen vor Data Races, aber das synchrone `await`-Pattern ermöglicht weiterhin Deadlocks. Konsistente Ressourcen-Reihenfolge (hierarchische Locks) verhindert zirkuläres Warten. Pony's vollständig asynchrones Actor-Model verhindert Deadlocks strukturell.
