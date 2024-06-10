import 'dart:io';

import 'package:app_facul/src/data/model/message.dart';
import 'package:app_facul/src/pages/chat_page/widgets/messageScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_facul/src/data/services/socket-service.dart' as Socket;
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  runApp(const Chat(idCourse: 1, semeter: 5, socket: Socket.Socket, idUser: 1));
}

class Chat extends StatefulWidget {
  const Chat(
      {super.key,
      required this.idCourse,
      required this.semeter,
      required this.socket,
      required this.idUser});

  final idCourse, semeter, idUser;
  final socket;

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return ChatState(
        socket: socket, idCourse: idCourse, semeter: semeter, idUser: idUser);
  }
}

class ChatState extends State<Chat> {
  final socket;
  final idCourse, semeter, idUser;
  List<Message> listMessages = [];

  ChatState(
      {required this.socket,
      required this.idCourse,
      required this.semeter,
      required this.idUser});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lista de Mensagens',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MessageListScreen(
          socket: socket,
          idCourse: idCourse,
          semeter: semeter,
          idUser: idUser,
        ));
  }
}
