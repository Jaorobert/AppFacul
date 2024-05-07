import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      dateTime: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    Message(
      text: 'E você?',
      dateTime: DateTime.now().subtract(Duration(hours: 2)),
    ),
  ];

  final List<Color> bubbleColors = [
    Colors.blue[100]!, // Azul claro
    Colors.blue[200]!, // Azul médio
    Colors.blue[300]!, // Azul escuro
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Mensagens'),
        backgroundColor:
            Colors.green, // Alterando a cor de fundo da AppBar para verde
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícone de seta para retornar
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final color = bubbleColors[index %
              bubbleColors.length]; // Alternando entre as cores da lista
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 8.0), // Adicionando espaçamento horizontal
            child: Align(
              alignment: Alignment.topLeft, // Alinhando as mensagens à esquerda
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                padding: EdgeInsets.all(8.0),
                width: double.infinity, // Ocupando toda a largura disponível
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
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${message.dateTime.hour}:${message.dateTime.minute} - ${message.dateTime.day}/${message.dateTime.month}/${message.dateTime.year}',
                      style: TextStyle(color: Colors.white70),
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
