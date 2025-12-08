// Two actors that attempt the same lock-ordering pattern as other examples
// Note: Pony's actor model prevents traditional deadlocks by design

actor Thread1
  let _env: Env
  var _thread2: (Thread2 | None) = None

  new create(env: Env) =>
    _env = env
    _env.out.print("Thread 1: Starting...")

  be set_thread2(thread2: Thread2) =>
    _thread2 = thread2

  be acquire_resource1() =>
    _env.out.print("Thread 1: Locked resource1")
    _env.out.print("Thread 1: Trying to lock resource2...")
    // In other languages, this would cause a deadlock
    // In Pony, this message is queued and processed asynchronously
    match _thread2
    | let t2: Thread2 => t2.request_resource2(this)
    end

  be got_resource2() =>
    _env.out.print("Thread 1: Locked resource2")
    _env.out.print("Thread 1: Completed successfully!")

  be request_resource1(from: Thread2) =>
    _env.out.print("Thread 1: Granting resource1 to Thread 2")
    from.got_resource1()

actor Thread2
  let _env: Env
  var _thread1: (Thread1 | None) = None

  new create(env: Env) =>
    _env = env
    _env.out.print("Thread 2: Starting...")

  be set_thread1(thread1: Thread1) =>
    _thread1 = thread1

  be acquire_resource2() =>
    _env.out.print("Thread 2: Locked resource2")
    _env.out.print("Thread 2: Trying to lock resource1...")
    // In other languages, this would cause a deadlock
    // In Pony, this message is queued and processed asynchronously
    match _thread1
    | let t1: Thread1 => t1.request_resource1(this)
    end

  be got_resource1() =>
    _env.out.print("Thread 2: Locked resource1")
    _env.out.print("Thread 2: Completed successfully!")

  be request_resource2(from: Thread1) =>
    _env.out.print("Thread 2: Granting resource2 to Thread 1")
    from.got_resource2()

actor Main
  new create(env: Env) =>
    env.out.print("")
    env.out.print("=== Deadlock Example (Pony) ===")
    env.out.print("This program demonstrates the same pattern that causes")
    env.out.print("deadlocks in other languages. Pony's actor model prevents")
    env.out.print("this by using asynchronous message passing.")
    env.out.print("")

    // Create two actors
    let thread1 = Thread1(env)
    let thread2 = Thread2(env)

    // Set cross-references
    thread1.set_thread2(thread2)
    thread2.set_thread1(thread1)

    // Both actors try to acquire resources in opposite order
    thread1.acquire_resource1()
    thread2.acquire_resource2()
