// Memory Leak Prevention with Ownership in Rust 2024

fn main() {
    println!("=== Memory Leak Test: Rust 2024 (Ownership) ===");
    println!();

    println!("Setup: Allocate data on the heap, let ownership handle cleanup");
    println!();

    println!("--- Running Test ---");
    {
        let data = vec![1, 2, 3, 4, 5];
        println!("Vec created: {:?}", data);
    }
    println!("Vec automatically freed (Drop trait)");
    println!();

    println!("--- Result ---");
    println!("Status: NO LEAK (Ownership guarantees cleanup)");
}
