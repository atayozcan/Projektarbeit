# Memory Leaks - Rust 2024

## Implementierung

Rust verhindert die meisten Memory Leaks durch das Ownership-System.

## Ownership verhindert Leaks

```rust
{
    let data = vec![1, 2, 3, 4, 5];  // Alloziert auf Heap
}  // Automatisch freigegeben (Drop trait)
```

## Einzige Ausnahmen

### Reference Cycles mit Rc<RefCell<T>>

```rust
let node1 = Rc::new(Node { next: RefCell::new(None) });
let node2 = Rc::new(Node { next: RefCell::new(Some(Rc::clone(&node1))) });
*node1.next.borrow_mut() = Some(Rc::clone(&node2));  // LEAK!
```

### Lösung: Weak References

```rust
let node1 = Rc::new(SafeNode { next: RefCell::new(None) });
*node1.next.borrow_mut() = Some(Rc::downgrade(&node2));  // OK
```

## Kompilieren und Ausführen

```bash
cargo run
```

## Ausgabe

```
=== Memory Leak Test: Rust 2024 ===

--- Test 1: Ownership verhindert Leaks ---
Status: NO LEAK (Ownership)

--- Test 2: Reference Cycle ---
Status: LEAK (Rc count wird nie 0)

--- Test 3: Weak References ---
Status: NO LEAK (Weak references)
```

## Vergleich mit Pony

| Aspekt | Rust | Pony |
|--------|------|------|
| Speicherverwaltung | Ownership | ORCA GC |
| Reference Cycles | Möglich (Rc) | Unmöglich |
| Manuelle Arbeit | Wenig | Keine |
