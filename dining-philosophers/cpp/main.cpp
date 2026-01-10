// Dining Philosophers in C++26
#include <chrono>
#include <mutex>
#include <print>
#include <thread>
#include <vector>

using namespace std;

constexpr int N = 5;
mutex forks[N];

[[noreturn]] void philosopher(const int id) {
    const int left = id;
    const int right = (id + 1) % N;

    while (true) {
        println("Philosoph {}: denkt", id);
        this_thread::sleep_for(chrono::milliseconds(500));

        // Deadlock-Vermeidung: letzter Philosoph greift umgekehrt
        if (id == N - 1) {
            forks[right].lock();
            forks[left].lock();
        } else {
            forks[left].lock();
            forks[right].lock();
        }

        println("Philosoph {}: isst", id);
        this_thread::sleep_for(chrono::milliseconds(500));

        forks[left].unlock();
        forks[right].unlock();
    }
}

int main() {
    println("=== Dining Philosophers: C++26 ===");
    println("");
    println("Setup: 5 Philosophen, 5 Gabeln (Mutexe)");
    println("Deadlock-Vermeidung: Letzter Philosoph greift umgekehrt");
    println("");
    println("--- Running ---");

    vector<thread> philosophers;
    for (int i = 0; i < N; i++) {
        philosophers.emplace_back(philosopher, i);
    }

    for (auto& p : philosophers) {
        p.join();
    }

    return 0;
}
