import 'package:flutter/material.dart';
import 'package:app_facul/src/pages/login_page/login.dart';
import 'package:app_facul/src/pages/notificationsPage/notificationsPage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/fachada.jpg'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "UniCV Recados",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Color.fromRGBO(72, 92, 57, 1),
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 50),
              _buildButton(
                context,
                "Aluno",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(
                context,
                "Cadastrar Aluno",
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => RegisterStudentPage()),
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(
                context,
                "Professor",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(
                context,
                "Coordenação",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromRGBO(72, 92, 57, 1)),
        fixedSize: MaterialStateProperty.all<Size>(const Size(200, 60)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          Center(
              child: Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  child: Column(children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
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
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(153, 192, 124, 1),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(200, 60),
                        ),
                      ),
                      child: const Text(
                        "Professor",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NotPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(153, 192, 124, 1),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(200, 60),
                        ),
                      ),
                      child: const Text(
                        "Coordenacao",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ])))
        ],
      )),
    ));
  }
}
