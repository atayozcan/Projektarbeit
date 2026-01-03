# TCP Server

## Überblick

Dieses Verzeichnis enthält Implementierungen eines TCP-Servers und -Clients in verschiedenen Programmiersprachen. Im Gegensatz zum HTTP-Server arbeiten diese Beispiele direkt auf der TCP-Ebene und demonstrieren die Low-Level-Netzwerkprogrammierung.

## TCP vs. HTTP

- **TCP**: Transportprotokoll, stellt zuverlässige Byte-Streams bereit
- **HTTP**: Anwendungsprotokoll, das auf TCP aufbaut

Die direkte TCP-Programmierung gibt mehr Kontrolle, erfordert aber auch mehr manuellen Aufwand für Protokollhandling.

## Nebenläufige Verbindungsbehandlung

### Go

Go verwendet Goroutinen für nebenläufige Verbindungen:
- Einfache Syntax mit `go` Keyword
- Channels für Kommunikation zwischen Goroutinen
- Der Programmierer muss auf korrekte Synchronisation achten

### Pony

Pony nutzt das Aktormodell:
- Jede Verbindung wird von einem eigenen Actor verwaltet
- Asynchrone Nachrichtenverarbeitung ohne Blocking
- Keine expliziten Locks oder Synchronisationsprimitive nötig
- Reference Capabilities garantieren Speichersicherheit

Der Pony-Server demonstriert, wie das Aktormodell natürlich zu nebenläufigem Code führt, ohne die typischen Probleme wie Data Races oder Deadlocks.

## Verzeichnisstruktur

- `go/` - Go TCP-Server und -Client
- `pony/` - Pony TCP-Server und -Client mit dem Aktormodell
