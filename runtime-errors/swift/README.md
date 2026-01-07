# Swift 6.2: Out-of-Bounds Fehlerbehandlung

## Swift 6.2 Features verwendet

- **Typed Throws** (`throws(ErrorType)`) - Compiler kennt den genauen Fehlertyp
- **Custom Error Types** - Präzise Fehlerinformationen

## Verfügbare Methoden

| Methode | Typ | Sicherheit | Compiler-Zwang |
|---------|-----|------------|----------------|
| `arr[i]` | Subscript | Fatal Error | Nein |
| `throws(IndexError)` | Typed Throws | Sicher | Teilweise* |
| `arr.first`, `arr.last` | Property | Optional | Nein |

*Typed Throws erzwingt Fehlerbehandlung im `do/catch` Block

## Typed Throws (Swift 6 Feature)

```swift
// Früher: throws - Compiler weiß nicht welcher Fehler
func oldAccess(_ i: Int) throws -> Element

// Swift 6: throws(IndexError) - Compiler kennt den Typ!
func safeAccess(_ i: Int) throws(IndexError) -> Element {
    guard indices.contains(i) else {
        throw .outOfBounds(index: i, size: count)
    }
    return self[i]
}
```

### Vorteile von Typed Throws

```swift
do {
    let value = try arr.safeAccess(10)
} catch {
    // error ist automatisch IndexError - kein casting!
    print(error.index)  // Direkter Zugriff
}
```

## Methode 1: Subscript `[]` (FATAL ERROR)

```swift
let value = arr[10]  // Fatal error: Index out of range
```

- Kein `try/catch` möglich
- Programm crasht sofort

## Methode 2: Typed Throws (Swift 6)

```swift
do {
    let value = try arr.safeAccess(10)
    use(value)
} catch {
    print("Error: \(error)")
}
```

- Compiler weiß: `error` ist `IndexError`
- Kein `as?` casting nötig
- Exhaustive Fehlerbehandlung möglich

## Methode 3: Optional mit nil-coalescing

```swift
let value = arr.tryAccess(10) ?? defaultValue
```

- Kein throw, nur `nil`
- Kompakt für einfache Fälle

## Vergleich mit Pony

| Aspekt | Swift 6.2 | Pony |
|--------|-----------|------|
| Standard-Zugriff | Fatal Error | Behandelbarer Error |
| Typed Errors | Ja (`throws(T)`) | Ja (`error`) |
| Compiler-Zwang | Teilweise | Vollständig |
| Fehler ignorieren | Möglich (mit `try!`) | Unmöglich |

## Typed Throws vs. Pony's `?`

### Swift 6.2
```swift
func access(_ i: Int) throws(IndexError) -> Int
// Muss mit do/catch oder try! aufgerufen werden
```

### Pony
```pony
fun apply(i: USize): Int ?
// MUSS in try Block sein - sonst Compile Error
```

**Unterschied**: Swift erlaubt `try!` zum Ignorieren, Pony nicht.

## Fazit

Swift 6.2's Typed Throws ist ein großer Fortschritt:
- Präzise Fehlertypen im Typsystem
- Bessere IDE-Unterstützung
- Exhaustive `catch` Blöcke

Aber: Array-Subscript `[]` bleibt unsicher und `try!` erlaubt Ignorieren.

## Quellen

- [Swift 6.2 Released](https://www.swift.org/blog/swift-6.2-released/)
- [What's new in Swift 6.2](https://www.hackingwithswift.com/articles/277/whats-new-in-swift-6-2)
