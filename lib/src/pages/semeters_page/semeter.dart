import 'dart:ui';
import 'package:app_facul/src/pages/login_page/login.dart';
import 'package:app_facul/src/pages/notificationsPage/notificationsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const SemeterPage());
}

class SemeterPage extends StatelessWidget {
  const SemeterPage({super.key});

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
                  const SizedBox(
                      height: 20), // Espaçamento entre o texto e o ListView
                  SizedBox(
                      width: 200,
                      height: 400,
                      child: Center(
                        child: SizedBox(
                          height: 300,
                          child: ListView(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(153, 192, 124, 1),
                                  ),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(200, 60),
                                  ),
                                ),
                                child: const Text(
                                  "Aluno",
                                  style: TextStyle(color: Colors.black),
                                ),
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
