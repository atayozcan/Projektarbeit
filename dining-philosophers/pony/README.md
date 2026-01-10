# Dining Philosophers - Pony

## Implementierung

Pony verwendet das Actor Model. Jede Gabel und jeder Philosoph ist ein Actor.

## Actor-basierte Lösung

```pony
actor Fork
  var _in_use: Bool = false

  be acquire(philosopher: Philosopher) =>
    if _in_use then
      _waiting.push(philosopher)
    else
      _in_use = true
      philosopher.got_fork()
    end
```

## Warum Pony keine Deadlocks hat

1. **Asynchrone Nachrichten**: Actors blockieren nie beim Senden
2. **Keine Locks**: Kein gegenseitiges Warten auf Ressourcen
3. **Sequentielle Verarbeitung**: Jeder Actor verarbeitet eine Nachricht nach der anderen

## Kompilieren und Ausführen

```bash
ponyc
./dining-philosophers
```

## Ausgabe

```
=== Dining Philosophers: Pony ===

Setup: 5 Philosophen, 5 Gabeln (Actors)
Deadlock-Vermeidung: Actor Model (asynchrone Nachrichten)

--- Running ---
Philosoph 0: denkt
Philosoph 1: denkt
...
```

## Kernvorteil

| Problem | Andere Sprachen | Pony |
|---------|-----------------|------|
| Deadlock | Möglich | **Unmöglich** |
| Synchronisation | Manuell | **Automatisch** |
| Korrektheit | Runtime-Tests | **Compile-Zeit** |
