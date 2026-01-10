// Dining Philosophers in Swift 6.2
import Foundation

let N = 5

actor Fork {
    private var inUse = false

    func acquire() async {
        while inUse {
            await Task.yield()
        }
        inUse = true
    }

    func release() {
        inUse = false
    }
}

let forks = (0..<N).map { _ in Fork() }

func philosopher(id: Int) async {
    let left = id
    let right = (id + 1) % N

    while true {
        print("Philosoph \(id): denkt")
        try? await Task.sleep(nanoseconds: 500_000_000)

        // Deadlock-Vermeidung: letzter Philosoph greift umgekehrt
        if id == N - 1 {
            await forks[right].acquire()
            await forks[left].acquire()
        } else {
            await forks[left].acquire()
            await forks[right].acquire()
        }

        print("Philosoph \(id): isst")
        try? await Task.sleep(nanoseconds: 500_000_000)

        await forks[left].release()
        await forks[right].release()
    }
}

print("=== Dining Philosophers: Swift 6.2 ===")
print()
print("Setup: 5 Philosophen, 5 Gabeln (Actors)")
print("Deadlock-Vermeidung: Letzter Philosoph greift umgekehrt")
print()
print("--- Running ---")

for i in 0..<N {
    Task {
        await philosopher(id: i)
    }
}

RunLoop.main.run()
