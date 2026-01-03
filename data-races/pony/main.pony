use "promises"

actor Thread1
  let _env: Env

  new create(env: Env) =>
    _env = env
    _env.out.print("Thread 1: Starting...")

  be increment(x: U32, p: Promise[U32]) =>
    p(x + 1)


actor Thread2
  let _env: Env

  new create(env: Env) =>
    _env = env
    _env.out.print("Thread 2: Starting...")

  be increment(x: U32, p: Promise[U32]) =>
    p(x + 1)


actor Main
  new create(env: Env) =>
    env.out.print("=== Promise Example (Pony) ===")

    let thread1 = Thread1(env)
    let thread2 = Thread2(env)

    let counter: U32 = 4

    let p = Promise[U32]

    p.next[None]({(value: U32): None =>
      env.out.print("Nach Thread1: " + value.string())

      let p2 = Promise[U32]
      p2.next[None]({(value2: U32): None =>
        env.out.print("Nach Thread2: " + value2.string())
        None
      })

      thread2.increment(value, p2)
      None
    })

    thread1.increment(counter, p)
