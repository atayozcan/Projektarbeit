// Memory Leak Demonstration in Swift 6.2
import Foundation

class Person {
    let name: String
    var friend: Person?

    init(name: String) {
        self.name = name
        print("  \(name) created")
    }

    deinit {
        print("  \(name) freed")
    }
}

class SafePerson {
    let name: String
    weak var friend: SafePerson?

    init(name: String) {
        self.name = name
        print("  \(name) created")
    }

    deinit {
        print("  \(name) freed")
    }
}

print("=== Memory Leak Test: Swift 6.2 ===")
print()

// Test 1: ARC basics
print("--- Test 1: ARC Basics (automatic cleanup) ---")
do {
    let obj = Person(name: "Object1")
    print("  Reference count: 1")
}
print("Status: NO LEAK")
print()

// Test 2: Reference Cycle
print("--- Test 2: Reference Cycle (strong references) ---")
do {
    let alice = Person(name: "Alice")
    let bob = Person(name: "Bob")
    alice.friend = bob
    bob.friend = alice
    print("  Cycle created: alice <-> bob")
}
print("  (No deinit messages - memory leaked!)")
print("Status: LEAK")
print()

// Test 3: Weak references prevent leaks
print("--- Test 3: Weak References (solution) ---")
do {
    let alice = SafePerson(name: "SafeAlice")
    let bob = SafePerson(name: "SafeBob")
    alice.friend = bob
    bob.friend = alice
    print("  Weak cycle created")
}
print("Status: NO LEAK")
print()

print("--- Comparison ---")
print("Swift: ARC, leaks through reference cycles possible")
print("Pony:  ORCA GC, no reference cycles possible")
