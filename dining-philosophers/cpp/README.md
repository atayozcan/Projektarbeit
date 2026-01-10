# Dining Philosophers - C++26

## Implementierung

C++ verwendet `std::mutex` für die Gabeln und `std::thread` für die Philosophen.

## Deadlock-Vermeidung

```cpp
if (id == N - 1) {
    forks[right].lock();  // Letzter Philosoph: erst rechts
    forks[left].lock();
} else {
    forks[left].lock();   // Alle anderen: erst links
    forks[right].lock();
}
```

## Kompilieren und Ausführen

```bash
cmake -B build
cmake --build build
./build/DiningPhilosophers
```

## Ausgabe

```
=== Dining Philosophers: C++26 ===

Setup: 5 Philosophen, 5 Gabeln (Mutexe)
Deadlock-Vermeidung: Letzter Philosoph greift umgekehrt

--- Running ---
Philosoph 0: denkt
Philosoph 1: denkt
...
```

## Vergleich mit Pony

| Aspekt | C++ | Pony |
|--------|-----|------|
| Synchronisation | Manuell (mutex) | Automatisch (Actors) |
| Deadlock-Schutz | Manuelle Ordnung | Actor Model |
| Komplexität | Hoch | Niedrig |
