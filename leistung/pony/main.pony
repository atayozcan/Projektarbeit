// Performance Benchmark in Pony
use "time"
use "collections"

primitive Benchmark
  fun sum_of_primes(limit: USize): I64 =>
    let sieve = Array[Bool].init(true, limit + 1)
    try
      sieve(0)? = false
      sieve(1)? = false
    end

    var i: USize = 2
    while (i * i) <= limit do
      try
        if sieve(i)? then
          var j = i * i
          while j <= limit do
            sieve(j)? = false
            j = j + i
          end
        end
      end
      i = i + 1
    end

    var sum: I64 = 0
    var k: USize = 2
    while k <= limit do
      try
        if sieve(k)? then
          sum = sum + k.i64()
        end
      end
      k = k + 1
    end
    sum

actor Main
  new create(env: Env) =>
    env.out.print("=== Performance Test: Pony ===")
    env.out.print("")
    env.out.print("Benchmark: Sum of primes up to 10000000")
    env.out.print("")

    env.out.print("--- Running Benchmark ---")
    let start = Time.millis()

    let result = Benchmark.sum_of_primes(10000000)

    let finish = Time.millis()
    let duration = finish - start

    env.out.print("--- Result ---")
    env.out.print("Sum: " + result.string())
    env.out.print("Time: " + duration.string() + " ms")
