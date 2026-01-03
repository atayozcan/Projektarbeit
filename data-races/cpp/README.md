Das C++ Beispiel für einen Data Race besteht aus zwei Threads, die jeweils auf eine ungeschützte
globale Variable zugreifen. Die Threads kommunizieren nicht miteinander, sondern erhöhen den
Zähler rücksichtslos. Dabei können als Endergebnis unterschiedliche Werte entstehen, wie einige
die unten aufgelistet sind.

```
Counter value: 138928
Counter value: 125950
Counter value: 101901
```

Es gibt verschiedene Strategien, um dieses Verhalten in C++ Programmen zu vermeiden.

### Mutex

Mit mutex sperrt man einen Bereich des Programms für n-1 Threads und jeder zugreifen möchte, muss warten, bis der
mutex freigegeben wird. Dies kann zu deadlocks, starvation anderer Threads etc führen.

### Atomare Operationen

Atomare Operationen sorgen dafür, dass kein Thread die Operation unterbrechen kann, während sie ausgeführt wird und
kein anderer Thread in den Prozess eingreifen kann um den Wert zwischen den Operationen ändern.

### Condition Variable

Condition Variable werden verwendet, um einen Thread zu blockieren, bis eine bestimmte Bedingung erfüllt ist.
Sie werden in Verbindung mit einem Mutex verwendet, um auf Änderungen an gemeinsam genutzten Daten zu warten oder diese
zu signalisieren.
