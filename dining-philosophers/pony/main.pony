// Dining Philosophers in Pony
// Das Actor Model verhindert Deadlocks durch asynchrone Nachrichten

use "time"

actor Fork
  var _in_use: Bool = false
  var _waiting: Array[Philosopher] = Array[Philosopher]

  be acquire(philosopher: Philosopher) =>
    if _in_use then
      _waiting.push(philosopher)
    else
      _in_use = true
      philosopher.got_fork()
    end

  be release() =>
    if _waiting.size() > 0 then
      try
        let next = _waiting.shift()?
        next.got_fork()
      end
    else
      _in_use = false
    end

actor Philosopher
  let _env: Env
  let _id: USize
  let _left: Fork
  let _right: Fork
  var _has_left: Bool = false
  var _has_right: Bool = false
  let _timers: Timers = Timers

  new create(env: Env, id: USize, left: Fork, right: Fork) =>
    _env = env
    _id = id
    _left = left
    _right = right
    think()

  be think() =>
    _env.out.print("Philosoph " + _id.string() + ": denkt")
    let timer = Timer(ThinkNotify(this), 500_000_000, 0)
    _timers(consume timer)

  be done_thinking() =>
    // Deadlock-Vermeidung: letzter Philosoph greift umgekehrt
    if _id == 4 then
      _right.acquire(this)
    else
      _left.acquire(this)
    end

  be got_fork() =>
    if _id == 4 then
      if not _has_right then
        _has_right = true
        _left.acquire(this)
      else
        _has_left = true
        eat()
      end
    else
      if not _has_left then
        _has_left = true
        _right.acquire(this)
      else
        _has_right = true
        eat()
      end
    end

  be eat() =>
    _env.out.print("Philosoph " + _id.string() + ": isst")
    let timer = Timer(EatNotify(this), 500_000_000, 0)
    _timers(consume timer)

  be done_eating() =>
    _has_left = false
    _has_right = false
    _left.release()
    _right.release()
    think()

class ThinkNotify is TimerNotify
  let _philosopher: Philosopher

  new iso create(philosopher: Philosopher) =>
    _philosopher = philosopher

  fun ref apply(timer: Timer, count: U64): Bool =>
    _philosopher.done_thinking()
    false

class EatNotify is TimerNotify
  let _philosopher: Philosopher

  new iso create(philosopher: Philosopher) =>
    _philosopher = philosopher

  fun ref apply(timer: Timer, count: U64): Bool =>
    _philosopher.done_eating()
    false

actor Main
  new create(env: Env) =>
    env.out.print("=== Dining Philosophers: Pony ===")
    env.out.print("")
    env.out.print("Setup: 5 Philosophen, 5 Gabeln (Actors)")
    env.out.print("Deadlock-Vermeidung: Actor Model (asynchrone Nachrichten)")
    env.out.print("")
    env.out.print("--- Running ---")

    let forks = Array[Fork](5)
    for i in Range(0, 5) do
      forks.push(Fork)
    end

    try
      for i in Range(0, 5) do
        let left = forks(i)?
        let right = forks((i + 1) % 5)?
        Philosopher(env, i, left, right)
      end
    end
