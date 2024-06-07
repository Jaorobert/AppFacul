import 'dart:io';

import 'package:app_facul/src/pages/chat_page/widgets/messageScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_facul/src/data/services/socket-service.dart';

class Chat extends StatefulWidget {
  const Chat(
      {super.key,
      required this.idCourse,
      required this.semeter,
      required this.socket});

  final idCourse, semeter;
  final Socket socket;

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return ChatState(socket: socket, idCourse: idCourse, semeter: semeter);
  }
}

class ChatState extends State<Chat> {
  final Socket socket;
  final idCourse, semeter;

  ChatState(
      {required this.socket, required this.idCourse, required this.semeter});

  upMessage() async {
    await socket.chatMessage(idCourse, semeter);
  }

  @override
  void initState() {
    super.initState();
    upMessage();
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
      ),
    );
  }
}
