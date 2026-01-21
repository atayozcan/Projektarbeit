// Performance Benchmark in Swift 6.2
import Foundation

let N = 10_000_000

func sumOfPrimes(_ limit: Int) -> Int64 {
    var sieve = [Bool](repeating: true, count: limit + 1)
    sieve[0] = false
    sieve[1] = false

    var i = 2
    while i * i <= limit {
        if sieve[i] {
            var j = i * i
            while j <= limit {
                sieve[j] = false
                j += i
            }
        }
        i += 1
    }

    var sum: Int64 = 0
    for i in 2...limit {
        if sieve[i] {
            sum += Int64(i)
        }
    }
    return sum
}

print("=== Performance Test: Swift 6.2 ===")
print()
print("Benchmark: Sum of primes up to \(N)")
print()

print("--- Running Benchmark ---")
let start = Date()

let result = sumOfPrimes(N)

let end = Date()
let duration = end.timeIntervalSince(start) * 1000

print("--- Result ---")
print("Sum: \(result)")
print("Time: \(Int(duration)) ms")
