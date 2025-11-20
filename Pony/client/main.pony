use "net"
use "collections"

actor Main
  new create(env: Env) =>
    let count: USize = 3
    env.out.print("Spawning " + count.string() + " concurrent clients...")
    let auth = TCPConnectAuth(env.root)
    for i in Range(0, count) do Worker(auth, env) end
    env.out.print("All clients spawned.")

actor Worker
  new create(auth: TCPConnectAuth, env: Env) =>
    TCPConnection.ip4(auth, ClientConnectionNotify(auth, env), "", "8080")

class ClientConnectionNotify is TCPConnectionNotify
  let _auth: TCPConnectAuth
  let _env: Env

  new iso create(auth: TCPConnectAuth, env: Env) =>
    _auth = auth
    _env = env

  fun ref connected(conn: TCPConnection ref) =>
    let request: String! = "GET / HTTP/1.1\r\n" + "Host: \r\n" + "Connection: close\r\n\r\n"
    conn.write(consume request)

  fun ref received(conn: TCPConnection ref, data: Array[U8] iso, times: USize): Bool =>
    _env.out.print(consume data)
    true

  fun ref connect_failed(conn: TCPConnection ref) =>
    _env.err.print("Connection failed.")
    None

  fun ref closed(conn: TCPConnection ref) => None
