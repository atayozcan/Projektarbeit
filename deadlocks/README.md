# Deadlocks

## Was sind Deadlocks?

Ein Deadlock entsteht, wenn zwei oder mehr Threads gegenseitig auf Ressourcen warten, die der jeweils andere hält. Keiner der Threads kann fortfahren, da jeder auf die Freigabe durch den anderen wartet. Das Programm bleibt in diesem Zustand hängen.

## Das Problem in traditionellen Sprachen

In C++, Go, Rust, Swift und anderen Sprachen, die Locks zur Synchronisation verwenden, sind Deadlocks ein häufiges Problem. Das klassische Szenario:

1. Thread A hält Lock 1 und wartet auf Lock 2
2. Thread B hält Lock 2 und wartet auf Lock 1
3. Beide Threads warten ewig aufeinander

### Typische Lösungsansätze

- **Lock-Reihenfolge**: Alle Threads müssen Locks in derselben Reihenfolge anfordern
- **Timeout**: Locks werden nach einer bestimmten Zeit freigegeben
- **Deadlock-Erkennung**: Das System erkennt und löst Deadlocks auf
- **Try-Lock**: Nicht-blockierendes Anfordern von Locks

Diese Lösungen sind komplex, fehleranfällig und erfordern disziplinierte Programmierung.

## Ponys Lösung: Das Aktormodell

Pony verwendet das Aktormodell, das Deadlocks strukturell verhindert:

- **Keine Shared Memory**: Actors teilen keinen veränderlichen Speicher
- **Asynchrone Nachrichten**: Kommunikation erfolgt über nicht-blockierende Nachrichten
- **Keine Locks**: Da kein gemeinsamer Speicher existiert, sind Locks überflüssig
- **Sequenzielle Verarbeitung**: Innerhalb eines Actors werden Nachrichten sequenziell abgearbeitet

Da Actors niemals blockieren und keine Ressourcen im traditionellen Sinne "halten", können keine zirkulären Warteabhängigkeiten entstehen.

## Verzeichnisstruktur

- `cpp/` - C++ Beispiel mit zwei Mutexen
- `go/` - Go Beispiel mit Goroutinen und Mutex
- `pony/` - Pony Beispiel mit dem Aktormodell
- `rust/` - Rust Beispiel mit Mutex
- `swift/` - Swift Beispiel mit DispatchQueue
