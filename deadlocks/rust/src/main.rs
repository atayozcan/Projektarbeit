use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

// Two mutexes that will be used to create a deadlock
type SharedMutex = Arc<Mutex<i32>>;

fn thread1_function(mutex1: SharedMutex, mutex2: SharedMutex) {
    println!("Thread 1: Starting...");

    // Thread 1 locks mutex1 first
    let _lock1 = mutex1.lock().unwrap();
    println!("Thread 1: Locked mutex1");

    // Small delay to ensure both threads have acquired their first lock
    thread::sleep(Duration::from_millis(100));

    println!("Thread 1: Trying to lock mutex2...");
    // Thread 1 then tries to lock mutex2 (but thread2 has it)
    let _lock2 = mutex2.lock().unwrap();
    println!("Thread 1: Locked mutex2");

    // This code will never be reached due to deadlock
    println!("Thread 1: Completed successfully!");
}

fn thread2_function(mutex1: SharedMutex, mutex2: SharedMutex) {
    println!("Thread 2: Starting...");

    // Thread 2 locks mutex2 first (opposite order from thread1)
    let _lock2 = mutex2.lock().unwrap();
    println!("Thread 2: Locked mutex2");

    // Small delay to ensure both threads have acquired their first lock
    thread::sleep(Duration::from_millis(100));

    println!("Thread 2: Trying to lock mutex1...");
    // Thread 2 then tries to lock mutex1 (but thread1 has it)
    let _lock1 = mutex1.lock().unwrap();
    println!("Thread 2: Locked mutex1");

    // This code will never be reached due to deadlock
    println!("Thread 2: Completed successfully!");
}

fn main() {
    println!(
        r#"
=== Deadlock Example ===
This program will intentionally deadlock.
You'll need to forcefully terminate it (Ctrl+C).
"#
    );

    // Two mutexes that will be used to create a deadlock
    let mutex1 = Arc::new(Mutex::new(0));
    let mutex2 = Arc::new(Mutex::new(0));

    // Create two threads
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

    // Wait for threads to complete (they never will due to deadlock)
    t1.join().unwrap();
    t2.join().unwrap();

    // This line will never be reached
    println!("Program completed successfully!");
}
