// Memory Leak Demonstration in Rust 2024
use std::cell::RefCell;
use std::rc::{Rc, Weak};

#[derive(Debug)]
struct Node {
    value: i32,
    next: RefCell<Option<Rc<Node>>>,
}

#[derive(Debug)]
struct SafeNode {
    value: i32,
    next: RefCell<Option<Weak<SafeNode>>>,
}

fn main() {
    println!("=== Memory Leak Test: Rust 2024 ===");
    println!();

    // Test 1: Ownership prevents leaks
    println!("--- Test 1: Ownership (automatic cleanup) ---");
    {
        let data = vec![1, 2, 3, 4, 5];
        println!("Vec created: {:?}", data);
    }
    println!("Vec automatically freed (Drop trait)");
    println!("Status: NO LEAK");
    println!();

    // Test 2: Reference Cycle - the only way to leak in safe Rust
    println!("--- Test 2: Reference Cycle (Rc<RefCell<T>>) ---");
    let node1 = Rc::new(Node {
        value: 1,
        next: RefCell::new(None),
    });
    let node2 = Rc::new(Node {
        value: 2,
        next: RefCell::new(Some(Rc::clone(&node1))),
    });
    *node1.next.borrow_mut() = Some(Rc::clone(&node2));
    println!("Cycle created: node1 -> node2 -> node1");
    println!("Rc count node1: {}", Rc::strong_count(&node1));
    println!("Status: LEAK (Rc count never reaches 0)");
    println!();

    // Test 3: Weak references prevent leaks
    println!("--- Test 3: Weak References (solution) ---");
    let safe1 = Rc::new(SafeNode {
        value: 1,
        next: RefCell::new(None),
    });
    let safe2 = Rc::new(SafeNode {
        value: 2,
        next: RefCell::new(Some(Rc::downgrade(&safe1))),
    });
    *safe1.next.borrow_mut() = Some(Rc::downgrade(&safe2));
    println!("Weak cycle created (no real cycle)");
    println!("Rc strong count: {}", Rc::strong_count(&safe1));
    println!("Status: NO LEAK");
    println!();

    println!("--- Comparison ---");
    println!("Rust: Ownership prevents most leaks, Rc cycles possible");
    println!("Pony: ORCA GC, no reference cycles possible");
}
