# Runtime Errors - Pony

## Verfügbare Methoden

| Methode | Typ | Sicherheit | Compiler-Zwang |
|---------|-----|------------|----------------|
| `arr(i)?` | Partial | Sicher | **Ja** |

Es gibt **nur eine Methode** für Array-Zugriffe in Pony.

## Die einzige Methode: `try`/`else`

```pony
try
  let value = arr(10)?  // ? markiert partielle Funktion
  use(value)
else
  handle_error()
end
```

- `?` markiert, dass die Operation fehlschlagen kann
- `try`/`else` Block ist **erforderlich**
- Compiler **erzwingt** Fehlerbehandlung

## Variante: Standardwert

```pony
let value = try arr(10)? else 0 end
```

- Kompakte Syntax für Standardwerte
- Fehlerfall wird behandelt (mit Standardwert)

## Variante: Mit `then` (Cleanup)

```pony
try
  let value = arr(10)?
  use(value)
then
  cleanup()  // Wird IMMER ausgeführt (wie finally)
else
  handle_error()
end
```

## Iterator (immer sicher)

```pony
for value in arr.values() do
  use(value)
end
```

- Iteratoren können nicht out-of-bounds gehen
- Keine Fehlerbehandlung nötig

## Was der Compiler VERHINDERT

```pony
// FEHLER: Partielle Funktion außerhalb von try
let value = arr(0)?

// FEHLER: Fehlendes ? bei partiellem Zugriff
try
  let value = arr(0)  // Kompilierfehler!
end

// FEHLER: Fehlendes else
try
  let value = arr(0)?
end  // Kompilierfehler!
```

## Kompilieren und Ausführen

```bash
ponyc && ./pony
```

## Vergleich mit anderen Sprachen

| Aspekt | C++26 | Go 1.25.5 | Rust 2024 | **Pony** |
|--------|-------|-----------|-----------|----------|
| Standard-Zugriff | `vec[i]` | `slice[i]` | `vec[i]` | `arr(i)?` |
| Unsicher? | Ja | Ja (Panic) | Ja (Panic) | **Nein** |
| Sichere Alternative | Optional | Optional | Optional | **Einzige** |
| Compiler-Zwang | Nein | Nein | Warnung | **Fehler** |
| Fehler ignorieren | Möglich | Möglich | Möglich | **Unmöglich** |

## Warum dieser Ansatz?

### Andere Sprachen: "Opt-in Safety"
```
Unsicherer Weg verfügbar → Programmierer wählt sicheren Weg → Hoffentlich
```

### Pony: "Enforced Safety"
```
Nur sicherer Weg existiert → Compiler prüft → Garantiert
```

## Analogie

| Ansatz | Beschreibung |
|--------|--------------|
| C++/Go/Rust | "Hier ist ein Sicherheitsgurt, bitte anschnallen" |
| **Pony** | "Das Auto startet nur, wenn Sie angeschnallt sind" |

## Fazit

Pony's Ansatz eliminiert eine ganze Fehlerklasse durch Design:
- Es gibt **keine unsichere Alternative**
- Der Compiler **erzwingt** korrekte Fehlerbehandlung
- Unbehandelte Out-of-Bounds-Fehler sind **strukturell unmöglich**

Dies ist Teil von Pony's Philosophie: Sicherheit sollte nicht optional sein.
