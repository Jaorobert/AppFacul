import 'dart:io';
import 'package:intl/intl.dart';
import 'package:app_facul/src/data/model/message.dart';
import 'package:app_facul/src/pages/chat_page/widgets/buttonSendMsg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // ignore: no_logic_in_create_state
    return MessageState(
        socket: socket, idCourse: idCourse, semeter: semeter, idUser: idUser);
  }
}

class MessageState extends State<MessageListScreen> {
  final List<Color> bubbleColors = [
    Colors.yellow[100]!,
    Colors.yellow[200]!,
  ];
  // ignore: prefer_typing_uninitialized_variables
  final socket;
  List<Message> listMessages = [];
  // ignore: prefer_typing_uninitialized_variables
  final idCourse, semeter, idUser;
  final message = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var permissions;
  MessageState(
      {required this.socket,
      required this.idCourse,
      required this.semeter,
      required this.idUser});

  Future<void> _loadPermissions() async {
    final shared = await SharedPreferences.getInstance();
    var isTeacher = shared.getBool('bo_professor') ?? false;
    var isCoordination = shared.getBool('bo_coordenacao') ?? false;

    setState(() {
      permissions = [isTeacher, isCoordination];
    });
  }

  chatMessage(idCourse, semeter) async {
    socket.socket.emit("messages", {"idCourse": idCourse, "semeter": semeter});

    socket.socket.on("messages", (msg) async {
      try {
        List<dynamic> messages = await msg;
        setState(() {
          listMessages = messages.map((m) => Message.fromJson(m)).toList();
        });
      } catch (error) {
        return print(error);
      }
    });
  }

  void _handleMessage(data) {
    setState(() {
      listMessages.add(Message.fromJson(data));
    });
  }

  @override
  void initState() {
    super.initState();
    chatMessage(idCourse, semeter);
    socket.socket.on('outMessage', _handleMessage);
    _loadPermissions();
  }

  @override
  void dispose() {
    socket.socket.off('outMessage', _handleMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listMessages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4.0,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 285,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      listMessages[index].name ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      listMessages[index].message ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Arial',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.2),
                              child: Text(
                                "${listMessages[index].createdAt?.hour}:${listMessages[index].createdAt?.minute}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (permissions != null && (permissions[0] || permissions[1]))
              SizedBox(
                  width: 379,
                  height: 63,
                  child: MessageWidget(
                    idUser: idUser,
                    idCourse: idCourse,
                    semeter: semeter,
                    socket: socket,
                  )),
          ],
        ),
      );
}
