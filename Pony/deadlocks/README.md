Das Pony Beispiel zeigt dasselbe Muster, das in anderen Sprachen zu einem Deadlock führt.
Zwei Actors versuchen Ressourcen in umgekehrter Reihenfolge zu erwerben.
In Pony verhindert das Actor-Modell jedoch traditionelle Deadlocks durch Design:
Nachrichten werden asynchron verarbeitet und Actors blockieren nie.

```
Thread 1: Starting...
Thread 1: Locked resource1
Thread 1: Trying to lock resource2...
Thread 2: Starting...
Thread 2: Locked resource2
Thread 2: Trying to lock resource1...
Thread 1: Granting resource1 to Thread 2
Thread 2: Granting resource2 to Thread 1
Thread 1: Locked resource2
Thread 1: Completed successfully!
Thread 2: Locked resource1
Thread 2: Completed successfully!
```

Im Gegensatz zu den anderen Sprachen terminiert dieses Programm erfolgreich.
