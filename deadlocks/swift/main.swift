// Deadlock Prevention with Actors in Swift 6.2
import Foundation

// Actor für Thread-sichere Ressourcenverwaltung
actor Resource {
    let name: String
    private var locked = false

    init(name: String) {
        self.name = name
    }

    func acquire(by task: String) async {
        while locked {
            try? await Task.sleep(nanoseconds: 10_000_000)
        }
        locked = true
        print("\(task): Locked \(name)")
    }

    func release() {
        locked = false
    }
}

func runTest() async {
    print("=== Deadlock Test: Swift 6.2 (consistent resource ordering) ===")
    print()
    print("Setup: Two tasks acquiring two resources in same order")
    print("Task 1: resource1 -> resource2")
    print("Task 2: resource1 -> resource2")
    print()
    print("--- Running Test ---")

    let r1 = Resource(name: "resource1")
    let r2 = Resource(name: "resource2")

    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            print("Task 1: Starting...")
            await r1.acquire(by: "Task 1")
            try? await Task.sleep(nanoseconds: 100_000_000)
            print("Task 1: Trying to lock resource2...")
            await r2.acquire(by: "Task 1")
            print("Task 1: Completed!")
            await r2.release()
            await r1.release()
        }
        group.addTask {
            print("Task 2: Starting...")
            await r1.acquire(by: "Task 2")
            try? await Task.sleep(nanoseconds: 100_000_000)
            print("Task 2: Trying to lock resource2...")
            await r2.acquire(by: "Task 2")
            print("Task 2: Completed!")
            await r2.release()
            await r1.release()
        }
    }

    print()
    print("--- Result ---")
    print("Status: NO DEADLOCK (consistent ordering prevents circular wait)")
}

Task {
    await runTest()
    exit(0)
}
RunLoop.main.run()
