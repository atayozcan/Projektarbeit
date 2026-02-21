# C++26: Memory Leak Demonstration

## Das Problem

```cpp
void leak_memory() {
    auto ptr = new int[1000];
    // Funktion endet - ptr ist weg
    // Aber der Speicher bleibt alloziert!
}
```

Der allozierte Speicher wird nie freigegeben.

## Kompilieren und Ausführen

```bash
g++ -std=c++26 main.cpp -o main && ./main
```

## Typische Ausgabe

```
=== Memory Leak Test: C++26 ===

--- Test 1: Memory Leak ---
Allocating 1000 ints without freeing...
Function returned - memory NOT freed!
Status: LEAK (Speicher verloren)

--- Test 2: Safe Alternative (unique_ptr) ---
Allocating 1000 ints with unique_ptr...
Function returned - memory automatically freed!
Status: NO LEAK (RAII)
```

## Lösungen in C++

### 1. Smart Pointers (Empfohlen)
```cpp
// unique_ptr - einziger Owner
auto ptr = std::make_unique<int[]>(1000);
// Automatisch freigegeben bei Scope-Ende

// shared_ptr - mehrere Owner
auto ptr = std::make_shared<int>(42);
// Freigegeben wenn letzter Owner weg
```

### 2. RAII (Resource Acquisition Is Initialization)
```cpp
class Resource {
    int* data;
public:
    Resource() : data(new int[1000]) {}
    ~Resource() { delete[] data; }  // Destruktor gibt frei
};
```

### 3. Container statt Raw Pointers
```cpp
std::vector<int> data(1000);  // Automatisch verwaltet
```

## Leak Detection Tools

```bash
# Valgrind
valgrind --leak-check=full ./program

# AddressSanitizer
g++ -fsanitize=address -g main.cpp
./a.out
```

## Vergleich mit Pony

| Aspekt | C++26 | Pony |
|--------|-------|------|
| Memory Management | Manuell | Automatisch (GC) |
| Smart Pointers | Ja (optional) | Nicht nötig |
| Leak möglich | Ja | Nein* |
| Performance | Höchste Kontrolle | GC-Overhead |

*Pony's ORCA GC verhindert klassische Leaks

## Fazit

C++ bietet mit Smart Pointers und RAII gute Werkzeuge, aber der Programmierer muss sie aktiv nutzen. Raw `new`/`delete` sollte vermieden werden.
