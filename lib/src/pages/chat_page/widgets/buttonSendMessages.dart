import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Envio de Mensagens'),
        ),
        body: MessageWidget(role: 'professor'), // Troque 'professor' por 'aluno' ou 'coordenador' para testar
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String role;

  MessageWidget({required this.role});

  @override
  Widget build(BuildContext context) {
    // Verifica o papel do usuário
    if (role == 'professor' || role == 'coordenador') {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(), // Placeholder para o espaço da lista de mensagens
            ),
            Row(
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
            ),
          ],
        ),
      );
    } else {
      // Retorna um widget vazio se o usuário não for professor ou coordenador
      return SizedBox.shrink();
    }
  }
}
