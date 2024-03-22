import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notificações UNICV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotPage(),
    );
  }
}

class NotPage extends StatefulWidget {
  @override
  _NotPageState createState() => _NotPageState();
}

class _NotPageState extends State<NotPage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  void _editText(int index, String text) {
    if (index == 1) {
      setState(() {
        _controller1.text = text;
      });
    } else if (index == 2) {
      setState(() {
        _controller2.text = text;
      });
    }
  }

  void _clearText(int index) {
    if (index == 1) {
      setState(() {
        _controller1.clear();
      });
    } else if (index == 2) {
      setState(() {
        _controller2.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações UNICV'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller1,
                    decoration: InputDecoration(
                      labelText: 'Mensagem 1:',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _editText(1, _controller1.text);
                  },
                  child: Text('Editar'),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller2,
                    decoration: InputDecoration(
                      labelText: 'Mensagem 2:',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    _editText(2, _controller2.text);
                  },
                  child: Text('Editar'),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
