#include <chrono>
#include <iostream>
#include <mutex>
#include <thread>

using namespace std;

// Two mutexes that will be used to create a deadlock
mutex mutex1, mutex2;

void thread1Function() {
  fprintf(stdout, "Thread 1: Starting...\n");

  // Thread 1 locks mutex1 first
  lock_guard lock1(mutex1);

  fprintf(stdout, "Thread 1: Locked mutex1\n");
  // Small delay to ensure both threads have acquired their first lock
  this_thread::sleep_for(chrono::milliseconds(100L));

  fprintf(stdout, "Thread 1: Trying to lock mutex2...\n");
  // Thread 1 then tries to lock mutex2 (but thread2 has it)
  lock_guard lock2(mutex2);
  fprintf(stdout, "Thread 1: Locked mutex2\n");

  // This code will never be reached due to deadlock
  fprintf(stdout, "Thread 1: Completed successfully!\n");
}

void thread2Function() {
  fprintf(stdout, "Thread 2: Starting...\n");

  // Thread 2 locks mutex2 first (opposite order from thread1)
  lock_guard lock2(mutex2);
  fprintf(stdout, "Thread 2: Locked mutex2\n");

  // Small delay to ensure both threads have acquired their first lock
  this_thread::sleep_for(chrono::milliseconds(100L));

  fprintf(stdout, "Thread 2: Trying to lock mutex1...\n");
  // Thread 2 then tries to lock mutex1 (but thread1 has it)
  lock_guard lock1(mutex1);
  fprintf(stdout, "Thread 2: Locked mutex1\n");

  // This code will never be reached due to deadlock
  fprintf(stdout, "Thread 2: Completed successfully!\n");
}

int main() {
  fprintf(stdout, R"(
=== Deadlock Example ===
This program will intentionally deadlock.
You'll need to forcefully terminate it (Ctrl+C).

)");

  // Create two threads
  thread t1(thread1Function);
  thread t2(thread2Function);

  // Wait for threads to complete (they never will due to deadlock)
  t1.join();
  t2.join();

  // This line will never be reached
  fprintf(stdout, "Program completed successfully!\n");
  return EXIT_SUCCESS;
}
