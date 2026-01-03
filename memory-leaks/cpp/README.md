Das C++ Beispiel für ein Datenleck ruft lediglich eine Funktion auf die einen Pointer auf dem Heap alloziert.
Das Problem ist, dass der Speicher nie freigegeben wird und somit für die Dauer der Ausführung belegt bleibt.
Dies kann viel Speicher verbrauchen, wenn solche Aufrufe sehr häufig vorkommen, oder sogar zum Crash führen.

Es gibt verschiedene Strategien, um dieses Verhalten in C++ Programmen zu vermeiden.

### Smart Pointers
Smart Pointers sorgen dafür, dass der Speicher wieder freigegeben wird, sobald der Pointer nicht mehr nutzbar ist.

### Constructor and Destructor
Bei Klassen kann man neben einem Konstruktor zum Erstellen des Objekts auch einen Destruktor definieren, 
der alle Pointer löschen kann, die zur Klasse gehören.
