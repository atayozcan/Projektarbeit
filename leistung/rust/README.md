# Leistung - Rust 2024

## Benchmark

Sieve of Eratosthenes - Summe aller Primzahlen bis 10.000.000

## Ergebnis

- **Zeit:** ~30 ms
- **Sum:** 3203324994356

## Kompilierung

```bash
# Release-Build
cargo build --release

# Assembly generieren
cargo rustc --release -- --emit=asm
```

## Assembly-Analyse

Die Assembly ist in `main.s` (445 Zeilen).

Rust-Optimierungen:
- Zero-cost abstractions
- LLVM-Backend (wie C++)
- Bounds checking mit Optimierung
- Keine GC-Pausen

## Vergleich mit Pony

| Aspekt | Rust | Pony |
|--------|------|------|
| Performance | ~30 ms | ~46 ms |
| Speichersicherheit | Ownership | Capabilities |
| Concurrency | Send/Sync traits | Actor Model |
| GC | Keiner (Ownership) | ORCA |
