# Leistung - Swift 6.2

## Benchmark

Sieve of Eratosthenes - Summe aller Primzahlen bis 10.000.000

## Ergebnis

- **Zeit:** ~44 ms
- **Sum:** 3203324994356

## Kompilierung

```bash
# Mit Optimierung
swiftc -O main.swift -o main

# Assembly generieren
swiftc -O -emit-assembly main.swift -o main.s
```

## Assembly-Analyse

Die Assembly ist in `main.s` (608 Zeilen).

Swift-spezifisch:
- ARC-Overhead (hier minimal)
- Array bounds checking
- Value semantics mit Copy-on-Write

## Vergleich mit Pony

| Aspekt | Swift | Pony |
|--------|-------|------|
| Performance | ~44 ms | ~46 ms |
| Speicherverwaltung | ARC | ORCA GC |
| Concurrency | Actors (seit 5.5) | Actors |
| Plattform | Apple + Linux | Cross-platform |
