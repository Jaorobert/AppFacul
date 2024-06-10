import 'dart:convert';

import 'package:app_facul/src/data/model/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class Socket extends ChangeNotifier {
  late IO.Socket _socket;
  late final List<Message> listMessage = [];

  Socket() {
    _socket = IO.io("http://192.168.237.68:4000",
        IO.OptionBuilder().setTransports(['websocket']).build());
  }

  void socketInitialize() {
    _socket.onConnect((_) => print("connected"));
    _socket.onConnectError((error) => print("Error $error"));
    _socket.onDisconnect((_) => print("disconected"));
  }

  IO.Socket get socket => _socket;

  void connect() {
    _socket.connect();
  }
}
