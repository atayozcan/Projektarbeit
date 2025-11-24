actor Thread1
  be message(env: Env) =>
    env.out.print("Thread 1")

actor Thread2
  be message(env: Env) =>
    env.out.print("Thread 2")

actor Main
  new create(env: Env) =>
    let t1 = Thread1
    let t2 = Thread2

    t1.message(env)
    t2.message(env)
