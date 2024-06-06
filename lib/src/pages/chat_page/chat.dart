import 'dart:io';

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
  List messages = [];

  ChatState(
      {required this.socket, required this.idCourse, required this.semeter});

  upMessage() async {
    print("entouuuuuuuuuuuuuuuuu  aqiudjwakjdwkajdowajwjkapodkwapdkwpakdwalwk");
    print("O usuario é $idCourse a sala é $semeter");
    messages = await socket.chatMessage(idCourse, semeter);
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
      home: MessageListScreen(),
    );
  }
}

class MessageListScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
      text: 'Olá! Como você está?',
      dateTime: DateTime.now(),
    ),
    Message(
      text: 'Estou bem, obrigado!',
      dateTime: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Message(
      text: 'E você?',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  final List<Color> bubbleColors = [
    Colors.blue[100]!,
    Colors.blue[200]!,
    Colors.blue[300]!,
  ];

  MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mensagens',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(72, 92, 57, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final color = bubbleColors[index % bubbleColors.length];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${message.dateTime.hour}:${message.dateTime.minute} - ${message.dateTime.day}/${message.dateTime.month}/${message.dateTime.year}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime dateTime;

  Message({
    required this.text,
    required this.dateTime,
  });
}
