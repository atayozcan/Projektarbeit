actor Thread1
  let _env: Env

  new create(env: Env) =>
    _env = env
    _env.out.print("Thread 1: Starting...")

  fun increment(x: U32): U32 =>
      x + 1


actor Thread2
  let _env: Env

  new create(env: Env) =>
    _env = env
    _env.out.print("Thread 2: Starting...")

  fun increment(x: U32): U32 =>
      x + 1


actor Main
  new create(env: Env) =>
    env.out.print("=== Data Race Example (Pony) ===")

    // Create two actors
    let thread1 = Thread1(env)
    let thread2 = Thread2(env)

    var counter = 4
    env.out.print("Counter value: " + counter.string())
    thread1.increment(counter)
    env.out.print("Counter value: " + counter.string())
    thread2.increment(counter)
    env.out.print("Counter value: " + counter.string())
