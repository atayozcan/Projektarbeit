Ein TCP-Server und Client in Pony.
Verwendet das Actor-Modell von Pony für nebenläufige Verbindungsbehandlung.
Der Server lauscht auf Port 8080 und antwortet mit "Hello from Pony!".
Der Client spawnt 3 Worker-Actors, die jeweils eine HTTP-Anfrage senden.

## Server

```
=== TCP Server (Pony) ===

Server: Listening on port 8080
Server: Connection accepted.
Server: Request received, sending response...
Server: Connection closed.
```

## Client

```
=== TCP Client (Pony) ===

Client: Spawning 3 concurrent workers...
Client: All workers spawned.
Worker 1: Connected.
Worker 1: Sending request...
Worker 2: Connected.
Worker 2: Sending request...
Worker 3: Connected.
Worker 3: Sending request...
Worker 1: Response received.
Worker 1: Connection closed.
Worker 2: Response received.
Worker 2: Connection closed.
Worker 3: Response received.
Worker 3: Connection closed.
```
