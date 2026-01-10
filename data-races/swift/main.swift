// Data Race Demonstration in Swift 6.2
import Foundation

let ITERATIONS = 100000

// UNSICHER: Shared mutable state ohne Schutz
nonisolated(unsafe) var counter = 0

func increment() {
    for _ in 0..<ITERATIONS {
        counter += 1  // DATA RACE!
    }
}

func runTest() async {
    print("=== Data Race Test: Swift 6.2 ===")
    print()
    print("Setup: Two tasks incrementing a shared counter")
    print("Each task: \(ITERATIONS) increments")
    print("Expected result: \(ITERATIONS * 2)")
    print()

    print("--- Running Test ---")
    print("Task 1: Starting...")
    print("Task 2: Starting...")

    counter = 0

    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            increment()
        }
        group.addTask {
            increment()
        }
    }

    print("Task 1: Finished")
    print("Task 2: Finished")
    print()

    print("--- Result ---")
    print("Counter: \(counter)")

    if counter == ITERATIONS * 2 {
        print("Status: NO RACE DETECTED (got lucky!)")
    } else {
        print("Status: RACE DETECTED (lost \(ITERATIONS * 2 - counter) increments)")
    }
}

Task {
    await runTest()
    exit(0)
}
RunLoop.main.run()
