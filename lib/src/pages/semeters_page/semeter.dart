import 'dart:ui';
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

class SemeterPage extends StatelessWidget {
  const SemeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      semetersService.getSemeters().then((values) => print(values));
    } catch (error) {
      print(error);
    }
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
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    side: const BorderSide(
                                        width: 0.523,
                                        color:
                                            Color.fromARGB(255, 59, 190, 63))),
                                child: const Center(
                                    child: Text("Engenharia de Software",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 85, 84, 84)))),
                              ),
                              const SizedBox(
                                height: 9,
                              ),
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
