# C++26: Data Race Demonstration

## Das Problem

```cpp
int counter = 0;

void increment() {
    for (int i = 0; i < 100000; ++i) {
        ++counter;  // UNSICHER!
    }
}

thread t1(increment);
thread t2(increment);
```

Zwei Threads inkrementieren denselben Zähler ohne Synchronisation.

## Warum ist das ein Problem?

`++counter` ist **nicht atomar**. Es besteht aus:
1. Lesen des aktuellen Werts
2. Inkrementieren
3. Zurückschreiben

Wenn beide Threads gleichzeitig lesen, geht ein Inkrement verloren.

## Typische Ergebnisse

| Durchlauf | Erwartet | Tatsächlich |
|-----------|----------|-------------|
| 1 | 200,000 | 138,928 |
| 2 | 200,000 | 125,950 |
| 3 | 200,000 | 101,901 |

## Lösungen in C++

### 1. `std::mutex`
```cpp
std::mutex mtx;
void increment() {
    for (...) {
        std::lock_guard<std::mutex> lock(mtx);
        ++counter;
    }
}
```

### 2. `std::atomic`
```cpp
std::atomic<int> counter{0};
void increment() {
    for (...) {
        ++counter;  // Atomar und sicher
    }
}
```

### 3. Condition Variable
```cpp
std::condition_variable cv;
// Blockiert Thread bis Bedingung erfüllt
```

## Vergleich mit Pony

| Aspekt | C++26 | Pony |
|--------|-------|------|
| Shared Memory | Standard | Verboten |
| Synchronisation | Manuell (mutex/atomic) | Automatisch (Actors) |
| Compiler-Schutz | Nein | Ja |
| Data Race möglich | Ja | Nein |

## Fazit

C++ erlaubt unsynchronisierten Zugriff auf gemeinsamen Speicher. Der Programmierer muss aktiv Synchronisation hinzufügen.
