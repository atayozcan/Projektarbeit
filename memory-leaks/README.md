# Memory Leaks

## Was sind Memory Leaks?

Ein Memory Leak (Speicherleck) entsteht, wenn ein Programm Speicher auf dem Heap alloziert, diesen aber nie wieder freigibt. Der Speicher bleibt für die gesamte Laufzeit des Programms belegt und kann nicht wiederverwendet werden. Bei häufigen Allokationen kann dies zu erhöhtem Speicherverbrauch oder sogar zum Programmabsturz führen.

## Das Problem in traditionellen Sprachen

In C++ und anderen Sprachen mit manueller Speicherverwaltung muss der Programmierer selbst dafür sorgen, dass allozierter Speicher wieder freigegeben wird. Dies ist besonders fehleranfällig bei:

- Komplexen Kontrollflüssen mit mehreren Rückgabepunkten
- Exceptions, die vor der Freigabe auftreten
- Vergessenen `delete`/`free` Aufrufen
- Zirkulären Referenzen

### Typische Lösungsansätze in C++

- **Smart Pointers**: `unique_ptr`, `shared_ptr` geben Speicher automatisch frei
- **RAII**: Resource Acquisition Is Initialization - Ressourcen werden im Destruktor freigegeben
- **Garbage Collection**: In anderen Sprachen wie Java oder Go (nicht in C++)

## Ponys Lösung: Garbage Collection mit ORCA

Pony verwendet einen innovativen Garbage Collector namens ORCA (Ownership and Reference Counting for Actors):

- **Kein Stop-the-World**: Jeder Actor hat seinen eigenen Heap und GC
- **Keine GC-Pausen**: Die Garbage Collection läuft nebenläufig
- **Automatische Freigabe**: Der Programmierer muss sich nicht um Speicherfreigabe kümmern
- **Reference Capabilities**: Ermöglichen effiziente Speicherübertragung zwischen Actors

Da Pony eine speichersichere Sprache ist und Garbage Collection verwendet, sind klassische Memory Leaks praktisch ausgeschlossen.

## Verzeichnisstruktur

- `cpp/` - C++ Beispiel mit vergessener Speicherfreigabe
- `go/` - Go Beispiel mit Goroutine-Leaks
