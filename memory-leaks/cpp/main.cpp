// Memory Leak Demonstration in C++26
#include <iostream>
#include <print>
#include <memory>
#include <vector>

void leak_memory() {
    // LEAK: Speicher wird alloziert aber nie freigegeben
    auto ptr = new int[1000];
    // Kein delete[] ptr!
}

void safe_memory() {
    // SICHER: unique_ptr gibt automatisch frei
    auto ptr = std::make_unique<int[]>(1000);
    // Automatisch freigegeben am Ende der Funktion
}

int main() {
    std::println("=== Memory Leak Test: C++26 ===");
    std::println("");
    std::println("--- Test 1: Memory Leak ---");
    std::println("Allocating 1000 ints without freeing...");

    leak_memory();

    std::println("Function returned - memory NOT freed!");
    std::println("Status: LEAK (Speicher verloren)");
    std::println("");

    std::println("--- Test 2: Safe Alternative (unique_ptr) ---");
    std::println("Allocating 1000 ints with unique_ptr...");

    safe_memory();

    std::println("Function returned - memory automatically freed!");
    std::println("Status: NO LEAK (RAII)");
    std::println("");

    std::println("--- Test 3: Manual Leak Detection ---");
    std::println("Run with: valgrind ./program");
    std::println("Or compile with: -fsanitize=address");
    std::println("");

    std::println("--- Comparison ---");
    std::println("C++:  Manual memory management, leaks possible");
    std::println("Pony: Automatic GC (ORCA), no manual freeing needed");

    return 0;
}
