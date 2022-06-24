import std/[net, strutils]

when isMainModule:
  let server = newSocket()
  server.bindAddr(Port(1234))
  server.listen()

  let info = server.getLocalAddr()
  echo "Running server at ", info[0], ':', int(info[1])

  var client: Socket = new(Socket)
  server.accept(client)
  client.send("Hello, world.\n\r")
  var i = client.recvLine()
  client.send(i.toUpperAscii())
  client.send("\n\rGoodbye.\n\r")

