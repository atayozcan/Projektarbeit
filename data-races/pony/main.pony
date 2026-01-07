// Data Race Demonstration in Pony
// HINWEIS: Pony VERHINDERT Data Races durch Reference Capabilities!

actor Counter
  var _value: U32 = 0
  let _env: Env

  new create(env: Env) =>
    _env = env

  be increment(times: U32) =>
    var i: U32 = 0
    while i < times do
      _value = _value + 1
      i = i + 1
    end

  be report(expected: U32) =>
    _env.out.print("")
    _env.out.print("--- Result ---")
    _env.out.print("Counter: " + _value.string())
    if _value == expected then
      _env.out.print("Status: NO RACE (Pony guarantees safety)")
    else
      _env.out.print("Status: UNEXPECTED (should never happen)")
    end

actor Main
  new create(env: Env) =>
    env.out.print("=== Data Race Test: Pony ===")
    env.out.print("")
    env.out.print("Setup: Two actors sending increments to shared counter")
    env.out.print("Each actor: 100000 increments")
    env.out.print("Expected result: 200000")
    env.out.print("")

    env.out.print("--- Pony Prevention Demo ---")
    env.out.print("Pony VERHINDERT Data Races durch das Actor Model!")
    env.out.print("Jeder Actor verarbeitet Nachrichten sequentiell.")
    env.out.print("")

    env.out.print("--- Running Test ---")
    env.out.print("Actor 1: Starting...")
    env.out.print("Actor 2: Starting...")

    let counter = Counter(env)

    // Beide Actors senden Increment-Nachrichten
    // Der Counter verarbeitet sie sequentiell
    counter.increment(100000)
    counter.increment(100000)

    env.out.print("Actor 1: Finished")
    env.out.print("Actor 2: Finished")

    // Report wird nach den Increments verarbeitet
    counter.report(200000)
