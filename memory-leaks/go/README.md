Obwohl die von Google entwickelte Programmiersprache Go eine neue und moderne Sprache ist,
die auch über einen Garbage Collector verfügt, kann man trotzdem Speicherlecks zu erzeugen. Im Folgenden
ist eine Auswahl an Möglichkeiten, wie Speicherlecks entstehen können.

### Long-lived references

Solange ein Objekt aktiv ist, kann der Garbage Collector nicht eingreifen, da dieser erst nach Ausführung aufgerufen
werden kann. Dies lässt Spielraum für sogenannter Anti-Patterns, die während ihrer Laufzeit wiederholt Speicherplatz
beanspruchen.

### Goroutines

Ähnlich wie bei den long-lived references können auch GO-Routinen, die blockieren, oder lange laufen große Mengen
an Speicherplatz für sich reservieren.

### Caching without bounds

In GO ist es möglich Queues unendlich groß wachsen zu lassen. Dieser Platz kann dann erst durch das Abarbeiten
freigegeben werden.

### Cgo or unsafe code

In GO kann man C-Code einbauen und dieser kommt mit all seinen Problemen.
