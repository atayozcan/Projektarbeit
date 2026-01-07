# C++26: Deadlock Demonstration

## Das Problem

```cpp
mutex mutex1, mutex2;

void thread1() {
    lock_guard lock1(mutex1);  // Holt mutex1
    sleep(100ms);
    lock_guard lock2(mutex2);  // Wartet auf mutex2
}

void thread2() {
    lock_guard lock2(mutex2);  // Holt mutex2
    sleep(100ms);
    lock_guard lock1(mutex1);  // Wartet auf mutex1
}
```

Beide Threads warten ewig aufeinander → **Deadlock**

## Typische Ausgabe

```
Thread 1: Starting...
Thread 1: Locked mutex1
Thread 2: Starting...
Thread 2: Locked mutex2
Thread 1: Trying to lock mutex2...
Thread 2: Trying to lock mutex1...
[Programm hängt - Ctrl+C zum Beenden]
```

## Lösungen in C++

### 1. `std::scoped_lock` (C++17)
```cpp
void safe_function() {
    std::scoped_lock lock(mutex1, mutex2);  // Beide gleichzeitig
    // Arbeiten...
}
```

### 2. Lock-Reihenfolge
```cpp
void thread1() { lock(m1); lock(m2); }
void thread2() { lock(m1); lock(m2); }  // Gleiche Reihenfolge!
```

### 3. `std::try_lock`
```cpp
while (!std::try_lock(mutex1, mutex2)) {
    // Kurz warten und erneut versuchen
}
```

## Vergleich mit Pony

| Aspekt | C++26 | Pony |
|--------|-------|------|
| Locks | Ja (mutex) | Nein |
| Deadlock möglich | Ja | Nein |
| Lösung | Disziplin | Architektur |
| Blocking | Ja | Nein |

## Fazit

C++ erfordert sorgfältiges Lock-Management. Der Compiler hilft nicht bei der Deadlock-Vermeidung.
