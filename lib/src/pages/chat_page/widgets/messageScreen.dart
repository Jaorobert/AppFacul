// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:app_facul/src/data/model/message.dart';
import 'package:app_facul/src/data/model/semeters.dart';
import 'package:app_facul/src/data/services/socket-service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MessageListScreen extends StatefulWidget {
  final socket;
  final idCourse, semeter, idUser;
  const MessageListScreen(
      {super.key,
      required this.socket,
      this.idCourse,
      this.semeter,
      this.idUser});

  @override
  State<MessageListScreen> createState() {
    return MessageState(
        socket: socket, idCourse: idCourse, semeter: semeter, idUser: idUser);
  }
}

class MessageState extends State<MessageListScreen> {
  final List<Color> bubbleColors = [
    Colors.blue[100]!,
    Colors.blue[200]!,
    Colors.blue[300]!,
  ];
  final socket;
  List<Message> listMessages = [];
  final idCourse, semeter, idUser;
  final message = TextEditingController();

  MessageState(
      {required this.socket,
      required this.idCourse,
      required this.semeter,
      required this.idUser});

  chatMessage(idCourse, semeter) async {
    socket.socket.emit("messages", {"idCourse": idCourse, "semeter": semeter});

    socket.socket.on("messages", (msg) async {
      try {
        List<dynamic> messages = await msg;
        setState(() {
          listMessages = messages.map((msg) => Message.fromJson(msg)).toList();
        });
      } catch (error) {
        return print(error);
      }
    });
  }

  sendMessage(String message) async {
    socket.socket.emit('inMessage', {
      'idCourse': idCourse,
      'semeter': semeter,
      'idUser': idUser,
      'message': message
    });
  }

  @override
  void initState() {
    super.initState();
    chatMessage(idCourse, semeter);
    socket.socket.on(
        'outMessage',
        (data) => {
              setState(() {
                listMessages.add(Message.fromJson(data));
              })
            });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: listMessages.length,
            itemBuilder: (context, index) {
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
                          listMessages[index].message ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
          Row(children: [
            Expanded(
                child: TextFormField(
              controller: message,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Informe o nome',
              ),
            )),
            ElevatedButton(
                onPressed: () => {sendMessage(message.text), message.clear()},
                child: const Text('Enviar'))
          ])
        ],
      ));
}
