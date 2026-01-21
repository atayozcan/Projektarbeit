# Leistung - Pony

## Benchmark

Sieve of Eratosthenes - Summe aller Primzahlen bis 10.000.000

## Ergebnis

- **Zeit:** ~46 ms
- **Sum:** 3203324994356

## Kompilierung

```bash
# Kompilieren
ponyc

# Assembly generieren
objdump -d -S pony > main.s
```

## Assembly-Analyse

Die Assembly ist in `main.s` (23.423 Zeilen).

Pony-spezifisch:
- Actor-Runtime-Overhead
- ORCA GC integriert
- Reference Capabilities zur Compile-Zeit

## Warum langsamer?

Pony ist für Concurrency optimiert, nicht für sequentielle Performance:
- Actor-Scheduler-Overhead
- GC-Infrastruktur
- Capability-sichere Speicherzugriffe

Bei parallelen Workloads kann Pony diese Sprachen übertreffen.

## Vergleich mit anderen Sprachen

| Aspekt | Pony | Andere |
|--------|------|--------|
| Sequentiell | ~46 ms | ~30-44 ms |
| Parallel | Exzellent | Variiert |
| Sicherheit | Garantiert | Variiert |
| Deadlock-frei | Ja | Nein |
