actor Sender
  let _receiver: Receiver

  new create(receiver: Receiver) => _receiver = receiver

  be send_message(msg: String) => _receiver.receive(msg)

actor Receiver
  let _env: Env

  new create(env: Env) => _env = env

  be receive(msg: String) => _env.out.print("Receiver got: " + msg)

actor Main
  new create(env: Env) =>
    let receiver = Receiver(env)
    let sender = Sender(receiver)

    sender.send_message("Hello from Sender!")
