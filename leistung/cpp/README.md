# Leistung - C++26

## Benchmark

Sieve of Eratosthenes - Summe aller Primzahlen bis 10.000.000

## Ergebnis

- **Zeit:** ~32 ms
- **Sum:** 3203324994356

## Kompilierung

```bash
# Mit Optimierung
g++ -std=c++26 -O3 main.cpp -o main

# Assembly generieren
g++ -std=c++26 -O3 -S main.cpp -o main.s
```

## Assembly-Analyse

Die vollständige Assembly ist in `main.s` (30.622 Zeilen).

Optimierungen durch -O3:
- Loop unrolling
- SIMD-Vektorisierung
- Inline-Funktionen

## Vergleich mit Pony

| Aspekt | C++ | Pony |
|--------|-----|------|
| Performance | ~32 ms | ~46 ms |
| Speicherverwaltung | Manuell/RAII | ORCA GC |
| Kompilierung | Schnell | Mittel |
