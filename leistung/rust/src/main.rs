// Performance Benchmark in Rust 2024
use std::time::Instant;

const N: usize = 10_000_000;

fn sum_of_primes(limit: usize) -> i64 {
    let mut sieve = vec![true; limit + 1];
    sieve[0] = false;
    sieve[1] = false;

    let mut i = 2;
    while i * i <= limit {
        if sieve[i] {
            let mut j = i * i;
            while j <= limit {
                sieve[j] = false;
                j += i;
            }
        }
        i += 1;
    }

    let mut sum: i64 = 0;
    for i in 2..=limit {
        if sieve[i] {
            sum += i as i64;
        }
    }
    sum
}

fn main() {
    println!("=== Performance Test: Rust 2024 ===");
    println!();
    println!("Benchmark: Sum of primes up to {}", N);
    println!();

    println!("--- Running Benchmark ---");
    let start = Instant::now();

    let result = sum_of_primes(N);

    let duration = start.elapsed();

    println!("--- Result ---");
    println!("Sum: {}", result);
    println!("Time: {} ms", duration.as_millis());
}
