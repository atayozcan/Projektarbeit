# Runtime Errors - Rust 2024

## Verfügbare Methoden

| Methode | Typ | Sicherheit | Compiler-Zwang |
|---------|-----|------------|----------------|
| `vec[i]` | Index | Panic | Nein |
| `vec.get(i)` | Option | Sicher | Nein* |
| `Result<T, E>` | Wrapper | Sicher + Info | Nein* |
| Pattern Matching | Slice | Sicher | Ja** |

*Compiler warnt bei unbenutztem `Result`, aber kompiliert
**Nur für bekannte Slice-Patterns

## Methode 1: Index-Operator (PANIC)

```rust
let value = vec[10];  // Panic bei ungültigem Index!
```

- Rust führt Bounds-Checking durch
- Ungültiger Index verursacht Panic
- Programm bricht ab (ohne `catch_unwind`)

## Methode 2: `get()` mit Option

```rust
match vec.get(10) {
    Some(value) => use(value),
    None => handle_error(),
}

// Oder mit unwrap_or
let value = vec.get(10).unwrap_or(&default);
```

- Gibt `Option<&T>` zurück
- Kein Panic möglich
- Idiomatisch in Rust

## Methode 3: `Result<T, E>` mit eigenem Fehlertyp

```rust
fn safe_access<T: Clone>(s: &[T], i: usize) -> Result<T, String> {
    if i < s.len() {
        Ok(s[i].clone())
    } else {
        Err(format!("index {} out of bounds", i))
    }
}

match safe_access(&vec, 10) {
    Ok(value) => use(value),
    Err(e) => log(e),
}
```

- Fehlerinformation erhalten
- `?` Operator für Propagation
- Compiler warnt bei unbenutztem Result

## Methode 4: Pattern Matching

```rust
match vec.as_slice() {
    [first, second, ..] => use(first, second),
    [only] => use(only),
    [] => handle_empty(),
}
```

- Compiler prüft Vollständigkeit
- Sicher zur Compile-Zeit
- Nur für bekannte Patterns

## Methode 5: Iteratoren

```rust
for (i, value) in vec.iter().enumerate() {
    println!("[{}] = {}", i, value);
}

// Oder nth()
if let Some(value) = vec.iter().nth(10) {
    use(value);
}
```

- Iteratoren sind immer sicher
- Können nicht out-of-bounds gehen

## Kompilieren und Ausführen

```bash
cargo run
```

## Vergleich mit Pony

| Aspekt | Rust 2024 | Pony |
|--------|-----------|------|
| Unsicherer Zugriff | `vec[i]` verfügbar | Nicht möglich |
| Sichere Alternative | `get()`, `Result` | Einzige Option |
| Compiler-Warnung | Ja (unused Result) | Fehler |
| Fehler ignorieren | `let _ = ...` möglich | Kompilierfehler |

## Besonderheit: `#[must_use]`

```rust
#[must_use]
fn safe_access(...) -> Result<T, E> { ... }
```

Rust warnt bei unbenutztem `Result`, aber:
- Warnung, kein Fehler
- Kann mit `let _ = ...` unterdrückt werden
- `vec[i]` hat keine Warnung

## Fazit

Rust Edition 2024 bietet exzellente Fehlerbehandlung:
- `Option<T>` und `Result<T, E>` sind erstklassige Typen
- Pattern Matching ist mächtig und sicher
- Compiler-Warnungen helfen

**Aber:**
- `vec[i]` bleibt verfügbar und ist oft kürzer
- Warnungen können ignoriert werden
- Panic ist weiterhin möglich
