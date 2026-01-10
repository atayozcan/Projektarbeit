// Deadlock Demonstration in Pony
// HINWEIS: Pony VERHINDERT Deadlocks durch das Actor Model!

actor Thread1
  let _env: Env
  var _thread2: (Thread2 | None) = None

  new create(env: Env) =>
    _env = env

  be set_thread2(thread2: Thread2) =>
    _thread2 = thread2

  be acquire_resource1() =>
    _env.out.print("Actor 1: Starting...")
    _env.out.print("Actor 1: Locked resource1")
    _env.out.print("Actor 1: Trying to lock resource2...")
    match _thread2
    | let t2: Thread2 => t2.request_resource2(this)
    end

  be got_resource2() =>
    _env.out.print("Actor 1: Locked resource2")
    _env.out.print("Actor 1: Completed successfully!")

  be request_resource1(from: Thread2) =>
    from.got_resource1()

actor Thread2
  let _env: Env
  var _thread1: (Thread1 | None) = None

  new create(env: Env) =>
    _env = env

  be set_thread1(thread1: Thread1) =>
    _thread1 = thread1

  be acquire_resource2() =>
    _env.out.print("Actor 2: Starting...")
    _env.out.print("Actor 2: Locked resource2")
    _env.out.print("Actor 2: Trying to lock resource1...")
    match _thread1
    | let t1: Thread1 => t1.request_resource1(this)
    end

  be got_resource1() =>
    _env.out.print("Actor 2: Locked resource1")
    _env.out.print("Actor 2: Completed successfully!")

  be request_resource2(from: Thread1) =>
    from.got_resource2()

actor Main
  new create(env: Env) =>
    env.out.print("=== Deadlock Test: Pony ===")
    env.out.print("")
    env.out.print("Setup: Two actors acquiring two resources in opposite order")
    env.out.print("Actor 1: resource1 -> resource2")
    env.out.print("Actor 2: resource2 -> resource1")
    env.out.print("")
    env.out.print("--- Pony Prevention Demo ---")
    env.out.print("Pony VERHINDERT Deadlocks durch asynchrone Nachrichten!")
    env.out.print("")
    env.out.print("--- Running Test ---")

    let thread1 = Thread1(env)
    let thread2 = Thread2(env)

    thread1.set_thread2(thread2)
    thread2.set_thread1(thread1)

    thread1.acquire_resource1()
    thread2.acquire_resource2()
