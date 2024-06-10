import 'dart:async';
import 'dart:ui';
import 'package:app_facul/src/data/model/semeters.dart';
import 'package:app_facul/src/data/services/socket-service.dart';
import 'package:app_facul/src/pages/chat_page/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:app_facul/src/data/services/getSemeters.dart' as semetersService;

void main() {
  runApp(const SemeterPage());
}

class SemeterPage extends StatefulWidget {
  const SemeterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SemetersState();
  }
}

class _SemetersState extends State<SemeterPage> {
  final Socket socketService = Socket();
  List<Semeter> _Semeters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _futureSemeters();
    socketService.socketInitialize();
  }

  _futureSemeters() async {
    try {
      final data = await semetersService.getSemeters();
      setState(() {
        _Semeters = data;
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Semestre"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imgs/logo-unicv.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(),
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Olá, Pedro!",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 500,
                          height: 300,
                          child: ListView.builder(
                            itemCount: _Semeters.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromRGBO(72, 92, 57, 1)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      side: const MaterialStatePropertyAll(
                                          BorderSide.none),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.only(
                                        bottom: 15,
                                        top: 15,
                                      )),
                                    ),
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chat(
                                            semeter:
                                                _Semeters[index].semestre,
                                            idCourse:
                                                _Semeters[index].id_curso,
                                            socket: socketService,
                                            idUser: _Semeters[index].id_user,
                                          ),
                                        ),
                                      )
                                    },
                                    child: Text(
                                      "${_Semeters[index].ds_curso!.toLowerCase().split(' ').map((String word) => word.replaceFirst(word[0], word[0].toUpperCase())).join(' ')} - ${_Semeters[index].semestre.toString()} sem",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black,
                            ),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Adicione a ação desejada para o botão aqui
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              "Chat UniCV",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
