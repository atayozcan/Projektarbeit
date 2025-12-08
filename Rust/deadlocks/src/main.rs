use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

fn main() {
    let resource_a = Arc::new(Mutex::new(0));
    let resource_b = Arc::new(Mutex::new(0));
    let deadlock_detected = Arc::new(AtomicBool::new(false));

    let a1 = Arc::clone(&resource_a);
    let b1 = Arc::clone(&resource_b);
    let dead1 = Arc::clone(&deadlock_detected);

    thread::spawn(move || {
        let _lock_a = a1.lock().unwrap();
        println!("Thread 1: Locked resource A");

        thread::sleep(Duration::from_millis(200));

        println!("Thread 1: Trying to lock resource B...");

        // This will block forever in a deadlock
        let _lock_b = b1.lock().unwrap();

        dead1.store(false, Ordering::SeqCst);
        println!("Thread 1: Locked resource B (shouldn't happen)");
    });

    thread::sleep(Duration::from_millis(10));

    let a2 = Arc::clone(&resource_a);
    let b2 = Arc::clone(&resource_b);
    let dead2 = Arc::clone(&deadlock_detected);

    thread::spawn(move || {
        let _lock_b = b2.lock().unwrap();
        println!("Thread 2: Locked resource B");

        thread::sleep(Duration::from_millis(200));

        println!("Thread 2: Trying to lock resource A...");

        // This will block forever in a deadlock
        let _lock_a = a2.lock().unwrap();

        dead2.store(false, Ordering::SeqCst);
        println!("Thread 2: Locked resource A (shouldn't happen)");
    });

    // Monitor thread to detect deadlock
    let dead_monitor = Arc::clone(&deadlock_detected);
    let monitor = thread::spawn(move || {
        thread::sleep(Duration::from_secs(2)); // Wait 2 seconds
        println!("\n🔴 DEADLOCK DETECTED! Threads have been stuck for 2 seconds!");
        println!("Both threads are waiting for each other's resources.");
        dead_monitor.store(true, Ordering::SeqCst);
    });

    monitor.join().unwrap();

    if deadlock_detected.load(Ordering::SeqCst) {
        println!("\nProgram is deadlocked.");
    }
}
