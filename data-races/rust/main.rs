// Data Race Demonstration in Rust 2024
// HINWEIS: Rust VERHINDERT diesen Code zur Compile-Zeit!
// Diese Datei zeigt, was passieren WÜRDE und wie Rust es verhindert.

use std::thread;
use std::sync::Arc;
use std::sync::atomic::{AtomicI32, Ordering};

const ITERATIONS: i32 = 100000;

fn main() {
    println!("=== Data Race Test: Rust 2024 ===");
    println!();
    println!("Setup: Two threads incrementing a shared counter");
    println!("Each thread: {} increments", ITERATIONS);
    println!("Expected result: {}", ITERATIONS * 2);
    println!();

    println!("--- Rust Prevention Demo ---");
    println!("Rust VERHINDERT unsynchronisierten Zugriff zur Compile-Zeit!");
    println!();
    println!("Dieser Code kompiliert NICHT:");
    println!("  let mut counter = 0;");
    println!("  thread::spawn(|| counter += 1);  // ERROR: cannot borrow");
    println!();

    println!("--- Running Safe Alternative (AtomicI32) ---");
    println!("Thread 1: Starting...");
    println!("Thread 2: Starting...");

    let counter = Arc::new(AtomicI32::new(0));
    let counter1 = Arc::clone(&counter);
    let counter2 = Arc::clone(&counter);

    let t1 = thread::spawn(move || {
        for _ in 0..ITERATIONS {
            counter1.fetch_add(1, Ordering::Relaxed);
        }
    });

    let t2 = thread::spawn(move || {
        for _ in 0..ITERATIONS {
            counter2.fetch_add(1, Ordering::Relaxed);
        }
    });

    t1.join().unwrap();
    t2.join().unwrap();

    println!("Thread 1: Finished");
    println!("Thread 2: Finished");
    println!();

    println!("--- Result ---");
    let final_value = counter.load(Ordering::Relaxed);
    println!("Counter: {}", final_value);

    if final_value == ITERATIONS * 2 {
        println!("Status: NO RACE (Rust enforces safety)");
    } else {
        println!("Status: UNEXPECTED (should never happen with atomics)");
    }
}
