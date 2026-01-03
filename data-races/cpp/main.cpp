#include <iostream>
#include <thread>

using namespace std;

int counter = 0;

void increment() {
  for (int i = 0; i < 100000; ++i) {
    ++counter;
  }
}

int main() {
  // Create two threads that run the increment function concurrently
  thread t1(increment);
  thread t2(increment);

  // Wait for both threads to finish
  t1.join();
  t2.join();

  cout << "Counter value: " << counter << endl;
  return 0;
}
