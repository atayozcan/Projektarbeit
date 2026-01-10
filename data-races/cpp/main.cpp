// Data Race Demonstration in C++26
#include <print>
#include <thread>

using namespace std;

int counter = 0;
constexpr int ITERATIONS = 100000;

void increment() {
    for (int i = 0; i < ITERATIONS; ++i) {
        ++counter;  // UNSICHER: Keine Synchronisation
    }
}

int main() {
    println("=== Data Race Test: C++26 ===");
    println("");
    println("Setup: Two threads incrementing a shared counter");
    println("Each thread: {} increments", ITERATIONS);
    println("Expected result: {}", ITERATIONS * 2);
    println("");

    println("--- Running Test ---");
    println("Thread 1: Starting...");
    println("Thread 2: Starting...");

    thread t1(increment);
    thread t2(increment);

    t1.join();
    t2.join();

    println("Thread 1: Finished");
    println("Thread 2: Finished");
    println("");

    println("--- Result ---");
    println("Counter: {}", counter);

    if (counter == ITERATIONS * 2) {
        println("Status: NO RACE DETECTED (got lucky!)");
    } else {
        println("Status: RACE DETECTED (lost {} increments)", (ITERATIONS * 2) - counter);
    }

    return 0;
}
