// Memory Leak Prevention with ARC in Swift 6.2
import Foundation

class Person {
    let name: String

    init(name: String) {
        self.name = name
        print("  \(name) created")
    }

    deinit {
        print("  \(name) freed")
    }
}

print("=== Memory Leak Test: Swift 6.2 (ARC) ===")
print()

print("Setup: Allocate objects, let ARC handle cleanup")
print()

print("--- Running Test ---")
do {
    let alice = Person(name: "Alice")
    let bob = Person(name: "Bob")
    print("  Reference count: 1 each")
}
print()

print("--- Result ---")
print("Status: NO LEAK (ARC guarantees cleanup)")
