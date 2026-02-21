# Data Races - Pony

## Pony's Ansatz

Pony **verhindert** Data Races durch Design. Es ist **unmöglich**, unsicheren Code zu schreiben.

## Warum keine Data Races?

### 1. Actor Model
Jeder Actor hat seinen eigenen Zustand. Kein Sharing.

```pony
actor Counter
  var _value: U32 = 0  // Nur dieser Actor kann zugreifen

  be increment() =>
    _value = _value + 1  // Immer sicher
```

### 2. Reference Capabilities
Pony's Typsystem verhindert gefährliches Sharing:

| Capability | Lesen | Schreiben | Teilen |
|------------|-------|-----------|--------|
| `iso` | Ja | Ja | Nein (isoliert) |
| `val` | Ja | Nein | Ja (immutable) |
| `ref` | Ja | Ja | Nein (lokal) |
| `box` | Ja | Nein | Ja (read-only) |
| `tag` | Nein | Nein | Ja (identity) |

### 3. Regel
> Mutable Daten können **nicht** zwischen Actors geteilt werden.

Entweder:
- **Isoliert** (`iso`): Nur ein Owner, kann übergeben werden
- **Immutable** (`val`): Kann geteilt werden, aber nicht verändert

## Beispiel: Sicherer Counter

```pony
actor Counter
  var _value: U32 = 0

  be increment(times: U32) =>
    var i: U32 = 0
    while i < times do
      _value = _value + 1
      i = i + 1
    end

actor Main
  new create(env: Env) =>
    let counter = Counter
    counter.increment(100000)  // Nachricht 1
    counter.increment(100000)  // Nachricht 2
    // Nachrichten werden sequentiell verarbeitet
    // Ergebnis: IMMER 200000
```

## Kompilieren und Ausführen

```bash
ponyc && ./pony
```

## Vergleich mit anderen Sprachen

| Sprache | Verhindert Data Races? | Wie? |
|---------|------------------------|------|
| C++ | Nein | - |
| Go | Nein | Race Detector (Runtime) |
| Swift | Teilweise | Actor Warnungen |
| Rust | Ja | Ownership |
| **Pony** | **Ja** | **Reference Capabilities** |

## Fazit

Pony ist die einzige Sprache, die Data Races **vollständig** durch das Typsystem verhindert, ohne Runtime-Checks oder manuelle Synchronisation.

Die Philosophie:
> "Wenn es kompiliert, hat es keine Data Races."
