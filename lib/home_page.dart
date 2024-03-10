import 'package:app_facul/navBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: NavBar(),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/imgs/logo-unicv.png'),
                fit: BoxFit.contain,
                opacity: 0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "UniCV Recados",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color.fromARGB(255, 57, 153, 61),
                    decoration: TextDecoration.none),
              ),
              Center(
                  child: Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.bottomCenter,
                      height: 300,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Color.fromARGB(255, 6, 231, 25)
                                          .withOpacity(0.5);
                                    }
                                    return Colors.white.withOpacity(1);
                                  }),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(200, 60))),
                              child: const Text("Aluno"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Color.fromARGB(255, 6, 231, 25)
                                          .withOpacity(0.5);
                                    }
                                    return Colors.white.withOpacity(1);
                                  }),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(200, 60))),
                              child: const Text("Professor"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Color.fromARGB(255, 6, 231, 25)
                                          .withOpacity(0.5);
                                    }
                                    return Colors.white.withOpacity(1);
                                  }),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(200, 60))),
                              child: const Text("Coordenacao"),
                            ),
                          ])))
            ],
          ),
        ));
  }
}
