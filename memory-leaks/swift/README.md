# Memory Leaks - Swift 6.2

## Die Lösung: ARC

```swift
do {
    let alice = Person(name: "Alice")
    let bob = Person(name: "Bob")
}  // ARC gibt beide automatisch frei (deinit wird aufgerufen)
```

Swifts ARC (Automatic Reference Counting) zählt Referenzen und gibt Objekte automatisch frei, wenn keine Referenzen mehr existieren.

## Kompilieren und Ausführen

```bash
swift main.swift
```

## Ausgabe

```
=== Memory Leak Test: Swift 6.2 (ARC) ===

Setup: Allocate objects, let ARC handle cleanup

--- Running Test ---
  Alice created
  Bob created
  Reference count: 1 each
  Bob freed
  Alice freed

--- Result ---
Status: NO LEAK (ARC guarantees cleanup)
```

## Vergleich mit Pony

| Aspekt | Swift | Pony |
|--------|-------|------|
| Speicherverwaltung | ARC | ORCA GC |
| Manuelle Arbeit | Keine | Keine |
| Compile-Time | Teilweise | Ja |

## Fazit

Swifts ARC verwaltet Speicher automatisch durch Reference Counting. Pony's ORCA GC erreicht dasselbe ohne Counting-Overhead.
