# Vorstellung

## Überblick

Dieses Verzeichnis enthält einführende Beispiele, die die grundlegenden Sprachkonzepte von Pony demonstrieren.

## Pony Grundkonzepte

Das Beispiel zeigt verschiedene Kernkonzepte der Sprache Pony:

### Interfaces

Pony verwendet strukturelles Subtyping. Ein Interface definiert eine Menge von Methoden, die ein Typ implementieren muss:

```pony
interface Shape
  fun ref get_coord(): Coord
  fun ref get_sides(): U8
```

### Klassen

Klassen in Pony können mehrere Konstruktoren haben und Interfaces implementieren:

```
class Triangle is Shape
  let _sides: U8 = 3
  var _coord: Coord
  new create(coord: Coord) => _coord = coord
  new create_empty() => _coord = Coord()
```

### Actors

Der Einstiegspunkt eines Pony-Programms ist immer ein Actor namens `Main`:

```
actor Main
  new create(env: Env) =>
    // Programmlogik
```

### Variablen

- `let`: Unveränderliche Bindung (wie `const` in anderen Sprachen)
- `var`: Veränderliche Bindung

## Verzeichnisstruktur

- `pony/` - Einführendes Pony-Beispiel mit Shapes
