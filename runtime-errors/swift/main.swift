// Out-of-Bounds-Zugriff in Swift 6.2
// Demonstriert Typed Throws und sichere Array-Zugriffe

import Foundation

// Swift 6.2: Typed Throws - spezifischer Fehlertyp
enum IndexError: Error, CustomStringConvertible {
    case outOfBounds(index: Int, size: Int)

    var description: String {
        switch self {
        case .outOfBounds(let index, let size):
            return "Index \(index) out of bounds (size: \(size))"
        }
    }
}

// Extension mit Typed Throws (Swift 6 Feature)
extension Array {
    // throws(IndexError) - Compiler weiß genau welcher Fehler möglich ist
    func safeAccess(_ index: Int) throws(IndexError) -> Element {
        guard indices.contains(index) else {
            throw .outOfBounds(index: index, size: count)
        }
        return self[index]
    }

    // Optionale Variante (kein throw)
    func tryAccess(_ index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

func main() {
    print("=== Out-of-Bounds Test: Swift 6.2 ===")
    print()

    let arr = [10, 20, 30]
    print("Array: \(arr)")
    print("Size:  \(arr.count)")
    print()

    // Test 1: Standard-Zugriff (würde crashen)
    print("--- Test 1: Invalid Index (10) ---")
    print("Method: arr[10]")
    print("Result: FATAL ERROR - Index out of range (not executed)")
    print()

    // Test 2: Typed Throws (Swift 6 Feature)
    print("--- Test 2: Typed Throws (Swift 6) ---")
    print("Method: try arr.safeAccess(10) throws(IndexError)")
    do {
        let value = try arr.safeAccess(10)
        print("Result: \(value)")
    } catch {
        // Compiler weiß: error ist IndexError, kein casting nötig
        print("Result: \(error)")
    }
    print()

    // Test 3: Gültiger Index mit Typed Throws
    print("--- Test 3: Valid Index (1) ---")
    print("Method: try arr.safeAccess(1)")
    do {
        let value = try arr.safeAccess(1)
        print("Result: \(value)")
    } catch {
        print("Result: \(error)")
    }
    print()

    // Test 4: Nil-Coalescing (Optional)
    print("--- Test 4: Default Value ---")
    let defaultValue = arr.tryAccess(10) ?? -1
    print("Method: arr.tryAccess(10) ?? -1")
    print("Result: \(defaultValue)")
    print()

    // Test 5: Iterator
    print("--- Test 5: Iterator ---")
    print("Method: for (i, v) in arr.enumerated()")
    for (i, v) in arr.enumerated() {
        print("[\(i)] = \(v)")
    }
}

main()
