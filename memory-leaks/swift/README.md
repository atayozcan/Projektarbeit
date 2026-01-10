# Memory Leaks - Swift 6.2

## Implementierung

Swift verwendet ARC (Automatic Reference Counting), aber Reference Cycles können Leaks verursachen.

## Reference Cycle Problem

```swift
class Person {
    var apartment: Apartment?
}

class Apartment {
    var tenant: Person?  // Strong reference → Cycle!
}

let john = Person()
let apt = Apartment()
john.apartment = apt
apt.tenant = john  // LEAK: Beide werden nie freigegeben
```

## Lösung: Weak References

```swift
class SafeApartment {
    weak var tenant: SafePerson?  // Weak bricht den Zyklus
}
```

## Closure Capture Cycles

```swift
class Leaker {
    var closure: (() -> Void)?

    func setupLeak() {
        closure = { print(self.name) }  // LEAK: self captured!
    }

    func setupSafe() {
        closure = { [weak self] in      // OK: weak capture
            guard let self = self else { return }
            print(self.name)
        }
    }
}
```

## Ausführen

```bash
swift main.swift
```

## Ausgabe

```
=== Memory Leak Test: Swift 6.2 ===

--- Test 1: ARC Basics ---
Status: NO LEAK (ARC)

--- Test 2: Reference Cycle ---
Status: LEAK (Reference Cycle)

--- Test 3: Weak Reference ---
Status: NO LEAK (weak reference)
```

## Vergleich mit Pony

| Aspekt | Swift | Pony |
|--------|-------|------|
| Speicherverwaltung | ARC | ORCA GC |
| Reference Cycles | Möglich | Unmöglich |
| Lösung | weak/unowned | Nicht nötig |
