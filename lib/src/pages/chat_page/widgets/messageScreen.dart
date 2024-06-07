import 'package:app_facul/src/data/model/message.dart';
import 'package:app_facul/src/data/services/socket-service.dart';
import 'package:flutter/material.dart';

class MessageListScreen extends StatelessWidget {
  final List<Color> bubbleColors = [
    Colors.blue[100]!,
    Colors.blue[200]!,
    Colors.blue[300]!,
  ];
  final Socket socket;
  late final messages;

  MessageListScreen({super.key, required this.socket, this.messages});

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
                      messages.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${messages.dateTime.hour}:${messages.dateTime.minute} - ${messages.dateTime.day}/${messages.dateTime.month}/${messages.dateTime.year}',
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
