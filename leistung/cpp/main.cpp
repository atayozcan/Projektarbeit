// Performance Benchmark in C++26
#include <chrono>
#include <print>
#include <vector>

using namespace std;
using namespace chrono;

constexpr int N = 10000000;

long long sum_of_primes(const int limit) {
    vector<bool> sieve(limit + 1, true);
    sieve[0] = sieve[1] = false;

    for (int i = 2; i * i <= limit; i++)
        if (sieve[i])
            for (int j = i * i; j <= limit; j += i) sieve[j] = false;

    long long sum = 0;
    for (int i = 2; i <= limit; i++) if (sieve[i]) sum += i;
    return sum;
}

int main() {
    println("=== Performance Test: C++26 ===");
    println("");
    println("Benchmark: Sum of primes up to {}", N);
    println("");

    println("--- Running Benchmark ---");
    const auto start = high_resolution_clock::now();

    long long result = sum_of_primes(N);

    const auto end = high_resolution_clock::now();
    const auto duration = duration_cast<milliseconds>(end - start);

    println("--- Result ---");
    println("Sum: {}", result);
    println("Time: {} ms", duration.count());

    return 0;
}
