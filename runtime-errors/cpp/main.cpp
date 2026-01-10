#include <expected>
#include <format>
#include <optional>
#include <print>
#include <vector>

using namespace std;

template <typename T>
expected<T, string> safe_access(const vector<T> &vec, size_t index) {
  if (index < vec.size())
    return vec[index];
  return unexpected(
      format("index {} out of bounds (size: {})", index, vec.size()));
}

template <typename T>
optional<T> try_access(const vector<T> &vec, size_t index) {
  if (index < vec.size())
    return vec[index];
  return nullopt;
}

int main() {
  println("=== Out-of-Bounds Test: C++26 ===");
  println("");

  vector<int> vec = {10, 20, 30};
  println("Array: [10, 20, 30]");
  println("Size:  {}", vec.size());
  println("");

  // Test 1: Ungültiger Index mit at()
  println("--- Test 1: Invalid Index (10) ---");

    int value = vec.at(10);
    println("Method: vec.at(10)");
    println("Result: {}", value);

  println("");

  // Test 2: Ungültiger Index mit expected
  println("--- Test 2: Safe Access (10) ---");
  auto result = safe_access(vec, 10);
  println("Method: safe_access(vec, 10)");
  if (result)
    println("Result: {}", *result);
  else
    println("Result: ERROR - {}", result.error());
  println("");

  // Test 3: Gültiger Index
  println("--- Test 3: Valid Index (1) ---");
  auto valid_result = safe_access(vec, 1);
  println("Method: safe_access(vec, 1)");
  if (valid_result)
    println("Result: {}", *valid_result);
  println("");

  // Test 4: Standardwert mit optional
  println("--- Test 4: Default Value ---");
  int default_value = try_access(vec, 10).value_or(-1);
  println("Method: try_access(vec, 10).value_or(-1)");
  println("Result: {}", default_value);
  println("");

  return 0;
}
