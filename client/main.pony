use "net"
use "collections"

actor Main
  new create(env: Env) =>
    try
      // 2. Parse the argument
      let count = env.args(1)?.usize()?
      // 4. Spawn N Worker actors
      env.out.print("Spawning " + count.string() + " concurrent clients...")
      let auth = TCPConnectAuth(env.root)
      for i in Range(0, count) do Worker(auth, env) end
      env.out.print("All clients spawned.")
    else
      env.out.print("FAILED")
    end
// The Worker actor represents one concurrent client.
// Its only job is to create a TCPConnection.
actor Worker
  new create(auth: TCPConnectAuth, env: Env) =>
    // Create a new TCPConnection, which will immediately try to connect to the server.
    TCPConnection.ip4(auth, recover ClientConnectionNotify(auth, env.out) end, "", "8080")

// This class handles the client-side protocol
// for a single connection.
class ClientConnectionNotify is TCPConnectionNotify
  let _auth: TCPConnectAuth
  let _out: OutStream
  new iso create(auth: TCPConnectAuth, out: OutStream) =>
    _auth = auth
    _out = out
  // Called when the connection is successfully established.
  fun ref connected(conn: TCPConnection ref) =>
    // Send the minimal HTTP/1.1 GET request.
    // The 'Host' header is mandatory for HTTP/1.1.
    let request: String! = "GET / HTTP/1.1\r\n" + "Host: \r\n" + "Connection: close\r\n\r\n"
    // Send an asynchronous 'write' message to the connection actor.
    conn.write(consume request)

  // Called when data is received from the server.
  fun ref received(conn: TCPConnection ref, data: Array[U8] iso, times: USize): Bool =>
    // In a high-load test, we avoid printing to stdout.
    // The successful reception is enough.
    // F.ex: env.out.print("Client received response.")
    true

  // Called if the connection fails (e.g., server is down
  // or refuses the connection).
  fun ref connect_failed(conn: TCPConnection ref) =>
    // We could log this, but it's noisy in a load test.
    // F.ex: env.err.print("Connection failed.")
    None

  // Called when the connection is closed.
  fun ref closed(conn: TCPConnection ref) =>
    // This signifies a successful request/response cycle.
    // The Worker actor and its components will now be
    // garbage collected.
    None
