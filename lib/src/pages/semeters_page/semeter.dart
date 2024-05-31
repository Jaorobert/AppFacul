import 'dart:async';
import 'dart:ui';
import 'package:app_facul/src/model/semeters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/src/response.dart';
import '../../services/getSemeters.dart' as semetersService;

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
  List<Semeter> _Semeters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _futureSemeters();
  }

  _futureSemeters() async {
    try {
      final data = await semetersService.getSemeters();
      setState(() {
        _Semeters = data;
        _isLoading = false;
      });
    } catch (err) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  const Text(
                    "Turma",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300),
                  ),
                  //const SizedBox(height: 20),

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
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                      side: const MaterialStatePropertyAll(
                                          BorderSide.none),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.only(
                                        bottom: 15,
                                        top: 15,
                                      ))),
                                  child: Text(
                                    "${_Semeters[index].ds_curso!.toLowerCase()} - ${_Semeters[index].semestre.toString()} sem",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () => {},
                                ),
                              ),
                            );
                          }),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
