# Data Races - Rust 2024

## Rust's Ansatz

Rust **verhindert** Data Races zur Compile-Zeit!

```rust
// DIESER CODE KOMPILIERT NICHT:
let mut counter = 0;
thread::spawn(|| {
    counter += 1;  // ERROR: cannot borrow `counter` as mutable
});
```

## Warum kompiliert das nicht?

Rust's Ownership-System:
1. Ein Wert kann nur **einen** mutablen Owner haben
2. Oder **mehrere** immutable Referenzen
3. **Nie** beides gleichzeitig

## Sichere Alternativen

### 1. `Arc<Mutex<T>>`
```rust
let counter = Arc::new(Mutex::new(0));
let c1 = Arc::clone(&counter);

thread::spawn(move || {
    let mut num = c1.lock().unwrap();
    *num += 1;
});
```

### 2. `Arc<AtomicI32>`
```rust
let counter = Arc::new(AtomicI32::new(0));
let c1 = Arc::clone(&counter);

thread::spawn(move || {
    c1.fetch_add(1, Ordering::Relaxed);
});
```

### 3. Channels (`mpsc`)
```rust
let (tx, rx) = mpsc::channel();
thread::spawn(move || {
    tx.send(1).unwrap();
});
let value = rx.recv().unwrap();
```

## Kompilieren und Ausführen

```bash
cargo run
```

## Vergleich mit Pony

| Aspekt | Rust 2024 | Pony |
|--------|-----------|------|
| Compile-Time Schutz | Ja | Ja |
| Mechanismus | Ownership + Borrowing | Reference Capabilities |
| Shared Mutable State | Mit `Arc<Mutex>` | Nie (nur Actors) |
| Lernkurve | Steil | Mittel |

## Ähnlichkeiten

Beide Sprachen verhindern Data Races durch ihr Typsystem:
- **Rust**: "Nur ein mutabler Owner"
- **Pony**: "Mutable Daten können nicht geteilt werden"

## Fazit

Rust und Pony sind die einzigen Mainstream-Sprachen, die Data Races **strukturell** verhindern. Rust durch Ownership, Pony durch Reference Capabilities.
