import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            left: 40,
            right: 40,
          ),
          child: ListView(
            children: [
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset('assets/imgs/logo-unicv.png'),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "RA ou E-mail",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    )),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Senha:",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    )),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(72, 92, 57, 1),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(200, 60),
                  ),
                ),
                child: const Text(
                  "Entrar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => (context),
                child: const Text('Esqueci a senha.'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
