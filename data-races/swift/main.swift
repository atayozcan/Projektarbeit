// Data Race Prevention with Actors in Swift 6.2
import Foundation

let ITERATIONS = 100000

// Actor isoliert den Zustand - nur ein Task kann gleichzeitig zugreifen
actor SafeCounter {
    private var value = 0

    func increment() {
        value += 1
    }

    func getValue() -> Int {
        return value
    }
}

func runTest() async {
    print("=== Data Race Test: Swift 6.2 (Actor) ===")
    print()
    print("Setup: Two tasks incrementing an actor-protected counter")
    print("Each task: \(ITERATIONS) increments")
    print("Expected result: \(ITERATIONS * 2)")
    print()

    print("--- Running Test ---")
    print("Task 1: Starting...")
    print("Task 2: Starting...")

    let counter = SafeCounter()

    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            for _ in 0..<ITERATIONS {
                await counter.increment()
            }
        }
        group.addTask {
            for _ in 0..<ITERATIONS {
                await counter.increment()
            }
        }
    }

    let result = await counter.getValue()

    print("Task 1: Finished")
    print("Task 2: Finished")
    print()

    print("--- Result ---")
    print("Counter: \(result)")

    if result == ITERATIONS * 2 {
        print("Status: NO RACE (Actor guarantees safety)")
    } else {
        print("Status: RACE DETECTED (lost \(ITERATIONS * 2 - result) increments)")
    }
}

Task {
    await runTest()
    exit(0)
}
RunLoop.main.run()
