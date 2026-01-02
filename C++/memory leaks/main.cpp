#include "main.h"

#include <iostream>
#include <ostream>

void f() {
  // Allocate memory
  auto ptr = new int[10];
}

int main() {
  f();
  std::cout << "Memory leaks!" << std::endl;

  return 0;
}
