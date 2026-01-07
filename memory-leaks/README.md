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

## Warum kein Pony-Beispiel?

Pony verwendet ORCA (Ownership and Reference Counting for Actors):
- **Kein Stop-the-World**: Jeder Actor hat eigenen GC
- **Keine GC-Pausen**: Garbage Collection läuft nebenläufig
- **Automatische Freigabe**: Programmierer kümmert sich nicht um Speicher
- **Keine Goroutine-Leaks**: Actors ohne Nachrichten werden beendet

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
│   ├── CMakeLists.txt
│   └── main.cpp
└── go/
    ├── README.md
    ├── go.mod
    └── main.go
```

## Ausführen

```bash
# C++26
cd cpp && cmake -B build && cmake --build build && ./build/MemoryLeaks

# Go 1.25.5
cd go && go run main.go
```

## Kernaussage

| Kategorie | Sprachen | Beschreibung |
|-----------|----------|--------------|
| Manuelle Verwaltung | C++ | Programmierer gibt Speicher frei |
| GC mit Leaks | Go | GC vorhanden, aber Leaks möglich |
| **Sichere GC** | **Pony** | **ORCA verhindert alle Leak-Typen** |

Pony's ORCA GC ist speziell für das Actor-Model optimiert und verhindert klassische Memory Leaks sowie Goroutine-Leaks strukturell.
