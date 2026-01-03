# Data Races

## Was sind Data Races?

Ein Data Race tritt auf, wenn zwei oder mehr Threads gleichzeitig auf denselben Speicherbereich zugreifen und mindestens einer dieser Zugriffe ein Schreibvorgang ist. Da die Reihenfolge der Zugriffe nicht definiert ist, kann das Programm unvorhersehbare Ergebnisse liefern.

## Das Problem in traditionellen Sprachen

In Sprachen wie C++, Go und anderen traditionellen Programmiersprachen ist es einfach, versehentlich Data Races zu erzeugen. Threads teilen sich standardmäßig den Speicher, und der Programmierer muss aktiv Maßnahmen ergreifen, um den Zugriff zu synchronisieren.

### Typische Lösungsansätze

- **Mutex**: Sperrt kritische Bereiche für andere Threads
- **Atomare Operationen**: Garantieren unteilbare Lese-/Schreibvorgänge
- **Condition Variables**: Ermöglichen Threads, auf bestimmte Bedingungen zu warten

Diese Lösungen sind fehleranfällig und erfordern manuelle Sorgfalt vom Programmierer.

## Ponys Lösung: Reference Capabilities

Pony eliminiert Data Races zur Kompilierzeit durch sein innovatives System der Reference Capabilities. Jede Referenz auf ein Objekt trägt Informationen darüber, wie sie verwendet werden darf:

- **iso** (isolated): Nur ein Alias existiert, kann sicher zwischen Actors übertragen werden
- **val** (value): Unveränderlich, kann von mehreren Actors gelesen werden
- **ref** (reference): Veränderlich, aber nur innerhalb eines Actors nutzbar
- **box**: Lesezugriff, unabhängig davon ob das Original veränderlich ist
- **tag**: Nur für Identitätsvergleiche, kein Lese-/Schreibzugriff
- **trn** (transition): Schreibzugriff, kann zu val konvertiert werden

Da Actors keine veränderlichen Daten teilen können und nur über asynchrone Nachrichten kommunizieren, sind Data Races in Pony strukturell unmöglich.

## Verzeichnisstruktur

- `cpp/` - C++ Beispiel mit ungeschütztem Zähler
- `go/` - Go Beispiel mit Goroutinen
- `pony/` - Pony Beispiel mit Reference Capabilities
