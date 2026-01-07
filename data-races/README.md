# Data Races

Vergleich wie verschiedene Programmiersprachen mit Data Races umgehen.

## Das Problem

Ein Data Race tritt auf, wenn:
1. Zwei oder mehr Threads auf denselben Speicher zugreifen
2. Mindestens einer schreibt
3. Keine Synchronisation stattfindet

```
Thread 1: Liest counter (= 0)
Thread 2: Liest counter (= 0)
Thread 1: Schreibt counter = 1
Thread 2: Schreibt counter = 1  ← Inkrement verloren!
```

## Sprachen im Vergleich

| Sprache | Version | Data Race möglich? | Schutz |
|---------|---------|-------------------|--------|
| C++ | 26 | Ja | Manuell (mutex/atomic) |
| Go | 1.25.5 | Ja | Race Detector (Runtime) |
| Swift | 6.2 | Ja* | Strict Concurrency |
| Rust | 2024 | Nein | Ownership System |
| **Pony** | - | **Nein** | **Reference Capabilities** |

*Swift 6 warnt, aber erlaubt unsicheren Code

## Standardisierte Test-Ausgabe

```
=== Data Race Test: [Sprache] ===

Setup: Two threads incrementing a shared counter
Each thread: 100000 increments
Expected result: 200000

--- Running Test ---
Thread 1: Starting...
Thread 2: Starting...
Thread 1: Finished
Thread 2: Finished

--- Result ---
Counter: [Wert]
Status: RACE DETECTED / NO RACE
```

## Verzeichnisstruktur

```
data-races/
├── README.md
├── cpp/
│   ├── README.md
│   ├── CMakeLists.txt
│   └── main.cpp
├── go/
│   ├── README.md
│   ├── go.mod
│   └── main.go
├── pony/
│   ├── README.md
│   └── main.pony
├── rust/
│   ├── README.md
│   ├── Cargo.toml
│   └── main.rs
└── swift/
    ├── README.md
    └── main.swift
```

## Ausführen

```bash
# C++26
cd cpp && cmake -B build && cmake --build build && ./build/DataRaces

# Go 1.25.5 (mit Race Detector)
cd go && go run -race main.go

# Rust 2024
cd rust && cargo run

# Swift 6.2
cd swift && swift main.swift

# Pony
cd pony && ponyc && ./data-races
```

## Kernaussage

| Kategorie | Sprachen | Beschreibung |
|-----------|----------|--------------|
| Unsicher | C++, Go, Swift | Data Races möglich, Tools helfen |
| **Sicher** | **Rust, Pony** | **Compiler verhindert Data Races** |
