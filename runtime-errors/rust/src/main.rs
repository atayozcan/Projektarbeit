// Out-of-Bounds-Zugriff in Rust (Edition 2024)
use std::panic;

fn safe_access<T: Clone>(slice: &[T], index: usize) -> Result<T, String> {
    if index < slice.len() {
        Ok(slice[index].clone())
    } else {
        Err(format!("index {} out of bounds (size: {})", index, slice.len()))
    }
}

fn main() {
    println!("=== Out-of-Bounds Test: Rust 2024 ===");
    println!();

    let vec: Vec<i32> = vec![10, 20, 30];
    println!("Array: {:?}", vec);
    println!("Size:  {}", vec.len());
    println!();

    // Test 1: Ungültiger Index mit panic
    println!("--- Test 1: Invalid Index (10) ---");
    let result = panic::catch_unwind(|| {
        let _value = vec[10];
    });
    println!("Method: vec[10]");
    match result {
        Ok(_) => println!("Result: (unreachable)"),
        Err(_) => println!("Result: PANIC - index out of bounds"),
    }
    println!();

    // Test 2: Ungültiger Index mit get()
    println!("--- Test 2: Safe Access (10) ---");
    println!("Method: vec.get(10)");
    match vec.get(10) {
        Some(value) => println!("Result: {}", value),
        None => println!("Result: None (index out of bounds)"),
    }
    println!();

    // Test 3: Gültiger Index
    println!("--- Test 3: Valid Index (1) ---");
    println!("Method: vec.get(1)");
    match vec.get(1) {
        Some(value) => println!("Result: {}", value),
        None => println!("Result: None"),
    }
    println!();

    // Test 4: Standardwert
    println!("--- Test 4: Default Value ---");
    let default_value = vec.get(10).unwrap_or(&-1);
    println!("Method: vec.get(10).unwrap_or(&-1)");
    println!("Result: {}", default_value);
    println!();

    // Test 5: Iterator
    println!("--- Test 5: Iterator ---");
    println!("Method: for (i, v) in vec.iter().enumerate()");
    for (i, v) in vec.iter().enumerate() {
        println!("[{}] = {}", i, v);
    }
}
