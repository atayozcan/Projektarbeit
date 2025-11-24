// 10_deadlock_01.cpp
#include <iostream>
#include <thread>
#include <mutex>
using namespace std;

mutex resource1;
mutex resource2;

void threadFunction1() {
    lock_guard lock1(resource1);
    cout << "Thread 1 has first lock" << endl;
    this_thread::sleep_for(chrono::milliseconds(100)); // Simulating work
    lock_guard lock2(resource2); // This will wait for resource2
    cout << "Thread 1 has second lock" << endl;
}

void threadFunction2() {
    lock_guard lock2(resource2);
    cout << "Thread 2 has second lock" << endl;
    this_thread::sleep_for(chrono::milliseconds(100)); // Simulating work
    lock_guard lock1(resource1); // This will wait for resource1
    cout << "Thread 2 has first lock" << endl;
}

int main() {
    thread t1(threadFunction1);
    thread t2(threadFunction2);

    t1.join();
    t2.join();

    return 0;
}
