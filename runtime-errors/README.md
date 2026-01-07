# Runtime Errors: Out-of-Bounds

Vergleich der Fehlerbehandlung bei Array-Zugriffen in verschiedenen Programmiersprachen.

## Das Problem

Ein Out-of-Bounds-Zugriff tritt auf, wenn ein Programm auf ein Array-Element zugreift, dessen Index außerhalb der gültigen Grenzen liegt.

```
Array:  [10, 20, 30]
Index:    0   1   2

Zugriff auf Index 10 → Fehler!
```

## Sprachen im Vergleich

| Sprache | Version | Standard-Zugriff | Ergebnis | Sichere Alternative |
|---------|---------|------------------|----------|---------------------|
| C++ | 26 | `vec[i]` | Undefiniert | `at()`, `expected` |
| Go | 1.25.5 | `slice[i]` | Panic | `if err != nil` |
| Rust | 2024 | `vec[i]` | Panic | `get()`, `Result` |
| Swift | 6.2 | `arr[i]` | Fatal Error | Typed Throws |
| **Pony** | - | `arr(i)?` | Behandelbar | - (einzige Option) |

## Compiler-Schutz

| Sprache | Erzwingt Fehlerbehandlung? |
|---------|----------------------------|
| C++26 | Nein |
| Go 1.25.5 | Nein |
| Rust 2024 | Warnung (ignorierbar) |
| Swift 6.2 | Nein |
| **Pony** | **Ja (Kompilierfehler)** |

## Standardisierte Test-Ausgabe

Alle Programme erzeugen die gleiche Ausgabestruktur:

```
=== Out-of-Bounds Test: [Sprache] ===

Array: [10, 20, 30]
Size:  3

--- Test 1: Invalid Index (10) ---
Method: [sprachspezifisch]
Result: [Fehler]

--- Test 2: Safe Access (10) ---
Method: [sprachspezifisch]
Result: [Fehler]

--- Test 3: Valid Index (1) ---
Method: [sprachspezifisch]
Result: 20

--- Test 4: Default Value ---
Method: [sprachspezifisch]
Result: -1 oder 0

--- Test 5: Iterator ---
Method: [sprachspezifisch]
[0] = 10
[1] = 20
[2] = 30
```

## Verzeichnisstruktur

```
runtime-errors/
├── README.md           # Diese Datei
├── cpp/
│   ├── README.md       # C++26 Analyse
│   ├── CMakeLists.txt
│   └── main.cpp
├── go/
│   ├── README.md       # Go 1.25.5 Analyse
│   ├── go.mod
│   └── main.go
├── pony/
│   ├── README.md       # Pony Analyse
│   └── main.pony
├── rust/
│   ├── README.md       # Rust 2024 Analyse
│   ├── Cargo.toml
│   └── main.rs
└── swift/
    ├── README.md       # Swift 6.2 Analyse
    └── main.swift
```

## Ausführen

```bash
# C++26
cd cpp && cmake -B build && cmake --build build && ./build/RuntimeErrors

# Go 1.25.5
cd go && go run main.go

# Rust 2024
cd rust && cargo run

# Swift 6.2
cd swift && swift main.swift

# Pony
cd pony && ponyc && ./pony
```

## Kernaussage

| Ansatz | Sprachen | Beschreibung |
|--------|----------|--------------|
| Opt-in Safety | C++, Go, Rust | Sichere Methoden verfügbar, aber optional |
| **Enforced Safety** | **Pony** | Nur sichere Methoden existieren |

Detaillierte Analysen in den jeweiligen Unterordnern.
