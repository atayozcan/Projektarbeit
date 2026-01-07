// Data Race Demonstration in Swift 6.2
// Demonstriert Strict Concurrency, Actors und nonisolated(unsafe)

import Foundation

let ITERATIONS = 100000

// Swift 6.2: Actor für thread-sichere Zählung
actor SafeCounter {
    private var value = 0

    func increment() {
        value += 1
    }

    func getValue() -> Int {
        return value
    }
}

// UNSICHER: Shared mutable state ohne Schutz
// Swift 6.2 mit strict concurrency würde hier warnen!
nonisolated(unsafe) var unsafeCounter = 0

func unsafeIncrement() {
    for _ in 0..<ITERATIONS {
        unsafeCounter += 1  // DATA RACE!
    }
}

func runTests() async {
    print("=== Data Race Test: Swift 6.2 ===")
    print()
    print("Setup: Two tasks incrementing a shared counter")
    print("Each task: \(ITERATIONS) increments")
    print("Expected result: \(ITERATIONS * 2)")
    print()

    // Test 1: Unsicherer Zugriff (Data Race)
    print("--- Test 1: Unsafe Access (Data Race) ---")
    print("Task 1: Starting...")
    print("Task 2: Starting...")

    unsafeCounter = 0

    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            unsafeIncrement()
        }
        group.addTask {
            unsafeIncrement()
        }
    }

    print("Task 1: Finished")
    print("Task 2: Finished")
    print()
    print("--- Unsafe Result ---")
    print("Counter: \(unsafeCounter)")
    if unsafeCounter == ITERATIONS * 2 {
        print("Status: NO RACE DETECTED (got lucky!)")
    } else {
        print("Status: RACE DETECTED (lost \(ITERATIONS * 2 - unsafeCounter) increments)")
    }
    print()

    // Test 2: Sicherer Zugriff mit Actor (Swift 6)
    print("--- Test 2: Safe Access (Actor) ---")
    print("Task 1: Starting...")
    print("Task 2: Starting...")

    let safeCounter = SafeCounter()

    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            for _ in 0..<ITERATIONS {
                await safeCounter.increment()
            }
        }
        group.addTask {
            for _ in 0..<ITERATIONS {
                await safeCounter.increment()
            }
        }
    }

    print("Task 1: Finished")
    print("Task 2: Finished")
    print()
    print("--- Safe Result ---")
    let finalValue = await safeCounter.getValue()
    print("Counter: \(finalValue)")
    if finalValue == ITERATIONS * 2 {
        print("Status: NO RACE (Actor guarantees safety)")
    } else {
        print("Status: UNEXPECTED")
    }
    print()

    // Swift 6.2 Features Erklärung
    print("--- Swift 6.2 Features Used ---")
    print("• nonisolated(unsafe): Explicit opt-out of safety")
    print("• actor: Thread-safe state isolation")
    print("• Strict concurrency: Compiler warnings for races")
    print("• withTaskGroup: Structured concurrency")
}

// Entry point
Task {
    await runTests()
    exit(0)
}
RunLoop.main.run()
