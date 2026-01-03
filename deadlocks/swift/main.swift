import Foundation

// Two actors that will be used to create a deadlock
actor Resource1 {
    private var holder: String? = nil

    func acquire(by thread: String) async {
        holder = thread
        print("\(thread): Locked resource1")
    }

    func release() {
        holder = nil
    }
}

actor Resource2 {
    private var holder: String? = nil

    func acquire(by thread: String) async {
        holder = thread
        print("\(thread): Locked resource2")
    }

    func release() {
        holder = nil
    }
}

// Shared resources
let resource1 = Resource1()
let resource2 = Resource2()

func thread1Function() async {
    print("Thread 1: Starting...")

    // Thread 1 locks resource1 first
    await resource1.acquire(by: "Thread 1")

    // Small delay to ensure both threads have acquired their first lock
    try? await Task.sleep(nanoseconds: 100_000_000)

    print("Thread 1: Trying to lock resource2...")
    // Thread 1 then tries to lock resource2 (but thread2 has it)
    await resource2.acquire(by: "Thread 1")

    // This code will never be reached due to deadlock
    print("Thread 1: Completed successfully!")
}

func thread2Function() async {
    print("Thread 2: Starting...")

    // Thread 2 locks resource2 first (opposite order from thread1)
    await resource2.acquire(by: "Thread 2")

    // Small delay to ensure both threads have acquired their first lock
    try? await Task.sleep(nanoseconds: 100_000_000)

    print("Thread 2: Trying to lock resource1...")
    // Thread 2 then tries to lock resource1 (but thread1 has it)
    await resource1.acquire(by: "Thread 2")

    // This code will never be reached due to deadlock
    print("Thread 2: Completed successfully!")
}

print("")
print("=== Deadlock Example (Swift Actors) ===")
print("This program demonstrates a deadlock using Swift actors.")
print("You'll need to forcefully terminate it (Ctrl+C).")
print("")

// Create two concurrent tasks
Task {
    await thread1Function()
}

Task {
    await thread2Function()
}

// Keep the program running
RunLoop.main.run()
