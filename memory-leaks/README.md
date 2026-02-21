# Memory Leaks

Vergleich wie verschiedene Programmiersprachen mit Memory Leaks umgehen.

## Das Problem

Ein Memory Leak entsteht wenn:
- Speicher alloziert wird
- Die Referenz verloren geht
- Der Speicher nie freigegeben wird

```cpp
void leak() {
    auto ptr = new int[1000];
    // Funktion endet, ptr ist weg
    // Aber die 1000 ints bleiben im Speicher!
}
```

## Sprachen im Vergleich

| Sprache | Memory Management | Leak möglich? | Leak-Typen |
|---------|-------------------|---------------|------------|
| C++ | Manuell | Ja | Vergessenes delete |
| Go | GC | Ja | Goroutine, Cache |
| Rust | Ownership | Selten* | Referenzzyklen |
| Swift | ARC | Selten* | Retain Cycles |
| **Pony** | **ORCA GC** | **Nein** | - |

*Mit Smart Pointers / starken Referenzen möglich

## Pony: ORCA GC

Pony verhindert Memory Leaks strukturell durch ORCA (Ownership and Reference Counting for Actors). Das Pony-Beispiel demonstriert, warum Leaks unmöglich sind.

## Standardisierte Test-Ausgabe

```
=== Memory Leak Test: [Sprache] ===

--- Test 1: Memory Leak ---
Allocating memory without freeing...
Status: LEAK

--- Test 2: Safe Alternative ---
Using safe memory management...
Status: NO LEAK

--- Comparison ---
[Sprache]: [Beschreibung]
Pony: Automatic GC, no manual freeing needed
```

## Verzeichnisstruktur

```
memory-leaks/
├── README.md
├── cpp/
│   ├── README.md
│   └── main.cpp
├── go/
│   ├── README.md
│   └── main.go
├── pony/
│   ├── README.md
│   └── main.pony
├── rust/
│   ├── README.md
│   ├── Cargo.toml
│   └── src/main.rs
└── swift/
    ├── README.md
    └── main.swift
```

## Ausführen

```bash
# C++26
cd cpp && g++ -std=c++26 main.cpp -o main && ./main

# Go 1.25.5
cd go && go run main.go

# Pony
cd pony && ponyc && ./pony

# Rust 2024
cd rust && cargo run

# Swift 6.2
cd swift && swift main.swift
```

## Kernaussage

| Kategorie | Sprachen | Beschreibung |
|-----------|----------|--------------|
| Manuelle Verwaltung | C++ | Programmierer gibt Speicher frei |
| GC mit Leaks | Go | GC vorhanden, aber Leaks möglich |
| **Sichere GC** | **Pony** | **ORCA verhindert alle Leak-Typen** |

Pony's ORCA GC ist speziell für das Actor-Model optimiert und verhindert klassische Memory Leaks sowie Goroutine-Leaks strukturell.
