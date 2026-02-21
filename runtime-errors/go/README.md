# Go 1.25.5: Out-of-Bounds Fehlerbehandlung

## Verfügbare Methoden

| Methode | Typ | Sicherheit | Compiler-Zwang |
|---------|-----|------------|----------------|
| `slice[i]` | Direkt | Panic | Nein |
| `if i < len(s)` | Manuell | Sicher | Nein |
| `value, ok := fn()` | ok-Pattern | Sicher | Nein |
| `value, err := fn()` | error-Pattern | Sicher + Info | Nein |

## Methode 1: Direkter Zugriff (PANIC)

```go
value := slice[10]  // Panic bei ungültigem Index!
```

- Go führt Bounds-Checking durch
- Ungültiger Index verursacht Panic
- Programm bricht ab (ohne `recover`)

## Methode 2: Manuelle Prüfung

```go
if index >= 0 && index < len(slice) {
    value := slice[index]
} else {
    // Fehlerbehandlung
}
```

- Sicher, aber repetitiv
- Muss bei jedem Zugriff wiederholt werden

## Methode 3: ok-Pattern (wie Maps)

```go
func tryAccess[T any](s []T, i int) (T, bool) {
    var zero T
    if i < 0 || i >= len(s) {
        return zero, false
    }
    return s[i], true
}

if value, ok := tryAccess(slice, 10); ok {
    use(value)
}
```

- Konsistent mit Map-Zugriff: `value, ok := m[key]`
- Kein Panic möglich
- Keine Fehlerinformation

## Methode 4: error-Pattern (idiomatisch)

```go
func safeAccess[T any](s []T, i int) (T, error) {
    var zero T
    if i < 0 || i >= len(s) {
        return zero, fmt.Errorf("index %d out of bounds", i)
    }
    return s[i], nil
}

value, err := safeAccess(slice, 10)
if err != nil {
    log(err)
}
```

- Go-idiomatisch
- Fehlerinformation erhalten
- **ABER:** Fehler kann ignoriert werden!

```go
value, _ := safeAccess(slice, 10)  // Kompiliert!
```

## Kompilieren und Ausführen

```bash
go run main.go
```

## Vergleich mit Pony

| Aspekt | Go 1.25.5 | Pony |
|--------|-----------|------|
| Direkter Zugriff | Panic | Error (behandelbar) |
| Fehler ignorieren | `_, err` möglich | Kompilierfehler |
| Compiler-Zwang | Nein | Ja |
| Eingebaute Sicherheit | Nur Maps (`ok`) | Alle Collections |

## Fazit

Go 1.25.5 hat gute Konventionen für Fehlerbehandlung:
- `if err != nil` ist idiomatisch und weit verbreitet
- Generics ermöglichen typsichere Hilfsfunktionen

**Aber:**
- Slices haben kein eingebautes ok-Pattern (Maps schon)
- Fehler können mit `_` explizit ignoriert werden
- Der Compiler akzeptiert unsicheren Code
