# Leistung (Performance)

Vergleich der Ausführungsgeschwindigkeit verschiedener Programmiersprachen.

## Benchmark

**Algorithmus:** Sieve of Eratosthenes - Summe aller Primzahlen bis 10.000.000

Dieser Benchmark testet:
- Speicherallokation (Array mit 10M Elementen)
- CPU-gebundene Berechnungen (Sieb-Algorithmus)
- Schleifenoptimierung

## Ergebnisse (mit maximaler Optimierung)

| Sprache | Version | Optimierung | Zeit (Avg) | Min | Max | Rang |
|---------|---------|-------------|------------|-----|-----|------|
| **Rust** | 2024 | target-cpu=native | ~24 ms | 22 ms | 27 ms | 1 |
| **Swift** | 6.2 | -Ounchecked | ~24 ms | 22 ms | 29 ms | 2 |
| **Pony** | - | -s (strip) | ~25 ms | 20 ms | 33 ms | 3 |
| **Go** | 1.25.5 | Standard | ~26 ms | 23 ms | 30 ms | 4 |
| **C++** | 26 | -O3 -flto -march=native | ~29 ms | 27 ms | 33 ms | 5 |

*Alle Tests: Sum = 3203324994356 (korrekt)*

**Fazit:** Mit maximaler Optimierung sind alle Sprachen innerhalb von ~5ms gleichauf!

---

## Optimierungen pro Sprache

### C++
```bash
g++ -std=c++26 -O3 -march=native -flto -ffast-math main.cpp -o main
```
- `-O3`: Maximale Optimierung
- `-march=native`: CPU-spezifische Instruktionen (AVX, SSE)
- `-flto`: Link-Time Optimization (entfernt unbenutzen Code)
- `-ffast-math`: Aggressive Floating-Point-Optimierung

### Go
```bash
go build -ldflags="-s -w" -o main main.go
```
- `-s -w`: Strip debug info (kleinere Binary)
- Go optimiert automatisch, keine weiteren Flags nötig

### Rust
```bash
RUSTFLAGS="-C target-cpu=native" cargo build --release
```
- `--release`: Optimierungen aktiviert
- `target-cpu=native`: CPU-spezifische Instruktionen

### Swift
```bash
swiftc -O -whole-module-optimization -Ounchecked main.swift -o main
```
- `-O`: Standard-Optimierung
- `-whole-module-optimization`: Cross-File-Optimierung
- `-Ounchecked`: Bounds-Checks entfernen (gefährlich!)

### Pony
```bash
ponyc -s -o .
```
- `-s`: Strip debug info
- Pony optimiert automatisch via LLVM

---

## Assembly-Vergleich (Vollständige Binaries)

| Sprache | Assembly-Größe | Compiler/Backend | Inhalt |
|---------|----------------|------------------|--------|
| Swift | 700 Zeilen | LLVM | Minimaler Code, Foundation extern |
| C++ | 4.859 Zeilen | GCC + LTO | Templates reduziert durch LTO |
| Pony | 23.423 Zeilen | LLVM | Komplette Actor Runtime + ORCA GC |
| Rust | 72.165 Zeilen | LLVM | Stdlib + Panic Handler |
| Go | 182.282 Zeilen | gc | Komplette Runtime + GC |

### Warum so unterschiedlich?

**Swift (700 Zeilen):**
- Foundation-Framework ist dynamisch gelinkt
- Nur der eigene Code ist in der Assembly

**C++ (4.859 Zeilen):**
- LTO entfernt unbenutzten Template-Code
- Ohne LTO: 30.622 Zeilen!

**Pony (23.423 Zeilen):**
- Actor Runtime ist statisch gelinkt
- ORCA GC vollständig eingebettet
- Message Queue System

**Rust (72.165 Zeilen):**
- Panic Handler und Unwinding
- Standard Library Teile
- Keine dynamischen Abhängigkeiten

**Go (182.282 Zeilen):**
- Komplette Go Runtime
- Garbage Collector
- Goroutine Scheduler
- Reflection Support

---

## Assembly-Ausschnitte

### C++ (Inner Loop)
```asm
.L345:
    movq    %rax, %r8
    movl    %eax, %ecx
    addq    %rsi, %rax
    shrq    $6, %r8
    salq    %cl, %rdx
    notq    %rdx
    andq    %rdx, (%rdi,%r8,8)    ; Bit-Manipulation für Sieve
    cmpl    %eax, %ebp
    jge     .L345
```

### Go (Sieve Loop)
```asm
mark_composite:
    MOVB   $0x0, 0(DX)(BX*1)      ; sieve[j] = false
    ADDQ   SI, BX                  ; j += i
    CMPQ   AX, BX
    JL     mark_composite
```

### Rust (Sieve Loop)
```asm
.LBB4_13:
    movb    $0, (%rbx,%r8)        ; sieve[j] = false
    addq    %rcx, %r8             ; j += i
    cmpq    $10000001, %r8
    jb      .LBB4_13
```

### Swift (Sieve Loop)
```asm
.loop:
    movb    $0, (%r14,%rbx)       ; sieve[j] = false
    addq    %r12, %rbx            ; j += i
    cmpq    %r15, %rbx
    jb      .loop
```

### Pony (Actor + Sieve)
```asm
; Actor Setup (Overhead)
    call   pony_init
    call   pony_create
    call   pony_gc_send
; Sieve Loop (ähnlich wie andere)
.loop:
    movb   $0x0, (%rbx,%r8)
    add    %rcx, %r8
    cmp    $0x989681, %r8
    jb     .loop
```

---

## Performance-Analyse

### Alle Sprachen sind gleich schnell!

Mit maximaler Optimierung sind die Unterschiede minimal (~5ms):

| Faktor | Auswirkung |
|--------|------------|
| CPU-native Instruktionen | +10-20% Performance |
| LTO / Dead Code Elimination | Kleinere Binary |
| Bounds-Check Elimination | +5-10% (wenn unsicher) |

### Der eigentliche Sieve-Loop ist identisch

Alle Compiler generieren praktisch den gleichen Inner Loop:
```asm
; Pseudocode für alle Sprachen:
.loop:
    mov    $0, (base + index)     ; sieve[j] = false
    add    step, index            ; j += i
    cmp    limit, index           ; j <= limit?
    jl     .loop
```

### Unterschiede kommen von:

1. **Runtime-Overhead:** Go und Pony haben größere Runtimes
2. **GC:** Go's GC kann pausieren, Pony's ORCA ist concurrent
3. **Bounds-Checks:** Swift/Go prüfen Array-Grenzen
4. **Binary-Größe:** Mehr Code = mehr Cache-Misses

---

## Verzeichnisstruktur

```
leistung/
├── README.md
├── cpp/
│   ├── README.md
│   ├── main.cpp
│   └── main.s          # 4.859 Zeilen (mit LTO)
├── go/
│   ├── README.md
│   ├── main.go
│   └── main.s          # 182.282 Zeilen
├── pony/
│   ├── README.md
│   ├── main.pony
│   └── main.s          # 23.423 Zeilen
├── rust/
│   ├── README.md
│   ├── Cargo.toml
│   ├── src/main.rs
│   └── main.s          # 72.165 Zeilen
└── swift/
    ├── README.md
    ├── main.swift
    └── main.s          # 700 Zeilen
```

## Ausführen (mit Optimierung)

```bash
# C++26 (maximale Optimierung)
cd cpp && g++ -std=c++26 -O3 -march=native -flto -ffast-math main.cpp -o main && ./main

# Go 1.25.5
cd go && go build -ldflags="-s -w" -o main && ./main

# Rust 2024 (native CPU)
cd rust && RUSTFLAGS="-C target-cpu=native" cargo run --release

# Swift 6.2 (unchecked)
cd swift && swiftc -O -whole-module-optimization -Ounchecked main.swift -o main && ./main

# Pony (stripped)
cd pony && ponyc -s && ./pony
```

## Kernaussage

| Erkenntnis | Beschreibung |
|------------|--------------|
| **Gleiche Performance** | Alle Sprachen ~24-29ms mit maximaler Optimierung |
| **Gleicher Inner Loop** | LLVM/GCC generieren identischen Maschinencode |
| **Unterschiede in Runtime** | Go/Pony haben größere Runtimes für Concurrency |
| **Wahl nach Features** | Performance ist kein Unterscheidungsmerkmal mehr |

**Fazit:** Wähle die Sprache nach Sicherheits-Features (Rust, Pony), Ökosystem (Go, Swift), oder Vertrautheit (C++) - nicht nach Performance!
