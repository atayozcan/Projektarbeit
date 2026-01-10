# Dining Philosophers

Vergleich wie verschiedene Programmiersprachen das klassische Dining Philosophers Problem lösen.

## Das Problem

Fünf Philosophen sitzen an einem runden Tisch. Zwischen jedem Paar von Philosophen liegt eine Gabel. Zum Essen braucht jeder Philosoph zwei Gabeln (links und rechts). Wenn alle gleichzeitig die linke Gabel nehmen, entsteht ein Deadlock.

```
     P0
   G4  G0
 P4      P1
   G3  G1
     P3
      G2
     P2
```

## Lösungsansatz

Deadlock-Vermeidung durch asymmetrische Ressourcenordnung:
- Philosophen 0-3: nehmen erst links, dann rechts
- Philosoph 4: nimmt erst rechts, dann links

## Sprachen im Vergleich

| Sprache | Version | Synchronisation | Deadlock-Schutz |
|---------|---------|-----------------|-----------------|
| C++ | 26 | std::mutex | Manuell |
| Go | 1.25.5 | Channels | Buffered Channels |
| Swift | 6.2 | Actors | Actor Isolation |
| Rust | 2024 | Mutex<T> | Ownership |
| **Pony** | - | **Actors** | **Actor Model** |

## Standardisierte Test-Ausgabe

```
=== Dining Philosophers: [Sprache] ===

Setup: 5 Philosophen, 5 Gabeln ([Mechanismus])
Deadlock-Vermeidung: [Strategie]

--- Running ---
Philosoph 0: denkt
Philosoph 1: denkt
Philosoph 0: isst
...
```

## Verzeichnisstruktur

```
dining-philosophers/
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

# Pony
cd pony && ponyc && ./dining-philosophers
```

## Kernaussage

| Ansatz | Sprachen | Beschreibung |
|--------|----------|--------------|
| Lock-basiert | C++, Rust | Mutexe mit manueller Ordnung |
| Channel-basiert | Go | Kommunikation statt Sharing |
| **Actor-basiert** | **Swift, Pony** | **Nachrichtenbasiert, kein Sharing** |
