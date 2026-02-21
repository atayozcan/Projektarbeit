# Rust 2024: Deadlock Demonstration

## Das Problem

```rust
let mutex1 = Arc::new(Mutex::new(0));
let mutex2 = Arc::new(Mutex::new(0));

// Thread 1
let _lock1 = mutex1.lock().unwrap();  // Holt mutex1
thread::sleep(100ms);
let _lock2 = mutex2.lock().unwrap();  // Wartet auf mutex2

// Thread 2
let _lock2 = mutex2.lock().unwrap();  // Holt mutex2
thread::sleep(100ms);
let _lock1 = mutex1.lock().unwrap();  // Wartet auf mutex1
```

Beide Threads warten ewig aufeinander → **Deadlock**

## Wichtig: Rust verhindert Deadlocks NICHT

Rust verhindert **Data Races**, aber **nicht Deadlocks**!

- Data Races: Compile-Time Fehler ✓
- Deadlocks: Weiterhin möglich ✗

## Kompilieren und Ausführen

```bash
cargo run
```

## Typische Ausgabe

```
Thread 1: Starting...
Thread 1: Locked mutex1
Thread 2: Starting...
Thread 2: Locked mutex2
Thread 1: Trying to lock mutex2...
Thread 2: Trying to lock mutex1...
[Programm hängt - Ctrl+C zum Beenden]
```

## Lösungen in Rust

### 1. Lock-Reihenfolge (manuell)
```rust
fn safe1() { let _l1 = m1.lock(); let _l2 = m2.lock(); }
fn safe2() { let _l1 = m1.lock(); let _l2 = m2.lock(); }
```

### 2. `parking_lot::ReentrantMutex`
```rust
use parking_lot::ReentrantMutex;
// Erlaubt rekursives Locking vom selben Thread
```

### 3. Channels (`mpsc`)
```rust
let (tx, rx) = mpsc::channel();
tx.send(message).unwrap();
let received = rx.recv().unwrap();
```

### 4. Actor-Pattern mit `actix`
```rust
use actix::prelude::*;
// Actor-basierte Architektur
```

## Vergleich mit Pony

| Aspekt | Rust 2024 | Pony |
|--------|-----------|------|
| Data Races | Verhindert | Verhindert |
| Deadlocks | Möglich | Verhindert |
| Locks | Arc<Mutex<T>> | Nein |
| Blocking | Ja | Nein |

## Fazit

Rust's Ownership-System verhindert Data Races, aber Deadlocks erfordern weiterhin sorgfältiges Design. Für Deadlock-freie Programme empfehlen sich Actor-Frameworks wie `actix`.
