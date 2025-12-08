use "net"
use "collections"

actor Main
  new create(env: Env) =>
    env.out.print("")
    env.out.print("=== TCP Client (Pony) ===")
    env.out.print("")

    let count: USize = 3
    env.out.print("Client: Spawning " + count.string() + " concurrent workers...")

    let auth = TCPConnectAuth(env.root)
    for i in Range(0, count) do
      Worker(auth, env, i + 1)
    end

    env.out.print("Client: All workers spawned.")

actor Worker
  new create(auth: TCPConnectAuth, env: Env, id: USize) =>
    TCPConnection.ip4(auth, ClientConnectionNotify(auth, env, id), "", "8080")

class ClientConnectionNotify is TCPConnectionNotify
  let _auth: TCPConnectAuth
  let _env: Env
  let _id: USize

  new iso create(auth: TCPConnectAuth, env: Env, id: USize) =>
    _auth = auth
    _env = env
    _id = id

  fun ref connected(conn: TCPConnection ref) =>
    _env.out.print("Worker " + _id.string() + ": Connected.")
    _env.out.print("Worker " + _id.string() + ": Sending request...")
    let request: String val = "GET / HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n"
    conn.write(request)

  fun ref received(conn: TCPConnection ref, data: Array[U8] iso, times: USize): Bool =>
    _env.out.print("Worker " + _id.string() + ": Response received.")
    true

  fun ref connect_failed(conn: TCPConnection ref) =>
    _env.err.print("Worker " + _id.string() + ": Connection failed.")

  fun ref closed(conn: TCPConnection ref) =>
    _env.out.print("Worker " + _id.string() + ": Connection closed.")
