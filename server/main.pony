use "net"
use "collections"

actor Main
  new create(env: Env) => TCPListener.ip4(TCPListenAuth(env.root), HTTPListenNotify(env), "", "8080")

class HTTPListenNotify is TCPListenNotify
  let _env: Env
  new create(env: Env) => _env = env
  fun ref listening(listen: TCPListener ref) => _env.out.print("Server listening on port 8080")
  fun ref not_listening(listen: TCPListener ref) =>
    _env.err.print("Failed to listen on port 8080")
    listen.close()
  fun ref connected(listen: TCPListener ref): TCPConnectionNotify iso^ => recover ConnectionHandler(_env) end

class ConnectionHandler is TCPConnectionNotify
  let _env: Env
  new create(env: Env) => _env = env
  fun ref accepted(conn: TCPConnection ref) => _env.out.print("Connection accepted.")
  fun ref connected(conn: TCPConnection ref) => conn.write("Hello from Pony!")
  fun ref received(conn: TCPConnection ref, data: Array[U8] iso, times: USize): Bool =>
    let body = "Hello from Pony!"
    let response =
      "HTTP/1.1 200 OK\r\n" +
      "Content-Type: text/plain\r\n" +
      "Content-Length: " + body.size().string() + "\r\n" +
      "Connection: close\r\n\r\n"
      + body
    conn.write(consume response)
    conn.close()
    true
  fun ref closed(conn: TCPConnection ref) => _env.out.print("Connection closed.")
  fun ref connect_failed(conn: TCPConnection ref) => _env.err.print("Connection failed.")
