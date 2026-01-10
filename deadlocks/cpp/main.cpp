// Deadlock Demonstration in C++26
#include <chrono>
#include <mutex>
#include <print>
#include <thread>

using namespace std;

mutex mutex1, mutex2;

void thread1Function() {
    println("Thread 1: Starting...");
    lock_guard lock1(mutex1);
    println("Thread 1: Locked mutex1");

    this_thread::sleep_for(chrono::milliseconds(100));

    println("Thread 1: Trying to lock mutex2...");
    lock_guard lock2(mutex2);
    println("Thread 1: Locked mutex2");
    println("Thread 1: Completed successfully!");
}

void thread2Function() {
    println("Thread 2: Starting...");
    lock_guard lock2(mutex2);
    println("Thread 2: Locked mutex2");

    this_thread::sleep_for(chrono::milliseconds(100));

    println("Thread 2: Trying to lock mutex1...");
    lock_guard lock1(mutex1);
    println("Thread 2: Locked mutex1");
    println("Thread 2: Completed successfully!");
}

int main() {
    println("=== Deadlock Test: C++26 ===");
    println("");
    println("Setup: Two threads acquiring two mutexes in opposite order");
    println("Thread 1: mutex1 -> mutex2");
    println("Thread 2: mutex2 -> mutex1");
    println("");
    println("--- Running Test ---");

    thread t1(thread1Function);
    thread t2(thread2Function);

    t1.join();
    t2.join();

    println("");
    println("--- Result ---");
    println("Status: DEADLOCK (program hangs, Ctrl+C to exit)");
    return 0;
}
