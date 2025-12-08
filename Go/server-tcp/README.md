Ein TCP-Server und Client in Go, ohne die `net/http` Bibliothek.
Der Server wird von Grund auf mit der `net` Bibliothek implementiert.
Er lauscht auf Port 8080 und echot empfangene Nachrichten zurück.

## Server

```
=== TCP Server (Go) ===

Server: Listening on port 8080
Server: Connection accepted.
Server: Received: Hello, Server!
Server: Sending response...
Server: Connection closed.
```

## Client

```
=== TCP Client (Go) ===

Client: Connecting to server...
Client: Connected.
Client: Sending request...
Client: Response received: Server received: Hello, Server!
Client: Connection closed.
```
