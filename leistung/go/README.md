# Leistung - Go 1.25.5

## Benchmark

Sieve of Eratosthenes - Summe aller Primzahlen bis 10.000.000

## Ergebnis

- **Zeit:** ~31 ms
- **Sum:** 3203324994356

## Kompilierung

```bash
# Kompilieren
go build -o main main.go

# Assembly generieren
go tool objdump -s "main.sumOfPrimes" main > main.s
```

## Assembly-Analyse

Die extrahierte Assembly der Hauptfunktion ist in `main.s` (88 Zeilen).

Go-spezifisch:
- Bounds checking (kann deaktiviert werden)
- GC-Overhead minimal bei diesem Benchmark
- Escape analysis optimiert Heap-Allokationen

## Vergleich mit Pony

| Aspekt | Go | Pony |
|--------|-----|------|
| Performance | ~31 ms | ~46 ms |
| Concurrency | Goroutines | Actors |
| GC | Concurrent Mark & Sweep | ORCA |
