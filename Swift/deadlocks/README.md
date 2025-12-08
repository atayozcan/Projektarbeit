# Swift Deadlock Demonstration

This program demonstrates intentional deadlocks using modern Swift concurrency features including:
- **Actors** - Swift's concurrency-safe reference types
- **Async/Await** - Structured concurrency pattern
- **DispatchQueues and Semaphores** - Traditional concurrency primitives

## Compilation

To compile the program:

```bash
swiftc main.swift -o deadlocks
```

## Running

To run the program:

```bash
./deadlocks
```

**Note:** The program will deadlock intentionally. You'll need to forcefully terminate it using `Ctrl+C`.

## Examples

The program includes four different deadlock scenarios. Edit `main.swift` to uncomment the example you want to run:

### Example 0: Simple DispatchQueue Deadlock

The simplest form of deadlock - calling `sync` on the current dispatch queue.

```swift
demonstrateSimpleDeadlock()
```

**Demonstrates:**
- Synchronous call on the same queue that's currently executing
- Queue blocks waiting for itself to complete

### Example 1: Actor-based Circular Wait

Two actors wait for each other to signal, creating a circular dependency using Swift's actor model and continuations.

```swift
await demonstrateActorDeadlock()
```

**Demonstrates:**
- Actor isolation and concurrency
- CheckedContinuation usage
- Circular wait conditions with modern Swift concurrency

### Example 2: Classic Semaphore Deadlock (Default)

Classic circular lock scenario similar to the traditional mutex deadlock pattern (like the C++ example in this repository).

```swift
await demonstrateSemaphoreDeadlock()
```

**Demonstrates:**
- Two tasks acquiring semaphores in opposite order
- Task 1: acquires semaphore1, then tries to acquire semaphore2
- Task 2: acquires semaphore2, then tries to acquire semaphore1
- Results in classic deadlock

**Output:**
```
Task 1: Acquiring semaphore1...
Task 2: Acquiring semaphore2...
Task 1: Acquired semaphore1
Task 2: Acquired semaphore2
Task 1: Trying to acquire semaphore2...
Task 2: Trying to acquire semaphore1...
[Deadlock - program hangs]
```

### Example 3: Continuation Chain Deadlock

Creates a chain of continuations that wait on each other using actors and checked continuations.

```swift
await demonstrateContinuationDeadlock()
```

**Demonstrates:**
- Actor-stored continuations
- Circular dependencies in async code
- Modern Swift async/await patterns leading to deadlock

## Key Concepts

### Deadlock Conditions

A deadlock occurs when all four of these conditions are met:

1. **Mutual Exclusion** - Resources cannot be shared
2. **Hold and Wait** - Process holds one resource while waiting for another
3. **No Preemption** - Resources cannot be forcefully taken away
4. **Circular Wait** - Circular chain of processes waiting for resources

### Swift-Specific Features

- **Actors** prevent data races through isolation but can still deadlock when synchronization primitives are misused
- **Async/await** provides structured concurrency but doesn't prevent all deadlock scenarios
- **Continuations** allow bridging between async and sync code but can create circular dependencies

## Educational Purpose

This code is for educational purposes to demonstrate:
- How deadlocks can occur even with modern concurrency features
- The importance of proper resource acquisition order
- Different manifestations of deadlock in Swift

**Warning:** Never intentionally create deadlocks in production code!
