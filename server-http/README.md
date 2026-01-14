# HTTP Server

## Überblick

Dieses Verzeichnis enthält Implementierungen eines einfachen HTTP-Servers in verschiedenen Programmiersprachen.
Der Server demonstriert, wie Netzwerkprogrammierung und nebenläufige Verbindungsbehandlung in den jeweiligen Sprachen umgesetzt werden.

## Nebenläufigkeit bei Servern

HTTP-Server müssen typischerweise viele gleichzeitige Verbindungen verarbeiten können.
Dies erfordert nebenläufige Programmierung, bei der die Herausforderungen der vorherigen Kapitel (Data Races, Deadlocks) besonders relevant werden.

### Go

Go verwendet Goroutinen und Channels für nebenläufige Programmierung.
Die Standardbibliothek `net/http` startet automatisch eine neue Goroutine für jede eingehende Verbindung.
Der Programmierer muss jedoch auf Data Races achten, wenn gemeinsame Daten zwischen Goroutinen geteilt werden.

### Pony

In Pony würde ein HTTP-Server das Aktormodell nutzen:
- Jede Verbindung wird von einem eigenen Actor verwaltet
- Keine Locks oder explizite Synchronisation erforderlich
- Data Races sind durch Reference Capabilities ausgeschlossen

## Verzeichnisstruktur

- `go/` - Go HTTP-Server mit der Standardbibliothek
