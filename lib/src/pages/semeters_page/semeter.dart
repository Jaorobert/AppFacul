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

Widget generateButton(dsCurso) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5, top: 5),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          side: const BorderSide(
              width: 0.523, color: Color.fromARGB(255, 59, 190, 63))),
      child: Center(
          child: Text(dsCurso,
              style: const TextStyle(color: Color.fromARGB(255, 85, 84, 84)))),
    ),
  );
}

class SemeterPage extends StatelessWidget {
  const SemeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    semeters() async => await semetersService.getSemeters();

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
                  const SizedBox(
                      height: 20), // Espaçamento entre o texto e o ListView
                  SizedBox(
                      width: 230,
                      height: 300,
                      child: Center(
                        child: SizedBox(
                          height: 300,
                          child: ListView(
                            children: [
                              generateButton(semeters().then(
                                  (List<Semeter> listSemeter) => {
                                        listSemeter.map((data) => data.ds_curso)
                                      }))
                            ],
                          ),
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
