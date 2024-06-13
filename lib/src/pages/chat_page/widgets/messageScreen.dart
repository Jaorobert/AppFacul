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
          listMessages = messages.map((msg) => Message.fromJson(msg)).toList();
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            listMessages[index].message ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: AutofillHints.birthday),
                          ),
                          const SizedBox(height: 5.0),
                        ],
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
