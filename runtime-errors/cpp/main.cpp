// Out-of-Bounds-Zugriff in C++26
#include <iostream>
#include <vector>
#include <expected>
#include <optional>
#include <format>
#include <print>

template<typename T>
std::expected<T, std::string> safe_access(const std::vector<T>& vec, size_t index) {
    if (index >= vec.size()) {
        return std::unexpected(std::format("index {} out of bounds (size: {})", index, vec.size()));
    }
    return vec[index];
}

template<typename T>
std::optional<T> try_access(const std::vector<T>& vec, size_t index) {
    if (index < vec.size()) {
        return vec[index];
    }
    return std::nullopt;
}

int main() {
    std::println("=== Out-of-Bounds Test: C++26 ===");
    std::println("");

    std::vector<int> vec = {10, 20, 30};
    std::println("Array: [10, 20, 30]");
    std::println("Size:  {}", vec.size());
    std::println("");

    // Test 1: Ungültiger Index mit at()
    std::println("--- Test 1: Invalid Index (10) ---");
    try {
        int value = vec.at(10);
        std::println("Method: vec.at(10)");
        std::println("Result: {}", value);
    } catch (const std::out_of_range& e) {
        std::println("Method: vec.at(10)");
        std::println("Result: EXCEPTION - {}", e.what());
    }
    std::println("");

    // Test 2: Ungültiger Index mit std::expected
    std::println("--- Test 2: Safe Access (10) ---");
    auto result = safe_access(vec, 10);
    std::println("Method: safe_access(vec, 10)");
    if (result) {
        std::println("Result: {}", *result);
    } else {
        std::println("Result: ERROR - {}", result.error());
    }
    std::println("");

    // Test 3: Gültiger Index
    std::println("--- Test 3: Valid Index (1) ---");
    auto valid_result = safe_access(vec, 1);
    std::println("Method: safe_access(vec, 1)");
    if (valid_result) {
        std::println("Result: {}", *valid_result);
    }
    std::println("");

    // Test 4: Standardwert mit std::optional
    std::println("--- Test 4: Default Value ---");
    int default_value = try_access(vec, 10).value_or(-1);
    std::println("Method: try_access(vec, 10).value_or(-1)");
    std::println("Result: {}", default_value);
    std::println("");

    // Test 5: Iterator
    std::println("--- Test 5: Iterator ---");
    std::println("Method: for (size_t i = 0; i < vec.size(); ++i)");
    for (size_t i = 0; i < vec.size(); ++i) {
        std::println("[{}] = {}", i, vec[i]);
    }

    return 0;
}
