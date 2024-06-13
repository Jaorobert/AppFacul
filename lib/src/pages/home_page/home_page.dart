import 'package:flutter/material.dart';
import 'package:app_facul/src/pages/login_page/login.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext? localContext = context;
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(
                context,
                "Professor",
                () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(
                context,
                "Coordenação",
                () => Navigator.of(localContext).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(72, 92, 57, 1)),
        fixedSize: MaterialStateProperty.all<Size>(const Size(200, 60)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
