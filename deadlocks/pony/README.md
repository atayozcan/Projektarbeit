# Pony: Deadlock Prevention

## Pony's Ansatz

Pony **verhindert** Deadlocks durch sein Actor-Model. Das gleiche Muster, das in anderen Sprachen zum Deadlock führt, funktioniert in Pony!

## Der Code

```pony
actor Thread1
  be acquire_resource1() =>
    // "Holt" resource1
    thread2.request_resource2(this)  // Nicht-blockierend!

actor Thread2
  be acquire_resource2() =>
    // "Holt" resource2
    thread1.request_resource1(this)  // Nicht-blockierend!
```

## Ausgabe (Erfolgreich!)

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

**Das Programm terminiert!** Im Gegensatz zu allen anderen Sprachen.

## Warum kein Deadlock?

### 1. Asynchrone Nachrichten
```pony
thread2.request_resource2(this)  // Kehrt sofort zurück!
```

Der Actor schickt eine Nachricht und arbeitet weiter. Er wartet **nicht** auf Antwort.

### 2. Keine Locks
Pony hat keine Mutexes, Semaphoren oder andere Blocking-Primitives.

### 3. Sequenzielle Nachrichtenverarbeitung
Jeder Actor verarbeitet Nachrichten in einer Queue - eine nach der anderen.

## Vergleich der Ausgaben

| Sprache | Ergebnis |
|---------|----------|
| C++ | Hängt ewig |
| Go | Hängt ewig |
| Rust | Hängt ewig |
| Swift | Hängt ewig |
| **Pony** | **Terminiert erfolgreich** |

## Das Prinzip

```
Andere Sprachen:
Thread 1: Lock A → Warte auf B → [BLOCKED]
Thread 2: Lock B → Warte auf A → [BLOCKED]
Ergebnis: DEADLOCK

Pony:
Actor 1: "Habe A" → Sende Nachricht für B → [WEITERARBEITEN]
Actor 2: "Habe B" → Sende Nachricht für A → [WEITERARBEITEN]
Ergebnis: Nachrichten werden verarbeitet, beide fertig
```

## Fazit

Pony's Actor-Model macht Deadlocks **strukturell unmöglich**:
- Keine Blocking-Operationen
- Rein asynchrone Kommunikation
- Keine geteilten Ressourcen

> "Wenn es kompiliert, kann es nicht deadlocken."
