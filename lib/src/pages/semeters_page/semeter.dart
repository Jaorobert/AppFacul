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
import 'package:http/src/response.dart';
import 'package:app_facul/src/data/services/getSemeters.dart'
    as semetersService;
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLoading = false;
  var permissionsCoordination = false;

  @override
  void initState() {
    super.initState();
    _futureSemeters();
    _loadPermissions();
    socketService.socketInitialize();
  }

  _futureSemeters() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await semetersService.getSemeters();
      setState(() {
        _Semeters = data;
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      rethrow;
    }
  }

  Future<void> _loadPermissions() async {
    final shared = await SharedPreferences.getInstance();
    var isCoordination = shared.getBool('bo_coordenacao') ?? false;
    setState(() {
      permissionsCoordination = isCoordination;
    });
    didChangeDependencies();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (permissionsCoordination) {
      _navigateToChat();
    }
  }

  void _navigateToChat() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Chat(
          semeter: 5,
          idCourse: 1,
          socket: socketService,
          idUser: _Semeters[0].id_user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BuildContext? localContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Turma',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(72, 92, 57, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLoading) CircularProgressIndicator(),
                if (!isLoading)
                  SizedBox(
                    child: Center(
                      child: SizedBox(
                        width: 270,
                        height: 300,
                        child: ListView.builder(
                          itemCount: _Semeters.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () => {
                                    Navigator.of(localContext).push(
                                      MaterialPageRoute(
                                        builder: (context) => Chat(
                                          semeter: _Semeters[index].semestre,
                                          idCourse: _Semeters[index].id_curso,
                                          socket: socketService,
                                          idUser: _Semeters[index].id_user,
                                        ),
                                      ),
                                    )
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      const Color.fromRGBO(72, 92, 57, 1),
                                    ),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    side: const WidgetStatePropertyAll(
                                      BorderSide.none,
                                    ),
                                    padding: const WidgetStatePropertyAll(
                                      EdgeInsets.only(
                                        bottom: 15,
                                        top: 15,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "${_Semeters[index].ds_curso!.toLowerCase()} - ${_Semeters[index].semestre} sem",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            );
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
