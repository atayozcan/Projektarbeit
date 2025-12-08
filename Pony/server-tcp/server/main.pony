use "net"

actor Main
  new create(env: Env) =>
    env.out.print("")
    env.out.print("=== TCP Server (Pony) ===")
    env.out.print("")
    TCPListener.ip4(recover TCPListenAuth(env.root) end, HTTPListenNotify(env), "", "8080")

class HTTPListenNotify is TCPListenNotify
  let _env: Env

  new create(env: Env) =>
    _env = env

  fun ref listening(listen: TCPListener ref) =>
    _env.out.print("Server: Listening on port 8080")

  fun ref not_listening(listen: TCPListener ref) =>
    _env.err.print("Server: Failed to listen on port 8080")
    listen.close()

  fun ref connected(listen: TCPListener ref): TCPConnectionNotify iso^ =>
    recover ConnectionHandler(_env) end

class ConnectionHandler is TCPConnectionNotify
  let _env: Env

  new create(env: Env) =>
    _env = env

  fun ref accepted(conn: TCPConnection ref) =>
    _env.out.print("Server: Connection accepted.")

  fun ref received(conn: TCPConnection ref, data: Array[U8] iso, times: USize): Bool =>
    _env.out.print("Server: Request received, sending response...")

    // Create the response body
    let body = "Hello from Pony!"

    // Build the complete HTTP response
    let response = "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: text/plain\r\n" +
                   "Content-Length: " + body.size().string() + "\r\n" +
                   "Connection: close\r\n" +
                   "\r\n" +
                   body

    // Send the response
    conn.write(recover val consume response end)
    true

  fun ref closed(conn: TCPConnection ref) =>
    _env.out.print("Server: Connection closed.")

  fun ref connect_failed(conn: TCPConnection ref) =>
    _env.err.print("Server: Connection failed.")
