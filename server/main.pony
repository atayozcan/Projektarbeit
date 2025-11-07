use "net"
use "collections"

actor Main
  new create(env: Env) =>
    // Create an IPv4 TCP listener.
    // It requires an auth token (for permission to bind) and
    // a notifier object (the factory for new connections).
    // The 'recover' block converts the notifier from 'ref' to 'iso'.
    TCPListener.ip4(TCPListenAuth(env.root), recover HTTPListenNotify(env) end, "", "8080")

// This class acts as the "factory" for new connections.
// It implements the TCPListenNotify interface.
class HTTPListenNotify is TCPListenNotify
  let _env: Env
  new create(env: Env) => _env = env
  // Called when the listener is successfully bound.
  fun ref listening(listen: TCPListener ref) => _env.out.print("Server listening on port 8080")
  // Called if the listener fails to bind.
  fun ref not_listening(listen: TCPListener ref) =>
    _env.err.print("Failed to listen on port 8080")
    listen.close()
  // This is the factory method.
  // Called by the TCPListener actor when a new client connects.
  // It MUST return a new, isolated TCPConnectionNotify object.
  fun ref connected(listen: TCPListener ref): TCPConnectionNotify iso^ =>
    // Create a new ConnectionHandler for this specific connection.
    // 'recover' makes it 'iso' (isolated).
    recover ConnectionHandler(_env) end

// This class handles the protocol for a single connection.
// It implements the TCPConnectionNotify interface.
// A new instance is created for every connection.
class ConnectionHandler is TCPConnectionNotify
  let _env: Env
  new create(env: Env) => _env = env
  // Called when the TCPConnection actor has been set up.
  fun ref accepted(conn: TCPConnection ref) =>
    _env.out.print("Connection accepted.")
  // Called when the TCPConnection actor receives data from the client.
  fun ref received(conn: TCPConnection ref, data: Array[U8] iso, times: USize): Bool =>
    // This is a minimal web server. We don't parse the request.
    // The act of receiving data triggers the response.
    let body = "Hello from Pony!"
    let response =
      "HTTP/1.1 200 OK\r\n" +
      "Content-Type: text/plain\r\n" +
      "Content-Length: " + body.size().string() + "\r\n" +
      "Connection: close\r\n\r\n" +
      body
    // Send an asynchronous 'write' message to the connection actor.
    conn.write(consume response)
    // Tell the connection actor to close the socket
    // after the write buffer is flushed.
    conn.close()
    // Return true to indicate we've processed the data.
    true
  // Called when the connection is closed.
  fun ref closed(conn: TCPConnection ref) => _env.out.print("Connection closed.")
  // Called if the connection fails.
  fun ref connect_failed(conn: TCPConnection ref) => _env.err.print("Connection failed.")
