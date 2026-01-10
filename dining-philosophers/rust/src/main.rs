// Dining Philosophers in Rust 2024
use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

const N: usize = 5;

fn philosopher(id: usize, left_fork: Arc<Mutex<()>>, right_fork: Arc<Mutex<()>>) {
    loop {
        println!("Philosoph {}: denkt", id);
        thread::sleep(Duration::from_millis(500));

        // Deadlock-Vermeidung: letzter Philosoph greift umgekehrt
        if id == N - 1 {
            let _right = right_fork.lock().unwrap();
            let _left = left_fork.lock().unwrap();
            println!("Philosoph {}: isst", id);
            thread::sleep(Duration::from_millis(500));
        } else {
            let _left = left_fork.lock().unwrap();
            let _right = right_fork.lock().unwrap();
            println!("Philosoph {}: isst", id);
            thread::sleep(Duration::from_millis(500));
        }
    }
}

fn main() {
    println!("=== Dining Philosophers: Rust 2024 ===");
    println!();
    println!("Setup: 5 Philosophen, 5 Gabeln (Mutexe)");
    println!("Deadlock-Vermeidung: Letzter Philosoph greift umgekehrt");
    println!();
    println!("--- Running ---");

    let forks: Vec<Arc<Mutex<()>>> = (0..N)
        .map(|_| Arc::new(Mutex::new(())))
        .collect();

    let handles: Vec<_> = (0..N)
        .map(|i| {
            let left = Arc::clone(&forks[i]);
            let right = Arc::clone(&forks[(i + 1) % N]);
            thread::spawn(move || philosopher(i, left, right))
        })
        .collect();

    for handle in handles {
        handle.join().unwrap();
    }
}
