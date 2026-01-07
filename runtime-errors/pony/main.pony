// Out-of-Bounds-Zugriff in Pony
actor Main
  new create(env: Env) =>
    env.out.print("=== Out-of-Bounds Test: Pony ===")
    env.out.print("")

    let arr: Array[U32] = [10; 20; 30]
    env.out.print("Array: [10, 20, 30]")
    env.out.print("Size:  3")
    env.out.print("")

    // Test 1: Ungültiger Index mit try/else
    env.out.print("--- Test 1: Invalid Index (10) ---")
    env.out.print("Method: arr(10)?")
    try
      let value = arr(10)?
      env.out.print("Result: " + value.string())
    else
      env.out.print("Result: ERROR - index out of bounds")
    end
    env.out.print("")

    // Test 2: Sichere Abfrage (gleiche Methode wie Test 1)
    env.out.print("--- Test 2: Safe Access (10) ---")
    env.out.print("Method: try arr(10)? else ... end")
    try
      let value = arr(10)?
      env.out.print("Result: " + value.string())
    else
      env.out.print("Result: ERROR - index out of bounds")
    end
    env.out.print("")

    // Test 3: Gültiger Index
    env.out.print("--- Test 3: Valid Index (1) ---")
    env.out.print("Method: arr(1)?")
    try
      let value = arr(1)?
      env.out.print("Result: " + value.string())
    else
      env.out.print("Result: ERROR")
    end
    env.out.print("")

    // Test 4: Standardwert
    env.out.print("--- Test 4: Default Value ---")
    let default_value: U32 = try arr(10)? else 0 end
    env.out.print("Method: try arr(10)? else 0 end")
    env.out.print("Result: " + default_value.string())
    env.out.print("")

    // Test 5: Iterator
    env.out.print("--- Test 5: Iterator ---")
    env.out.print("Method: for value in arr.values() do")
    var i: USize = 0
    for value in arr.values() do
      env.out.print("[" + i.string() + "] = " + value.string())
      i = i + 1
    end
