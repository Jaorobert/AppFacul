import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final socket, idCourse, semeter, idUser;

  MessageWidget(
      {required this.socket,
      required this.idCourse,
      required this.semeter,
      required this.idUser});

  sendMessage(String message) async {
    socket.socket.emit('inMessage', {
      'idCourse': idCourse,
      'semeter': semeter,
      'idUser': idUser,
      'message': message
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 20, 0),
                        child: TextFormField(
                          autocorrect: true,
                          controller: _messageController,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.green, // Cor do botão alterada para verde
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () => {
                          sendMessage(_messageController.text),
                          _messageController.clear()
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
