Das Go Beispiel für einen data race besteht aus zwei Threads, die einer globalen Variable einen zuweisen wollen.
Je nachdem, in welcher Reihenfolge die Schritte ausgeführt werden hat die Variable x entweder den Wert drei oder vier.
Dieses Verhalten nennt man data race, da es vom Zufall abhängt welcher Wert die Variable am Ende bekommt.
Um das Verhalten des Programms zu analysieren, kann man sein Trace nachbilden und durch Umordnung der Anweisungen
ein data race identifizieren.

### Trace ohne data race
```
     T1          T2
e1. w(x)
e2. acq(y)
e3. rel(y)
e4.              acq(y)
e5.              w(x)
e6.              rel(y)
```

### Trace mit data race
```
     T1          T2
e2. acq(y)
e3. rel(y)
e4.             acq(y)
e1. w(x)
e5.             w(x)
e6.             rel(y)
```
