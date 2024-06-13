import 'dart:io';

import 'package:app_facul/src/data/model/message.dart';
import 'package:app_facul/src/pages/chat_page/widgets/buttonSendMsg.dart';
import 'package:app_facul/src/pages/chat_page/widgets/messageScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_facul/src/data/services/socket-service.dart' as Socket;
import 'package:socket_io_client/socket_io_client.dart';
import "package:shared_preferences/shared_preferences.dart";

class Chat extends StatefulWidget {
  const Chat({
    super.key,
    required this.idCourse,
    required this.semeter,
    required this.socket,
    required this.idUser,
  });

  final idCourse, semeter, idUser, socket;

  @override
  State<StatefulWidget> createState() {
    return ChatState(
      socket: socket,
      idCourse: idCourse,
      semeter: semeter,
      idUser: idUser,
    );
  }
}

class ChatState extends State<Chat> {
  final idCourse, semeter, idUser, socket;
  List<Message> listMessages = [];

  ChatState({
    required this.socket,
    required this.idCourse,
    required this.semeter,
    required this.idUser,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mensagens',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(72, 92, 57, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: MessageListScreen(
        socket: socket,
        idCourse: idCourse,
        semeter: semeter,
        idUser: idUser,
      ),
    );
  }
}
