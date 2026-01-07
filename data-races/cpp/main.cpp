// Data Race Demonstration in C++26
#include <iostream>
#include <thread>
#include <print>

int counter = 0;
constexpr int ITERATIONS = 100000;

void increment() {
    for (int i = 0; i < ITERATIONS; ++i) {
        ++counter;  // UNSICHER: Keine Synchronisation
    }
}

int main() {
    std::println("=== Data Race Test: C++26 ===");
    std::println("");
    std::println("Setup: Two threads incrementing a shared counter");
    std::println("Each thread: {} increments", ITERATIONS);
    std::println("Expected result: {}", ITERATIONS * 2);
    std::println("");

    std::println("--- Running Test ---");
    std::println("Thread 1: Starting...");
    std::println("Thread 2: Starting...");

    std::thread t1(increment);
    std::thread t2(increment);

    t1.join();
    t2.join();

    std::println("Thread 1: Finished");
    std::println("Thread 2: Finished");
    std::println("");

    std::println("--- Result ---");
    std::println("Counter: {}", counter);

    if (counter == ITERATIONS * 2) {
        std::println("Status: NO RACE DETECTED (got lucky!)");
    } else {
        std::println("Status: RACE DETECTED (lost {} increments)", (ITERATIONS * 2) - counter);
    }

    return 0;
}
