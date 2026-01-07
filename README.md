# Pony

Pony ist eine objektorientierte open-source Programmiersprache mit Aktormodell,
das 2015 veröffentlicht wurde. Die Sprache verspricht gute Performance für Anwendungen
mit hoher Parallelität ohne deadlocks, oder anderen typischen Problemen, unter denen die
meisten Programmiersprachen leiden.

## Pony Features

### Aktormodell

Aktoren sind Modelle für nebenläufige Programme, die ausschließlich asynchron Nachrichten austauschen.
Das sorgt dafür, dass der Aktor nicht auf eine Nachricht warten muss und stattdessen weiter agieren kann.
Die Nachrichten müssen nicht in der Reihenfolge ankommen, in der sie versendet werden.
Jeder Aktor verfügt dabei über seinen eigenen Speicherbereich, den er mit keinem anderen Aktor teilt.
Da Aktoren Nachrichten asynchron abarbeiten und keine anderer Prozess Zugriff auf den Speicherbereich hat,
ist der Ablauf innerhalb des Aktors sequenziell. Der Nachteil ist, dass Informationen mehrfach vorliegen
können, da kein Speicherbereich geteilt werden kann.

### Typensicher

Die Typen in Pony sind statisch, d.h. der Typ der Variable ist zur Kompilierung bekannt und daher werden
Fehler zur Compilezeit erkannt. Gegenbeispiele hierzu sind Python und JavaScript, die erst zur Laufzeit den Typ prüfen.

### Speichersicher

Pony hat keine Buffer, Pointer oder NULL.

### Keine Exceptions

Es gibt keine Laufzeitfehler. Über die Semantik werden Fehler beim Kompilieren erkannt.
Sobald ein Programm erfolgreich kompiliert können keine Laufzeitfehler mehr entstehen.

### Keine data-races

Jeder Aktor steht für einen Thread und das Typsystem von Pony stellt zur Kompilierungszeit
sicher, dass keine data-races auftreten.

### Keine deadlocks

Es gibt keine Lock, da die Aktoren keinen geteilten Speicherbereich haben
und innerhalb der Aktoren Anweisungen sequenziell laufen. Pony erlaubt nur die Weitergabe
von unveränderlichen Daten über Referenzen.

### Nativer Code

Pony hat einen Compiler, der den code zunächst in Zwischencode umwandelt und optimiert.

### C kompatibel

Pony Programme können in C-Code übersetzt werden.

## Nachteile

### Mangelnde API-Stabilität
Pony hat die Version 1.0 noch nicht erreicht.

### Mangel an hochwertigen Bibliotheken von Drittanbietern
Aktuell gibt es nur die eigene Bibliothek.

### Begrenzte native Werkzeuge
Keine IDE unterstützt die Pony Language. Auch Analyse Tools sind derzeit nicht verfügbar.
