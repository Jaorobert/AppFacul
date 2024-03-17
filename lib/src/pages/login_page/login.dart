import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:app_facul/src/repositories/api_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final form = GlobalKey<FormState>();
  final controleEmail = TextEditingController();
  final controleSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(
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
              const SizedBox(height: 20),
              Form(
                  key: form,
                  child: Column(children: [
                    TextFormField(
                        controller: controleEmail,
                        decoration: const InputDecoration(
                          labelText: "RA ou E-mail",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        }),
                    TextFormField(
                      controller: controleSenha,
                      decoration: const InputDecoration(
                          labelText: "Senha:",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          )),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (!form.currentState!.validate()) {
                          return;
                        }

                        form.currentState!.save();
                        LoginRepository.enviarAluno({
                          'email': controleEmail.text,
                          'password': controleSenha.text,
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(72, 92, 57, 1),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150, 35),
                        ),
                      ),
                      child: const Text(
                        "Entrar",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ])),
              const SizedBox(height: 20),
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
