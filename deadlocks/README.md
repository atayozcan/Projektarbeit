# Deadlocks

Vergleich wie verschiedene Programmiersprachen mit Deadlocks umgehen.

## Das Problem

Ein Deadlock entsteht bei zirkulären Warteabhängigkeiten:

```
Thread 1: Hält Lock A → Wartet auf Lock B → [BLOCKED]
Thread 2: Hält Lock B → Wartet auf Lock A → [BLOCKED]
```

Keiner kann fortfahren. Das Programm hängt.

## Sprachen im Vergleich

| Sprache | Version | Deadlock möglich? | Ergebnis |
|---------|---------|-------------------|----------|
| C++ | 26 | Ja | Hängt ewig |
| Go | 1.25.5 | Ja | Hängt ewig |
| Rust | 2024 | Ja | Hängt ewig |
| Swift | 6.2 | Ja | Hängt ewig |
| **Pony** | - | **Nein** | **Terminiert** |

## Wichtige Unterscheidung

| Sprache | Data Races | Deadlocks |
|---------|------------|-----------|
| C++ | Möglich | Möglich |
| Go | Möglich | Möglich |
| Rust | **Verhindert** | Möglich |
| Swift | **Verhindert** | Möglich |
| **Pony** | **Verhindert** | **Verhindert** |

Rust und Swift verhindern Data Races, aber **nicht** Deadlocks!

## Standardisierte Test-Ausgabe

```
=== Deadlock Test: [Sprache] ===

Setup: Two threads acquiring two mutexes in opposite order
Thread 1: mutex1 -> mutex2
Thread 2: mutex2 -> mutex1

--- Running Test ---
Thread 1: Starting...
Thread 1: Locked mutex1
Thread 2: Starting...
Thread 2: Locked mutex2
Thread 1: Trying to lock mutex2...
Thread 2: Trying to lock mutex1...
[Programm hängt]
```

**Pony-Ausgabe** (einzige die terminiert):
```
Actor 1: Completed successfully!
Actor 2: Completed successfully!
```

## Verzeichnisstruktur

```
deadlocks/
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

# Rust 2024
cd rust && cargo run

# Swift 6.2
cd swift && swift main.swift

# Pony (einziges das terminiert!)
cd pony && ponyc && ./deadlocks
```

## Kernaussage

| Kategorie | Sprachen | Beschreibung |
|-----------|----------|--------------|
| Blocking | C++, Go, Rust, Swift | Locks können blockieren |
| **Non-Blocking** | **Pony** | **Asynchrone Nachrichten** |

Pony's Actor-Model verhindert Deadlocks durch Design:
- Keine Locks, keine Blocking-Operationen
- Rein asynchrone Kommunikation
