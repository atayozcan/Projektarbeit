// Memory Leak Demonstration in C++26
#include <memory>
#include <print>

using namespace std;

void leak_memory() {
    auto ptr = new int[1000];
    // Kein delete[] ptr!
}

void safe_memory() {
    auto ptr = make_unique<int[]>(1000);
}

int main() {
    println("=== Memory Leak Test: C++26 ===");
    println("");

    println("--- Test 1: Memory Leak (new ohne delete) ---");
    println("Allocating 1000 ints without freeing...");
    leak_memory();
    println("Function returned - memory NOT freed!");
    println("Status: LEAK");
    println("");

    println("--- Test 2: Safe Alternative (unique_ptr) ---");
    println("Allocating 1000 ints with unique_ptr...");
    safe_memory();
    println("Function returned - memory automatically freed!");
    println("Status: NO LEAK");
    println("");

    println("--- Test 3: Leak Detection ---");
    println("Run with: valgrind ./main");
    println("Or compile with: -fsanitize=address");
    println("Status: TOOLS AVAILABLE");
    println("");

    println("--- Comparison ---");
    println("C++:  Manual memory management, leaks possible");
    println("Pony: ORCA GC, no manual freeing needed");

    return 0;
}
