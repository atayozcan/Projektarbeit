# Dining Philosophers - Rust 2024

## Implementierung

Rust verwendet `Mutex<()>` für die Gabeln und `Arc` für Thread-sichere Referenzen.

## Ownership-basierte Sicherheit

```rust
fn philosopher(id: usize, left_fork: Arc<Mutex<()>>, right_fork: Arc<Mutex<()>>) {
    loop {
        let _left = left_fork.lock().unwrap();
        let _right = right_fork.lock().unwrap();
        // Essen - Locks werden automatisch freigegeben
    }
}
```

## Kompilieren und Ausführen

```bash
cargo run
```

## Ausgabe

```
=== Dining Philosophers: Rust 2024 ===

Setup: 5 Philosophen, 5 Gabeln (Mutexe)
Deadlock-Vermeidung: Letzter Philosoph greift umgekehrt

--- Running ---
Philosoph 0: denkt
Philosoph 1: denkt
...
```

## Vergleich mit Pony

| Aspekt | Rust | Pony |
|--------|------|------|
| Modell | Ownership + Mutex | Actor Model |
| Deadlock-Schutz | Manuell | Automatisch |
| Data Race | Compile-Zeit verhindert | Compile-Zeit verhindert |
| Komplexität | Mittel | Niedrig |
