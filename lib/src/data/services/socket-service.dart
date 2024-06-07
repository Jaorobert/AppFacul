import 'dart:convert';

import 'package:app_facul/src/data/model/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {
  late IO.Socket _socket;
  late final List<Message> _listMessage = [];

  Socket() {
    _socket = IO.io("http://192.168.237.68:4000",
        IO.OptionBuilder().setTransports(['websocket']).build());
  }

  void socketInitialize() {
    _socket.onConnect((_) => print("connected"));
    _socket.onConnectError((error) => print("Error $error"));
    _socket.onDisconnect((_) => print("disconected"));
    _socket.on("messages", (msg) async {
      List<dynamic> messages = await msg;
      for (var message in messages) {
        _listMessage.add(Message.fromJson(message));
      }
    });
  }

  getMessage() {
    return _listMessage;
  }

  void connect() {
    _socket.connect();
  }

  chatMessage(idCourse, semeter) async {
    _socket.emit("messages", {"idCourse": idCourse, "semeter": semeter});
  }
}
