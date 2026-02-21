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

  new create(env: Env, id: USize, left: Fork, right: Fork) =>
    _env = env
    _id = id
    _left = left
    _right = right

  be start() =>
    think()

  be think() =>
    _env.out.print("Philosoph " + _id.string() + ": denkt")
    get_fork()

  be get_fork() =>
    // asymmetric grabbing to prevent deadlocks
    if ((_id % 2) == 0) then
      if not _has_left then
        _left.acquire(this)
      elseif not _has_right then
        _right.acquire(this)
      end
    else
      if not _has_right then
        _right.acquire(this)
      elseif not _has_left then
        _left.acquire(this)
      end

      // No asymmetric grabbing: always try left then right
      //if not _has_left then
        //_left.acquire(this)
      //elseif not _has_right then
        //_right.acquire(this)
      //end
    end

  be got_fork() =>
    if ((_id % 2) == 0) then
      if not _has_left then
        _has_left = true
      else
        _has_right = true
      end
    else
      if not _has_right then
        _has_right = true
      else
        _has_left = true
      end
    end

    if _has_left and _has_right then
      eat()
    else
      get_fork()
    end

  be eat() =>
    _env.out.print("Philosoph " + _id.string() + ": isst")
    _left.release()
    _right.release()
    _has_left = false
    _has_right = false
    think()

actor Main
  new create(env: Env) =>
    env.out.print("=== Dining Philosophers: Pony ===")
    env.out.print("")
    env.out.print("Setup: 5 Philosophen, 5 Gabeln (Actors)")
    env.out.print("Deadlock-Vermeidung: Actor Model (asynchrone Nachrichten)")
    env.out.print("")
    env.out.print("--- Running ---")

    let forks: Array[Fork] = Array[Fork]
    let philosophers: Array[Philosopher] = Array[Philosopher]

    // create 5 forks
    let n: USize = 5
    var i: USize = 0
    while i < n do
      forks.push(Fork)
      i = i + 1
    end

    // create 5 philosophers
    i = 0

    while i < n do
      try
        let left = forks(i)?
        let right = forks(((i + 1) % 5))?
        philosophers.push(Philosopher(env, i, left, right))
      end
      i = i + 1
    end

    // start the hunger games!
    for p in philosophers.values() do
      p.start()
    end
