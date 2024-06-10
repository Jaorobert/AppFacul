import 'package:flutter/material.dart';

void main() {
  runApp(Chat());
}

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Mensagens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MessageListScreen(role: 'professor'), // Troque 'professor' por 'aluno' ou 'coordenador' para testar
    );
  }
}

class MessageListScreen extends StatelessWidget {
  final String role;
  final List<Message> messages = [
    Message(
      text: 'Olá! Como você está?',
      dateTime: DateTime.now(),
    ),
    Message(
      text: 'Estou bem, obrigado!',
      dateTime: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    Message(
      text: 'E você?',
      dateTime: DateTime.now().subtract(Duration(hours: 2)),
    ),
  ];

  MessageListScreen({required this.role});

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
      backgroundColor: Colors.grey[200], // Fundo cinza
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // Cor do balão
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
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
                            message.text,
                            style: const TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            '${message.dateTime.hour}:${message.dateTime.minute.toString().padLeft(2, '0')} - ${message.dateTime.day}/${message.dateTime.month}/${message.dateTime.year}',
                            style: const TextStyle(color: Colors.black54, fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (role == 'professor' || role == 'coordenador')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MessageInputWidget(),
            ),
        ],
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

class MessageInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Digite sua mensagem',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green, // Cor do botão alterada para verde
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Ação ao enviar a mensagem
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
