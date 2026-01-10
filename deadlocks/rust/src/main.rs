// Deadlock Demonstration in Rust 2024
use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

type SharedMutex = Arc<Mutex<i32>>;

fn thread1_function(mutex1: SharedMutex, mutex2: SharedMutex) {
    println!("Thread 1: Starting...");
    let _lock1 = mutex1.lock().unwrap();
    println!("Thread 1: Locked mutex1");

    thread::sleep(Duration::from_millis(100));

    println!("Thread 1: Trying to lock mutex2...");
    let _lock2 = mutex2.lock().unwrap();
    println!("Thread 1: Locked mutex2");
    println!("Thread 1: Completed successfully!");
}

fn thread2_function(mutex1: SharedMutex, mutex2: SharedMutex) {
    println!("Thread 2: Starting...");
    let _lock2 = mutex2.lock().unwrap();
    println!("Thread 2: Locked mutex2");

    thread::sleep(Duration::from_millis(100));

    println!("Thread 2: Trying to lock mutex1...");
    let _lock1 = mutex1.lock().unwrap();
    println!("Thread 2: Locked mutex1");
    println!("Thread 2: Completed successfully!");
}

fn main() {
    println!("=== Deadlock Test: Rust 2024 ===");
    println!();
    println!("Setup: Two threads acquiring two mutexes in opposite order");
    println!("Thread 1: mutex1 -> mutex2");
    println!("Thread 2: mutex2 -> mutex1");
    println!();
    println!("--- Running Test ---");

    let mutex1 = Arc::new(Mutex::new(0));
    let mutex2 = Arc::new(Mutex::new(0));

    let m1_clone1 = Arc::clone(&mutex1);
    let m2_clone1 = Arc::clone(&mutex2);
    let t1 = thread::spawn(move || {
        thread1_function(m1_clone1, m2_clone1);
    });

    let m1_clone2 = Arc::clone(&mutex1);
    let m2_clone2 = Arc::clone(&mutex2);
    let t2 = thread::spawn(move || {
        thread2_function(m1_clone2, m2_clone2);
    });

    t1.join().unwrap();
    t2.join().unwrap();

    println!();
    println!("--- Result ---");
    println!("Status: DEADLOCK (program hangs, Ctrl+C to exit)");
}
