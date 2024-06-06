import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {
  late IO.Socket _socket;
  void socketInitialize() {
    _socket = IO.io("http://192.168.237.68:4000",
        IO.OptionBuilder().setTransports(['websocket']).build());

    _socket.onConnect((_) => print("connected"));
    _socket.onConnectError((error) => print("Error $error"));
    _socket.onDisconnect((_) => print("disconected"));
  }

  void connect() {
    _socket.connect();
  }

  chatMessage(idCourse, semeter) async {
    late List messages;
    _socket.emit("messages", {"idCourse": idCourse, "semeter": semeter});
    _socket.on("messages", (msg) async => {messages = msg});
    return messages;
  }
}
