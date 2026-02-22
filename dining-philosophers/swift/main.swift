// Dining Philosophers in Swift 6.2
import Foundation

let N = 5

// Jede Gabel ist ein Actor mit exklusivem Zugriff
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

// Jeder Philosoph ist ein Actor mit eigenem Zustand
actor Philosopher {
    let id: Int
    let firstFork: Fork
    let secondFork: Fork

    init(id: Int, leftFork: Fork, rightFork: Fork) {
        self.id = id
        // Deadlock-Vermeidung: letzter Philosoph greift umgekehrt
        if id == N - 1 {
            self.firstFork = rightFork
            self.secondFork = leftFork
        } else {
            self.firstFork = leftFork
            self.secondFork = rightFork
        }
    }

    func dine() async {
        while true {
            print("Philosoph \(id): denkt")
            try? await Task.sleep(nanoseconds: 500_000_000)

            await firstFork.acquire()
            await secondFork.acquire()

            print("Philosoph \(id): isst")
            try? await Task.sleep(nanoseconds: 500_000_000)

            await firstFork.release()
            await secondFork.release()
        }
    }
}

let forks = (0..<N).map { _ in Fork() }
let philosophers = (0..<N).map { i in
    Philosopher(id: i, leftFork: forks[i], rightFork: forks[(i + 1) % N])
}

print("=== Dining Philosophers: Swift 6.2 ===")
print()
print("Setup: 5 Philosophen, 5 Gabeln (Actors)")
print("Deadlock-Vermeidung: Letzter Philosoph greift umgekehrt")
print()
print("--- Running ---")

for philosopher in philosophers {
    Task {
        await philosopher.dine()
    }
}

RunLoop.main.run()
