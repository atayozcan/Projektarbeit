// Deadlock Demonstration in Swift 6.2
import Foundation

actor Resource1 {
    private var holder: String? = nil

    func acquire(by task: String) async {
        holder = task
        print("\(task): Locked resource1")
    }

    func release() {
        holder = nil
    }
}

actor Resource2 {
    private var holder: String? = nil

    func acquire(by task: String) async {
        holder = task
        print("\(task): Locked resource2")
    }

    func release() {
        holder = nil
    }
}

let resource1 = Resource1()
let resource2 = Resource2()

func task1Function() async {
    print("Task 1: Starting...")
    await resource1.acquire(by: "Task 1")

    try? await Task.sleep(nanoseconds: 100_000_000)

    print("Task 1: Trying to lock resource2...")
    await resource2.acquire(by: "Task 1")
    print("Task 1: Completed successfully!")
}

func task2Function() async {
    print("Task 2: Starting...")
    await resource2.acquire(by: "Task 2")

    try? await Task.sleep(nanoseconds: 100_000_000)

    print("Task 2: Trying to lock resource1...")
    await resource1.acquire(by: "Task 2")
    print("Task 2: Completed successfully!")
}

print("=== Deadlock Test: Swift 6.2 ===")
print()
print("Setup: Two tasks acquiring two resources in opposite order")
print("Task 1: resource1 -> resource2")
print("Task 2: resource2 -> resource1")
print()
print("--- Running Test ---")

Task {
    await task1Function()
}

Task {
    await task2Function()
}

// Note: Program hangs here due to deadlock
// The result section below will never be reached
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    print()
    print("--- Result ---")
    print("Status: DEADLOCK (program hangs, Ctrl+C to exit)")
}

RunLoop.main.run()
