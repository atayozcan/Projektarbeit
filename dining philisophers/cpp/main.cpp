#include <iostream>
#include <thread>
#include <mutex>
#include <vector>
#include <chrono>

constexpr int N = 5;
std::mutex forks[N];

[[noreturn]] void philosopher(const int id) {
    const int left = id;
    const int right = (id + 1) % N;

    while (true) {
        // Denken
        std::cout << "Philosoph " << id << " denkt.\n";
        std::this_thread::sleep_for(std::chrono::milliseconds(500));

        // Deadlock-Vermeidung: letzter Philosoph greift umgekehrt
        if (id == N - 1) {
            forks[right].lock();
            forks[left].lock();
        } else {
            forks[left].lock();
            forks[right].lock();
        }

        // Essen
        std::cout << "Philosoph " << id << " isst.\n";
        std::this_thread::sleep_for(std::chrono::milliseconds(500));

        forks[left].unlock();
        forks[right].unlock();
    }
}

int main() {
    std::vector<std::thread> philosophers;

    for (int i = 0; i < N; i++) {
        philosophers.emplace_back(philosopher, i);
    }

    for (auto& p : philosophers) {
        p.join();
    }

    return 0;
}
