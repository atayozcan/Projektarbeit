# C++26: Out-of-Bounds Fehlerbehandlung

## Verfügbare Methoden

| Methode | Typ | Sicherheit | Compiler-Zwang |
|---------|-----|------------|----------------|
| `vec[i]` | Operator | Undefiniert | Nein |
| `vec.at(i)` | Exception | Sicher | Nein |
| `std::optional<T>` | Wrapper | Sicher | Nein |
| `std::expected<T,E>` | Wrapper | Sicher + Fehlerinfo | Nein |

## Methode 1: `operator[]` (UNSICHER)

```cpp
int value = vec[10];  // Undefiniertes Verhalten!
```

- Kein Bounds-Checking
- Kann Müll lesen, abstürzen, oder "funktionieren"
- Sicherheitslücken (Buffer Overflow)

## Methode 2: `at()` mit Exception

```cpp
try {
    int value = vec.at(10);
} catch (const std::out_of_range& e) {
    // Fehlerbehandlung
}
```

- Wirft `std::out_of_range` bei ungültigem Index
- Programmierer kann try/catch vergessen

## Methode 3: `std::optional` (C++17)

```cpp
std::optional<int> try_access(const std::vector<int>& v, size_t i) {
    return (i < v.size()) ? v[i] : std::nullopt;
}

auto result = try_access(vec, 10);
int value = result.value_or(-1);  // Standardwert
```

- Explizite "vielleicht"-Semantik
- Keine Fehlerinformation

## Methode 4: `std::expected` (C++23)

```cpp
std::expected<int, std::string> safe_access(const std::vector<int>& v, size_t i) {
    if (i >= v.size()) {
        return std::unexpected("index out of bounds");
    }
    return v[i];
}

auto result = safe_access(vec, 10);
if (result) {
    use(*result);
} else {
    log(result.error());
}
```

- Ähnlich Rust `Result<T, E>`
- Fehlerinformation erhalten
- Trotzdem optional

## Vergleich mit Pony

| Aspekt | C++26 | Pony |
|--------|-------|------|
| Unsicherer Zugriff | `vec[i]` verfügbar | Nicht möglich |
| Sichere Alternative | Optional | Einzige Option |
| Compiler-Zwang | Nein | Ja |
| Fehler ignorieren | Möglich | Kompilierfehler |

## Fazit

C++26 bietet moderne, sichere Alternativen (`std::expected`, `std::optional`), aber:
- Der unsichere `operator[]` bleibt der Standard
- Der Compiler erzwingt keine sichere Variante
- Programmierer müssen aktiv sichere Methoden wählen
